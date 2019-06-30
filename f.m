function y = f(x,tau,k1,k2,option,penalty, E)
% k1 =max(k1);
% k2=max(k2);
% k1 =max(k1);
% k2=max(k2);
switch option    
    case 'put'
       y=exp((tau/4)*((k1+1)^2))*max(exp(0.5*x*(k2-1))-exp(0.5*x*(k2+1)) +exp(0.5*x*(k2+1)) *(penalty/E),exp(0.5*x*(k2+1)) *(penalty/E));
    case 'call'
       y=exp((tau/4)*((k1+1)^2))*max(exp(0.5*x*(k2+1))-exp(0.5*x*(k2-1))+exp(0.5*x*(k2-1))*(penalty/E),exp(0.5*x*(k2-1))*(penalty/E));
end