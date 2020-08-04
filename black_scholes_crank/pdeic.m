function u0=pdeic(x,r,sigma)
k= 2*r/(sigma*sigma); %2.5
u0 = max(exp(0.5*(k-1)*x) -exp(0.5*(k+1)*x),0);