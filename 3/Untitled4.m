clc;clear;
x0=[0.1,0.3,0.4,0.3];
f=@(x) x(1)^2+x(2)^2+x(3)^2+x(4)^2;
x=fmincon(f,x0,[],[],[],[],zeros(1,4),[],@(x)nonlcon(x))
function [c,ceq]=nonlcon(x)
    c=[];
%     c1=x(1)+x(2)+x(3)+x(4)-1;
%     c2=x(1)+x(2)+x(3)+x(4)-2;
    ceq=[c1,c2];
end
% r=[1:128];
% p=r(1:64)*r(65:128)'
% k=sum(r(1:64).*r(65:128))