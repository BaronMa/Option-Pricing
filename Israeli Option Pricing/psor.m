function [y,count,error] = psor(b,v,alpha, theta,j,initial_v, final_v, G,F)

tolerance = 0.000001;
relaxation = 1.14;
n = size(v,1); 
a=alpha*theta;
%penalty option
count = 0; % Number of iterations;
error=10;
%G= g(xvalue(2:n),tauvalue(j+1),k1,k2,option);
   %V vector for iteration
iterative_V = [initial_v(j),v', final_v(j)]';
iterative_V = max(iterative_V, G);
while error >= tolerance^2
for i = 2:n+1
    q=iterative_V(i-1,1);
    r=iterative_V(i+1,1);   
    z =(b(i-1,j)+a*(q+r))/(1+2*a);
    %New_V(i-1,1) = max(G(i) , iterative_V(i) + relaxation*(z - iterative_V(i)));
    New_V(i-1,1) = min(max(G(i) , iterative_V(i) + relaxation*(z - iterative_V(i))), F(i)); %Israeli condition
end
error = max(New_V(:,1)-iterative_V(2:end-1,1))^2;
count = count + 1;
iterative_V(:,1) = [initial_v(j), New_V(:,1)', final_v(j)]';
end
y = New_V(:,1);
 