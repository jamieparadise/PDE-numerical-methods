clear;
%the start and stop time
t_0=0;
T=1;
E=100; %strike price
S0=60; %lower stock price
Sn=140; %upper stock price
r=0.1; %risk free rate
sigma=0.2; %volatility
tau_0=0; %tau is time in the heat equation
tau_n=(T-t_0)*sigma*sigma/2;
%the x value at the boundaries
x0=log(S0/E); %x is space coordinate in the heat equation
xn=log(Sn/E);
%the number of steps 
time_steps=100;
x_steps=50;
x=linspace(x0,xn,x_steps+1);
tau=linspace(tau_0,tau_n,time_steps+1);
%the size of the steps in the t and x directions
k = (tau_n-tau_0)/(time_steps); %the size of each time_step
h = (xn-x0)/(x_steps); %the size of each x_coordinate_step

U = zeros(x_steps+1,time_steps+1); % the temperature at each point and time


%setting the inital condition
for i =1:x_steps+1
   U(i,1)=pdeic(x(i),r,sigma);
end

%setting the boundary values
 for j = 2:time_steps+1
   [U(1,j),U(x_steps+1,j)]=pdebc(tau(time_steps+2-j),r,sigma,U(1,1),T);
  
 end
 
 R= k/(2*h*h);
 for j=1:time_steps
     %set up the matrix
     B = zeros(x_steps+1,x_steps+1);
     B(1,1)= 1;
     B(x_steps+1,x_steps+1)=1;
     %setting up the vector
     v=zeros(x_steps+1,1);
     v(1)=U(1,j);
     v(x_steps+1)= U(x_steps+1,j+1);
     for i = 2:x_steps
         B(i,i-1) = -R;
         B(i,i) = 1+2*R;
         B(i,i+1) = -R;
         v(i)=(1-2*R)*U(i,j)+R*U(i-1,j)+R*U(i+1,j);
%          disp(U(i-1,j));
%          disp(U(i+1,j));
%          disp(r);
         
     end
     %y=(B^-1)*v; this way inverts the matrix first and is slower than B\v
     %which solves the system the system of linear equations
     y=B\v;
     U(:,j+1)=y;

%      disp(V);
%     disp(B);
%     disp(v);
%      disp(y);
    
 end
 
 
 
% surf(tau,x,U);
 S=E*exp(x);
 t=T-(2*tau)/(sigma*sigma);
 P = zeros(x_steps+1,time_steps+1); %the price of the put at each point
 C = zeros(x_steps+1,time_steps+1); %the price of the call at each point
 for j =1:time_steps+1
      for i =1:x_steps+1
        P(i,j)=E*U(i,j)*exp(-0.5*((2*r/(sigma*sigma))-1)*x(i)-0.25*(tau(j)*((2*r/(sigma*sigma))+1)^2));
        C(i,j)=-exp(-r*(T-t(j)))*E+S(i)+P(i,j); 
        disp(size(C))
      end    
 end
% disp(t(1))
% disp(C(1,1))
% disp(P(1,1))
 surf(t,S,P)
 title('Plot of the Value of a Put')
 xlabel('t')
 ylabel('S')

%  surf(t,S,C)
%  title('Plot of the Value of a Call')
%  xlabel('t')
%  ylabel('S')
% call not working 
