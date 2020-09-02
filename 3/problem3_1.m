clc;clear;
warning('off');
r0=zeros(1,128);
for i=1:64
    r0(i)=rand()*60;
end
options.MaxFunEvals=1e7;
options.MaxIter=1e4;
lb=zeros(1,128);
ub=70*ones(1,128);
[r,feval]=fmincon(@(r)func(r),r0,[],[],[],[],lb,ub,@(r)nonlcon(r),options);
sump=sum(r(65:128));
entropy=sum(-r(65:128).*log2(r(65:128)));
%     plot(1:64,r(65:128),'*');
function f=func(r)
    e=exp(1);
    t=sum(r(1:64).^2.*r(65:128));
    d=sum(r(1:64).*r(65:128));
    f=t/d^2;
end
function [c,ceq]=nonlcon(r)
    c=[];
    entropy2=5.16993;
    c1=sum(-r(65:128).*log2(r(65:128)))-entropy2;
    c2=sum(r(65:128))-1;
    ceq=[c1,c2];
end