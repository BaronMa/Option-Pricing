 %Option Price obstacle
function y = g(x,tau,k1,k2,option)
% k1 = k1(1)-k1(1) + (2*0.06)./(0.5^2); 
% k2=k2(1)-k2(1)+ k1;
% k1 =max(k11);
% k2=max(k2);
% k1 =max(k1);
% k2=max(k2);
switch option
    case 'put'
        y=exp((tau/4)*((k2-1)^2+4*k1))*max(exp(0.5*x*(k2-1))-exp(0.5*x*(k2+1)),0);
    case 'call'
        y=exp((tau/4)*((k2-1)^2 + 4*k1))*max(exp(0.5*x*(k2+1))-exp(0.5*x*(k2-1)),0);
end