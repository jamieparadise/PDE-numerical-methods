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
r= k/(h*h);
%setting the inital condition
for i =1:x_steps+1
   T(i,1)=pdeic((i-1)/x_steps);
end
%setting the boundary values
 for j = 1:time_steps+1
   [T(1,j),T(x_steps+1,j)]=pdebc((j-1)/time_steps);
   
 end
 
 for j=1:time_steps
     %set up the matrix
     B = zeros(x_steps+1,x_steps+1);
     B(1,1)= 1;
     B(x_steps+1,x_steps+1)=1
     %setting up the vector
     v=zeros(x_steps+1,1);
     v(1)=T(1,j);
     v(x_steps+1)= T(x_steps+1,j+1);
     for i = 2:x_steps
         B(i,i-1) = -r;
         B(i,i) = 1+2*r;
         B(i,i+1) = -r;
         v(i)=T(i,j);
         disp(T(i-1,j));
         disp(T(i+1,j));
         disp(r);
     end
     %y=(B^-1)*v; this way inverts the matrix first and is slower than B\v
     %which solves the system the system of linear equations
     y=B\v;
     T(:,j+1)=y;
     disp(T);
    disp(B);
    disp(v);
     disp(y);
    
 end
 
 x=linspace(x0,xn,x_steps+1);
 t=linspace(t0,tn,time_steps+1);
 surf(t,x,T)

