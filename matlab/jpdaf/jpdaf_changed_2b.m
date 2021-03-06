clc;clear all;close all;

%Starting parameters

%count of steps
n=50;

%delta_time
T=1;

%number of Monte Carlo runs
MC_number=15;

%start position (x, y, vx, vy)
target_position=[150 30 100 80; 
                 50 40 10 30]; 
				 



%dimensions
c=2;

g_sigma=9.21;                                                                     
lambda=2; 
gamma=lambda*10^(-6); 

%jpdaf parameters

%Probability of detection
Pd=1;

%Probability of observation falling within gate
Pg=0.99; 

%Noise vector
target_delta=[200 20]; 

P1=[target_delta(1)^2 0 0 0;
                    0 0.01 0 0;
                    0 0 target_delta(1)^2 0;
                     0 0 0 0.01]; 

P=zeros(4,4,c); 
P(:,:,1)=P1;
P(:,:,2)=P1;

%For Gaussian random
mu = 0;
sigma = 10;

%	Tracking parameters
% X(k+1)=A*X(k) + G*w(k) (constant velocity
%model)

A = [1 T 0 0;
     0 1 0 0;
     0 0 1 T;
     0 0 0 1];  
 
	 

%Gaussian noise evolution matrix
G=[T^2/2 0;
       T 0;
       0 T^2/2;
       0 T];
	   
Q=[50 0;
   0 50]; 

	   
%measurement parameters 

% Y(k)=C*X(k) + v(k)
C = [1 0 0 0;
     0 0 1 0];
 
R=[target_delta(1)^2 0;
    0 target_delta(1)^2]; 
	


x_filter=zeros(4,c,n);
x_filter1=zeros(4,c,n,MC_number);  

data_measurement=zeros(c,2,n);                                                     
data_measurement1=zeros(c,4,n); 


%Generating tracks

data_measurement1(:,:,1)=target_position;

for i=1:c
	for ii=2:n                                                                      
        data_measurement1(i,:,ii)=(A*data_measurement1(i,:,ii-1)')'+(G*sqrt(Q)*(randn(2,1)))'; 
    end
end



% Multitracking problem
for M=1:MC_number
	%Process of measurement
	Noise=[];
	%generating observations
	for i=1:n
		for j=1:c                                                                     
            data_measurement(j,1,i)=data_measurement1(j,1,i)%+randn(1)*target_delta(j);
            data_measurement(j,2,i)=data_measurement1(j,3,i)%+randn(1)*target_delta(j); 
        end
    end
	
	S=zeros(2,2,c);
    Z_predic=zeros(2,2);                                                               
    x_predic=zeros(4,2);                                                               
    ellipse_Volume=zeros(1,2);
    NOISE_sum_a=[];                                                                    
    NOISE_sum_b=[]; 
	

	%using JPDAF for observations
	for t=1:n
		y1=[];
		y=[];
		Noise=[];
		NOISE=[];
		
		%Fixed i-th track run process tracking
		for i=1:c
			
			%Prediction
			if t~=1
				x_predic(:,i) = A*x_filter(:,i,t-1); 
			else
				x_predic(:,i)=target_position(i,:)';
			end
			
			%% Kalman filter
			%   P(k|k-1)
			P_predic=A*P(:,:,i)*A'+G*Q*G';
			
			%Predicted measurement
			Z_predic(:,i)=C*x_predic(:,i);
			
			% Error covariance matrix
			R=[target_delta(i)^2 0; 
            0 target_delta(i)^2];
			
			S(:,:,i)=C*P_predic*C'+R
			
			
         
			%Calculation of validation gate
			%Volume VG: we are in 2D
			ellipse_Volume(i)=pi*g_sigma*sqrt(det(S(:,:,i)));  
			number_returns=floor(ellipse_Volume(i)*gamma+1);                               
			side=sqrt((ellipse_Volume(i)*gamma+1)/gamma)/2; 
			
			%Add the NOISE predictions:
			Noise_x=x_predic(1,i)+side-2*randn(1,number_returns)*side;                      
			Noise_y=x_predic(3,i)+side-2*randn(1,number_returns)*side;    
			Noise=[Noise_x;Noise_y];
			NOISE=[NOISE Noise];
			
			if i==1
				NOISE_sum_a=[NOISE_sum_a Noise];
			else
				NOISE_sum_b=[NOISE_sum_b Noise];
			end
			
		end
		
		%Process of 2 tracks together
        b=zeros(1,2);
        b(1)=data_measurement(1,1,t);   %x
        b(2)=data_measurement(1,2,t);   %y
		
		%Add the correct measurement for Track 1
        y1=[NOISE b'];    
		b(1)=data_measurement(2,1,t);
        b(2)=data_measurement(2,2,t);
        y1=[y1 b']; 
		
		m1=0;                                                                          
        [n1,n2]=size(y1);
        Q1=zeros(100,3);
		
		for j=1:n2 
            flag=0;
			
			%Verification that Zj is the gate of Validation of Xi -> VG( Xi )
            for i=1:c
                d=y1(:,j)-Z_predic(:,i);                                              
                D=d'*inv(S(:,:,i))*d;                                                 
                
                if D<=g_sigma                                                                                                            
                   flag=1;
                   %Can be ovbservation m1 generated by clutter?
                   Q1(m1+1,1)=1;   
                   %Can be observation m1 generated by track 1?
                   Q1(m1+1,i+1)=1;
                end
                
            end
			
			%If Zj belongs to VG(X1) or VG(X2)
            if flag==1   
               y=[y y1(:,j)]; 
               %Is m1 the index of observations that are in the Validation?
               %Gate and published iteratively in y
               m1=m1+1;                                                            
            end
			
		end
		
		%Will Q2 contain only suitable measures?
        % Matrix m1 x 3 --> Measures on the rows - target columns
        Q2=Q1(1:m1,1:3);                        
		
		    %   Generating possible matrix associations starting from
			%   Suitable measures
			%
			%       num: Total mumber of matrix       
			%
			%       A_matrix: Matrix (m1 x 3 x 100) of all possible
			%                 Associations where:
			%                 m1 -> number of suitable measures
			%                 3  -> total number of track (1:clutter) (2-3: tracks)
			%                 10000 -> maximum number of suitable assotiations
			%                         generation of matrix Q2 according to
			%                         procedure described in article
		
		A_matrix=zeros(m1,3,10000);
		
		A_matrix(:,1,1:10000)=1;
		
		%If there permitted measures
        if m1~=0 
           %Counter of possible associations
           num=1;
           % Procedure of generating assotiations matrix:
           %
           % 1) Reading for extracting the rows of first element 1
           for i=1:m1
				if Q2(i,2)==1                                                              
                    A_matrix(i,2,num)=1;
                    A_matrix(i,1,num)=0;                                
                    num=num+1;
                    %Reading
                    for j=1:m1                                                              
                        if (i~=j) & (Q2(j,3)==1)
                            A_matrix(i,2,num)=1;
                            A_matrix(i,1,num)=0;
                            A_matrix(j,3,num)=1;
                            A_matrix(j,1,num)=0;
                            num=num+1;
                        end
                    end
                end
            end              
			
			
			for i=1:m1
                if Q2(i,3)==1
                    A_matrix(i,3,num)=1;
                    A_matrix(i,1,num)=0;
                    num=num+1;
                end
            end
			
		else
            %No measures allowed
            flag=1;
        end
	
	
	    %Generation of all possible assotiations
        A_matrix=A_matrix(:,:,1:num);
		
		    %%%  For each event assotiations calculation:
			%       
			%            k         k-1 
			%       P(  Y  | X ,  Y    ): Probability of observations of measurement
			%
			%      
			%                     k-1 
			%       P( X | m  ,  Y    ):  Priority of observed measures
			%
			%    estimate A posteriori: 
			%
			%                    k  
			%       P(  X  |   Y    ): Estimation of the state of A posteriori
		
		Pr=zeros(1,num);
		
		%Considering possibility of matrix assotiations
		for i=1:num
			%All measurements can be false alarms 
			False_num=m1;
			N=1;
			
			%% Fixed event associations and its matrix associations  
			%  For each measurement j going to calculate:
			%
			%       - Measurement associations indicator  - tau(j,X)
			%
			%       - Target detection indicator - lambda(t,X)
			%
			
			for j=1:m1
				%Calculating the measurement associations indicator for event
				%Association Xi (fixed j and high on all the Track (2-3))
				
				mea_indicator=sum(A_matrix(j,2:3,i));
				
				if mea_indicator==1 
				%Considering what the track measure was associating
                
                %Update FM(X):  Total number of wrong measures in X
                False_num=False_num-1;
				
				%Individual to which of the 2 tracks measurement j e associated
                %Comparing association for probability X and calculation:
                %
                %                  k-1 
                % P(  yj | Xjt ,  Y    )
                if A_matrix(j,2,i)==1   % Xjt                                               
                    b=(y(:,j)-Z_predic(:,1))'*inv(S(:,:,1))*(y(:,j)-Z_predic(:,1));    
                    N=N/sqrt(det(2*pi*S(:,:,1)))*exp(-1/2*b);                                                  
                else                                                                   
                    b=(y(:,j)-Z_predic(:,2))'*inv(S(:,:,2))*(y(:,j)-Z_predic(:,2));
                    N=N/sqrt(det(2*pi*S(:,:,2)))*exp(-1/2*b);                                                   
                end         
				
			end
		end
		
		
		%Calculating the total volume of validation gate
        V=ellipse_Volume(1)+ellipse_Volume(2); 
        LikelyHood=N/(V^False_num);
		
		
		%       P( X | m  ,  Y    ):  priority of observed measures
		
		if Pd==1
            Prior=1;
        else
            Prior=1;
		for j=1:c
                %Target partial indicator: high only
                target_indicator=sum(A_matrix(:,j+1,i));                               
                
                Prior=Prior*(Pd^target_indicator)*(1-Pd)^(1-target_indicator);                   
            end
        end 
		
		
		%Calculating the number of events in X for which the same set of
        % targets founded:
        %
        %   m           m!
        % P         =  ----               
        %  m-FM(X)     FM(m)!
        %
        % Calcolo   FM(m)!
        a1=1;
        for j=1:False_num
            a1=a1*j;
        end
		
			Pr(i)=a1*LikelyHood*Prior;
		end
		
		Pr=Pr/sum(Pr);
		
		
		%%%  Calculation of coefficients Beta (j, t)
		BeTa=zeros(m1+1,c);
		for i=1:c
			for j=1:m1
				for k=1:num
					BeTa(j,i)=BeTa(j,i)+Pr(k)*A_matrix(j,i+1,k);
				end
			end
		end
		%Calculation of Beta (0, t) -> last position Beta (j, t)
		BeTa(m1+1,:)=1-sum(BeTa(1:m1,1:c));                  


		%%%  Kalman prediction for 2 filters
		
		
		for i=1:c 
			%Predicted error covariance matrix
			%P(k|k-1)
			P_predic = A*P(:,:,i)*A'+G*Q*G';
			K(:,:,i)= P_predic*C'*inv(S(:,:,i));
			%Update of the covariance matrix: missing Term Pk that depends
			% the combined innovation
			P(:,:,i)= P_predic-(1-BeTa(m1+1,i))*K(:,:,i)*S(:,:,i)*K(:,:,i)';
		end
		
		
		%%%  Kalman update for 2 filters
		
		for i=1:c
			a=0;         
			Pk=0;
        
			x_filter2=0;    
        
			for j=1:m1
				a=x_predic(:,i)+ K(:,:,i)*(y(:,j)- Z_predic(:,i));
            
				x_filter2=x_filter2+BeTa(j,i)*(a);
				
			end
			
			        %Adding the factor Beta0
			x_filter2=BeTa(m1+1,i)*x_predic(:,i) + x_filter2;
			x_filter(:,i,t)=x_filter2;
        
			a=0;
			for j=1:m1+1
				if j==m1+1
					%Case of association to clutter
					a=x_predic(:,i);
				else
					%Case of association track
                
					a=x_predic(:,i)+ K (:,:,i)*(y(:,j)- Z_predic(:,i));
				end
            
				Pk=Pk+BeTa(j,i)*(a*a'-x_filter2*x_filter2');
			end
			
			%Update of the covariance matrix: missing Pk
			%P(:,:,i)=P(:,:,i)+b; 
        
			x_filter1(:,i,t,M)=x_filter(:,i,t);   
		end
		
	end
end

%%%%%  Middle value of simulations
x_filter=sum(x_filter1,4)/MC_number; 


%%%  1.Visualization


%Drawing TRACK 1
a=zeros(1,n);
b=zeros(1,n);
for i=1:n
    a(i)=data_measurement1(1,1,i);
    b(i)=data_measurement1(1,3,i);
end
plot(a,b, '--b', 'LineWidth', 2 ); % Actual Trajectory 1
hold on;

%Drawing TRACK 2
a=zeros(1,n);
b=zeros(1,n);
for i=1:n
    a(i)=data_measurement1(2,1,i);
    b(i)=data_measurement1(2,3,i);
end
plot(a,b,'--r', 'LineWidth', 2 ); % Actual Trajectory 2
    % 
for i=1:c
	a=zeros(1,n);
	b=zeros(1,n);
	for j=1:n
		a(j)=data_measurement(i,1,j);
		b(j)=data_measurement(i,2,j);
	end
        if i==1
           plot(a(:),b(:), 'ob', 'MarkerSize', 8 ); % modeled Sensor Data 1
        else 
           plot(a(:),b(:), 'sr', 'MarkerSize', 8 ); % modeled Sensor Data 2
        end
	hold on;
end
	
for i=1:c
    a=zeros(1,n);
    b=zeros(1,n);
    for j=1:n
        a(j)=x_filter(1,i,j);
        b(j)=x_filter(3,i,j);
    end
    if i==1
        plot(a(:),b(:), '-b', 'LineWidth', 2 ); % Reconstructed Trajectory 1
    else 
        plot(a(:),b(:), '-r', 'LineWidth', 2 ); % Reconstructed Trajectory 2
    end
	hold on;
end

xlabel( 'X coordinate', 'FontSize', 20 );
ylabel( 'Y coordinate', 'FontSize', 20 );
title( 'Trajectories of 2 Objects', 'FontSize', 24 );

legend('Actual Traj. 1','Actual Traj. 2','Sensor Data 1', 'Sensor Data 2', ...
    'Reconstructed Traj. 1', 'Reconstructed Traj. 2', 4);
grid on;

	