function  JPDAF(target_position,n,T,MC_number,c)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function  PDAF(target_position,n,T,MC_number)
% Parameters :
%           -target_position:  Starting Point
%           - n:  Number of evolutions 
%           - T:  starting time 
%           - MC_number: Number of simulations
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
Pd=1;                                                                               
Pg=0.99;                                                                            
g_sigma=9.21;                                                                     
lambda=2; 
gamma=lambda*10^(-6); 

%Measurements of Target
Target_measurement=zeros(c,2,n); 

%Noise vector
target_delta=[100 100];                                                                                
P=zeros(4,4,c);                                                                    
P1=[target_delta(1)^2 0 0 0;
                    0 0.01 0 0;
                    0 0 target_delta(1)^2 0;
                     0 0 0 0.01];        
P(:,:,1)=P1;
P(:,:,2)=P1;

%% State of process
%
% X(k+1)=A*X(k) + G*w(k)
%
% A:        Matrix of transition of state
% X(k):     State of the previous time
% G:        Evolutionary matrix of noise
% w(k):     Noise of process ( Gaussian --> N(0,Q) )
%Matrix of transition of state
A = [1 T 0 0;
     0 1 0 0;
     0 0 1 T;
     0 0 0 1];  
 
%Covariance matrix associated with the process of evolution
Q=[4 0;
   0 4];                                                  

% Associated matrix that determines the evolution of the noise in Time
G=[T^2/2 0;
       T 0;
       0 T^2/2;
       0 T];
%% Process of measurment
%
% Y(k)=C*X(k) + v(k)
%
% C:        Matrix that binds to the state observation
% X(k):     State at the current time
% v(k):     Noise measure ( Gaussian --> N(0,R) )

%Matrix of relationship between state and observation
%nb:
%
% C*X(k)= [X(k,1) X(k,3)] has zero components vx and vy
C = [1 0 0 0;
     0 0 1 0];
%Covariance matrix associated with the process of measurement 
R=[target_delta(1)^2 0;
    0 target_delta(1)^2]; 

% Matrix c (track number) x 2 (number features) xn (number measures):
% will contain 'it was rebuilt
x_filter=zeros(4,c,n); 
% Samples generated for the current state
x_filter1=zeros(4,c,n,MC_number);     

% Matrix c (track number) x 2 (number features) xn (number measures)
data_measurement=zeros(c,2,n);                                                     
data_measurement1=zeros(c,4,n);                                                    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generating  2 Traces to reconstructing evolving system
% dynamically using the starting point target_position
%
% True state
data_measurement1(:,:,1)=target_position;                                           
%TRACKS 1 - 2
for i=1:c
    %Evolving the state of system
    for ii=2:n                                                                      
        data_measurement1(i,:,ii)=(A*data_measurement1(i,:,ii-1)')'+(G*sqrt(Q)*(randn(2,1)))'; 
        
    end
end
%Drawing the TRACK 1
a=zeros(1,n);
b=zeros(1,n);
for i=1:n
    a(i)=data_measurement1(1,1,i);
    b(i)=data_measurement1(1,3,i);
end
plot(a,b,'b-');
hold on;

%Drawing the TRACK 2
a=zeros(1,n);
b=zeros(1,n);
for i=1:n
    a(i)=data_measurement1(2,1,i);
    b(i)=data_measurement1(2,3,i);
end
plot(a,b,'r-');
xlabel('x(m)'),ylabel('y(m)');
legend('Track 1','Track2',1);
grid;

%%%%%%%%%%%%%%%%%%%%%%
% Multitracking problem 
for M=1:MC_number
    %%%%%%%%%%%%%%%%%%%%    
    %%%  1.  Process of measurement
    %
    %
    %%%%%%%%%%%%%%%%%%%%
    Noise=[];
    %Generate 50 measurements starting from true state of the process
    %measurement 
    for i=1:n
        %Fixed the TRACE j-th and generatng observations
        for j=1:c                                                                     
            data_measurement(j,1,i)=data_measurement1(j,1,i)+rand(1)*target_delta(j);
            data_measurement(j,2,i)=data_measurement1(j,3,i)+rand(1)*target_delta(j); 
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  2. Through the measures I can rebuild original tracks
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    S=zeros(2,2,c);
    Z_predic=zeros(2,2);                                                               
    x_predic=zeros(4,2);                                                               
    ellipse_Volume=zeros(1,2);
    NOISE_sum_a=[];                                                                    
    NOISE_sum_b=[];  

for t=1:n
    y1=[];
    y=[];
    Noise=[];
    NOISE=[];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Fixed i-th track run process tracking:
    % Reconstructing the trajectory (x, y) through PDA
    %  
    % 1) Generating multiple observations of y
    % 2) Filter of observations of y through gate gsigma
    % 3) Applying the Probabilistic Data Association
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    for i=1:c      
        %% Generating multiple observations  (along y) to which to apply PDA
        % Process of prediction and updating of Bayesian filtering
        % Evolution of state without Gaussian noise
        if t~=1
            % Evolution of system's state
            %Prediction of the State
            x_predic(:,i) = A*x_filter(:,i,t-1);                                        
        else
            %The starting position is real state in step 1
            %Prediction of the State
            x_predic(:,i)=target_position(i,:)';                                        
        end
        %% Kalman filter
        %   Predicted error covariance matrix
        %   P(k|k-1)
        P_predic=A*P(:,:,i)*A'+G*Q*G';                                                  
        
        %Predicted measurement 
        Z_predic(:,i)=C*x_predic(:,i);                                                  
        
        % Error covariance matrix of which varies over time
        R=[target_delta(i)^2 0; 
            0 target_delta(i)^2];
        
        %Covariance matrix error size: S (k)
        S(:,:,i)=C*P_predic*C'+R;                                                       
        
        %% Generation multiple remarks to be filtered through the gate validation
         
        %Calculation of validation gate
        %
        %Volume VG: we are in 2D
        ellipse_Volume(i)=pi*g_sigma*sqrt(det(S(:,:,i)));  
        number_returns=floor(ellipse_Volume(i)*gamma+1);                               
        side=sqrt((ellipse_Volume(i)*gamma+1)/gamma)/2;   
        
        %Add the NOISE predictions:
        Noise_x=x_predic(1,i)+side-2*rand(1,number_returns)*side;                      
        Noise_y=x_predic(3,i)+side-2*rand(1,number_returns)*side;    
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
        %Add the correct measurement for Track 1
        b(1)=data_measurement(2,1,t);
        b(2)=data_measurement(2,2,t);
        y1=[y1 b']; 
        %??????????????
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%  Extracting measures validation in gate: meaasures
        %%%  Permit for the second track in the example
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        m1=0;                                                                          
        [n1,n2]=size(y1);
        Q1=zeros(100,3); 
        %Number of observations
        for j=1:n2 
            flag=0;
            %Considering track's i-th and j-th and Measurement
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
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        A_matrix=zeros(m1,3,10000);
        %All measurements can be generated from the Track Clutter
        A_matrix(:,1,1:10000)=1;
        
        %If there permitted measures
        if m1~=0 
           %Counter of possible associations
           num=1;
           % Procedure of generating assotiations matrix:
           %
           % 1) Readin for extracting the rows of first element 1
           for i=1:m1
               % Measure the i-th and eligible for Target 2
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
        A_matrix=A_matrix(:,:,1:num);                                                  %A_matrix
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        %% N will contain the Joint Probability
        %
        %      k         k-1 
        % P(  Y  | X ,  Y    ) = 
        % 
        %     ____
        %      ||                      k-1 
        %      ||     P(  yj | Xjt ,  Y    )
        %Calculating the total volume of validation gate
        V=ellipse_Volume(1)+ellipse_Volume(2); 
        LikelyHood=N/(V^False_num);
        
        %% Calculating the priority
         %                     k-1 
         %       P( X | m  ,  Y    ):  priority of observed measures
         %
        if Pd==1
            Prior=1;
        else
            Prior=1;
           
            
            %Calculation the target association indicator for the event
            %Association Xi (fixed j and high on all the Track (2-3))
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
        
        %                    k  
        %       P(  X  |   Y    ): Estimated posteriori of the state
        Pr(i)=a1*LikelyHood*Prior;
    end
    
    Pr=Pr/sum(Pr);
    %%%%%%%%%%%%%%%%%%%%%%%%%
    %%%  6. Calculation of coefficients Beta (j, t)
    %%%%%%%%%%%%%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%  7.Kalman prediction for 2 filters
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:c         
        %Predicted error covariance matrix
        %P(k|k-1)
        P_predic = A*P(:,:,i)*A'+G*Q*G';
        %Matrice di GAIN
        K(:,:,i)= P_predic*C'*inv(S(:,:,i));
        
        %Update of the covariance matrix: missing Term Pk that depends
        % the combined innovation
        P(:,:,i)= P_predic-(1-BeTa(m1+1,i))*K(:,:,i)*S(:,:,i)*K(:,:,i)';
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%  7.Kalman update for 2 filters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:c
        a=0;         
        Pk=0;
        
        %% Combined innovation
        % The formula and compact version than the article as
        % the matrix K and gain multiplied by
        x_filter2=0;    
        
        for j=1:m1
            %Estimated at Priori X(k|k)
            a=x_predic(:,i)+ K(:,:,i)*(y(:,j)- Z_predic(:,i));
            
            x_filter2=x_filter2+BeTa(j,i)*(a);
        end
        %Adding the factore Beta0
        x_filter2=BeTa(j+1,i)*x_predic(:,i)+x_filter2;
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
        P(:,:,i)=P(:,:,i)+b; 
        
        x_filter1(:,i,t,M)=x_filter(:,i,t);   
    end
end % time
end %simulations

    %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%
    %%%%%  Mean value on simulations
    %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%
    x_filter=sum(x_filter1,4)/MC_number;                                               
    %%%%%%%%%%%%%%%%%%%%
    %%%  1.Visualization
    %%%%%%%%%%%%%%%%%%%%
    figure;
    % 
    for i=1:c
        a=zeros(1,n);
        b=zeros(1,n);
        for j=1:n
            a(j)=data_measurement(i,1,j);
            b(j)=data_measurement(i,2,j);
        end
        if i==1
           plot(a(:),b(:),'bo')
        else 
           plot(a(:),b(:),'bo')
        end
        hold on;
end

for i=1:c
    if i==1
       plot(NOISE_sum_a(1,:),NOISE_sum_a(2,:),'c.');
    else
       plot(NOISE_sum_b(1,:),NOISE_sum_b(2,:),'c.');
   end
end
hold on;

for i=1:c
    a=zeros(1,n);
    b=zeros(1,n);
    for j=1:n
        a(j)=x_filter(1,i,j);
        b(j)=x_filter(3,i,j);
    end
    if i==1
        plot(a(:),b(:),'r-');
    else 
        plot(a(:),b(:),'r-');
    end
hold on;
end
xlabel('x/m'),ylabel('y/m');
legend('Track1','Track2','Measurements', 'Measurements', 'Track1 reconstructed', 'Track1 reconstructed',4);grid;
%%%%%%%%%%%%%%%%%%%%
%%%  Displaying the error middle between estimated product status from the system and
%%%  state system exact (trying to rebuild)
%%%%%%%%%%%%%%%%%%%%
figure;
a=0;
c1=zeros(c,n);
for j=1:n
    for i=1:MC_number                                                              
        a=(x_filter1(1,1,j,i)-data_measurement1(1,1,j))^2+(x_filter1(3,1,j,i)-data_measurement1(1,3,j))^2;
        c1(1,j)=c1(1,j)+a;
    end
        c1(1,j)=sqrt(c1(1,j)/MC_number);
end
 
plot(1:n,c1(1,:),'r-') 

hold on;
a=0;
for j=1:n
    for i=1:MC_number                                                              
        a=(x_filter1(1,2,j,i)-data_measurement1(2,1,j))^2+(x_filter1(3,2,j,i)-data_measurement1(2,3,j))^2;
        c1(2,j)=c1(2,j)+a;
    end
        c1(2,j)=sqrt(c1(2,j)/MC_number);
end
 
plot(1:n,c1(2,:),'b-') 
xlabel('X_{est}(t)'),ylabel('Middle error(X_{est}(t)-X(t))');
legend('Error of reconstruction of Track1','Error of reconstruction of Track2'  );
grid;
