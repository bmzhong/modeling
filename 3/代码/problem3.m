M=1;
u0=inf;
for i=1:M %计算M次取最小值
    [r,u,p,entropy]=solve();
    if u<u0
        r0=r;u0=u;p0=p;entropy0=entropy;
    end
end
Ptx=5;ASE=17.85*10^(-6);X1=3.09*10^4;X2=1.05*10^4;
NLI=Ptx^3*X1+Ptx^3*X2*(u-2);
SNR=Ptx/(ASE^2+NLI);%求解SNReff；
fprintf('SNRmax:  %8.7d\n',SNR);

function [r,u,p,entropy]=solve()
    clc;warning('off');
    r0=zeros(1,128);
    for i=1:64
        r0(i)=rand()*100; %生成初始猜测值
    end
%     options=optimset('MaxFunEvals',1e6);
    options.MaxFunEvals=1e7;
    options.MaxIter=1e4;
    lb=zeros(1,128);
    ub=100*ones(1,128);
    [r,u]=fmincon(@(r)func(r),r0,[],[],[],[],lb,ub,@(r)nonlcon(r),options);
    p=sum(r(65:128));%验证概率和是否为1
    entropy=sum(-r(65:128).*log2(r(65:128)));%验证信息熵是否为5.16993
end
function f=func(r)
    t=sum(r(1:64).^2.*r(65:128));
    d=sum(r(1:64).*r(65:128));
    f=t/d^2;
end
function [c,ceq]=nonlcon(r) %约束条件
    c=[];
    entropy2=5.16993;%第二问的信息熵
    c1=sum(-r(65:128).*log2(r(65:128)))-entropy2;
    c2=sum(r(65:128))-1;
    ceq=[c1,c2];%等式约束
end