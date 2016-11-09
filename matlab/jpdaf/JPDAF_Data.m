clc;clear all;close all;
%Number of evolutions of the state system to estimate
n=50;

%Time
T=1;

%Monte Carlo 
MC_number=5;     

%Monte Carlo 
%Dimensions state
c=2;  

%Initial positions
target_position=[1500 300 500 400; 
                 500 400 1500 300]; 
             
JPDAF(target_position,n,T,MC_number,c);     