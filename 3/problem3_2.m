clc;clear;
r0=zeros(1,65);
for i=1:65
    r0(i)=rand();
end
% options = optimset('MaxIter ',100000,'MaxFunctionEvaluations',100000);
r=fmincon(@(r)func(r),r0,[],[],[],[],zeros(1,65),[],@(r)nonlcon(r));
function f=func(r)
    e=exp(1);
    denominator=sum(e.^(-(r(65).*r(1:64).^2)));
    P=e.^(-r(65).*r(1:64).^2)./denominator;
    f=sum(r(1:64).^2.*P(1:64))/sum(r(1:64).*P(1:64)).^2;
end
function [c,ceq]=nonlcon(r)
    c=[]; e=exp(1);
    denominator=sum(e.^(-(r(65).*r(1:64).^2)));
    P=e.^(-r(65).*r(1:64).^2)./denominator;
    ceq=sum(-P(1:64).*log2(P(1:64)))-5.16;
end