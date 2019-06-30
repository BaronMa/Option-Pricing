function [y] = get_option_value(option,stock_price,maturity,volatility,strike_price,rate,penalty)

theta =0.5; S=stock_price; E = strike_price; r = rate; vol = volatility;
T=maturity; Do=0;    
% Transformation 
x = log(S/E); tau = 0.5*vol^2*T; k1 = (2*r)/(vol^2); k2 = (2*r-Do)/(vol^2);

%xstep and taustep
xstep=0.0125; alpha = 0.5; taustep = alpha*xstep^2; 

%select any large values for Nplus and Nminus
Nplus = 5; Nminus = -5; %N = round((Nplus-Nminus)/xstep);

%Create vectors of x and tau values to identify meshpoints
xvalue =(Nminus:xstep:Nplus)';
tauvalue =(0:taustep:2*tau);
[M,~] = size(tauvalue');
[N,~] = size(xvalue);
% Initial and Boundary Conditions;
Svalue = E*exp(xvalue);

v=zeros(N-2,M);
% Initial values for v
Iv=zeros(N,1);
for i = 1:N
  Iv(i,1) = g(xvalue(i),0,k1,k2,option);
end

for i = 2:N-1
 v(i-1,1)= Iv(i,1);  %Initial conditions for v(-N + 1....N-1); j is the time vector for each m
end

for i = 2:N-1
 v(i-1,2:M)=g(xvalue(i),tauvalue(2:M),k1,k2,option);  %Initial conditions for v(-N + 1....N-1); j is the time vector for each m
end

initial_v = g(xvalue(1),tauvalue(1:M),k1,k2,option);
final_v = g(xvalue(N),tauvalue(1:M),k1,k2,option);


%develop the bm matrix
b = zeros(N-2,M-1);
count=zeros(M-1,1);
for j = 1 : M-1
% Set up bm
b(1,j) = v(1,j)+alpha*(1-theta)*(g(xvalue(1),tauvalue(j),k1,k2, option)-2*v(1,j)+ v(2,j)) + alpha*theta*g(xvalue(1),tauvalue(j+1),k1,k2,option); % Nplus -1
b(N-2,j)= v(N-2,j) + alpha*(1-theta)*(g(xvalue(N),tauvalue(j),k1,k2,option)- 2 *v(N-2,j) + v(N-3,j)) + alpha*theta*g(xvalue(N),tauvalue(j+1),k1,k2,option); % Nminus + 1
for i = 2:N-3
b(i,j) = v(i,j) + alpha*(1-theta)*(v(i+1,j) - 2*v(i,j) + v(i-1,j));
end
G= g(xvalue,tauvalue(j+1),k1,k2,option);
F = f(xvalue,tauvalue(j+1),k1,k2, option,penalty,E);
[v(:,j+1),count(j)] = psor(b,v(:,j),alpha,theta,j,initial_v,final_v, G,F); % uses the psor algorithm to 
end


V = zeros(N,M);
for j=1:M
V(1,j) =E*exp(-0.5*(k2-1).*xvalue(1) - (0.25*(k2-1)^2 + k1)*tauvalue(j)).*(g(xvalue(1),tauvalue(j),k1,k2,option)); %initial values
V(N,j) =E*exp(-0.5*(k2-1).*xvalue(N) - (0.25*(k2-1)^2 + k1)*tauvalue(j)).*(g(xvalue(N),tauvalue(j),k1,k2,option)); %final values
V(2:N-1,j) = E*exp(-0.5*(k2-1).*xvalue(2:N-1) - (0.25*(k2-1)^2 + k1)*tauvalue(j)).*v(:,j);
end

actual_v = interp1(Svalue,V, E*exp(x));   % interpolates to get actual call option values
actual_v = interp1(tauvalue./(1/2*vol^2),actual_v,T);
y = actual_v;
end

