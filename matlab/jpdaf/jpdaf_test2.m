clc;clear all;close all;
%Number of steps of the state of system 
n=50;

%Sampling period 
T=1;

%Monte Carlo 
MC_number=5;     

%Monte Carlo 
%dimensions 
c=2;  

%Initial positions (x, y, vx, vy)
target_position=[1500 300 500 400; 
                 500 400 1500 300]; 
				 


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
    %%%  1.  Process of measurment
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