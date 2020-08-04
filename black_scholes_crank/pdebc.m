function [t0,tn] = pdebc(tau,r,sigma,u11,T)
k= 2*r/(sigma*sigma);
t0 =exp(((-T*r+k*tau)*(0.25*(k+1)^2))*tau);
%u11*exp(-T*r+k*tau);
tn=0;


