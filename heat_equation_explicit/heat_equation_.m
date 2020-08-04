clear;
%the start and stop time
t0=0;
tn=0.5;
%the x value at the boundaries
x0=0;
xn=1;
%the number of steps 
time_steps=100;
x_steps=10;
%the size of the steps in the t and x directions
k = (tn-t0)/(time_steps);
h = (xn-x0)/(x_steps);
T = zeros(x_steps+1,time_steps+1);

%setting the inital condition
for i =1:x_steps+1
   T(i,1)=pdeic((i-1)/x_steps);
end
%setting the boundary values
 for j = 1:time_steps+1
   [T(1,j),T(x_steps+1,j)]=pdebc((j-1)/time_steps);
   
 end
 
 for j=1:time_steps
     for i = 2:x_steps
         T(i,j+1)= T(i,j) + k*(T(i+1,j)+T(i-1,j)-2*T(i,j))/(h*h);
     end
 end
 x=linspace(x0,xn,x_steps+1);
 t=linspace(t0,tn,time_steps+1);
surf(t,x,T)

