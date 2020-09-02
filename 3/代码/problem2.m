clc;clear;
x0=[2,4];%初始猜测值；
[x,u]=fmincon(@(x)func(x),x0,[],[],[],[],[0,-inf],[]);
fprintf('lamda: %8.7d,  p: %8.7d  u: %8.7d\n',x(1),x(2),u);
[~,P]=func(x); %求解概率P；
H=-P(:).*log2(P(:));
entropy=sum(sum(H));%求解信息熵；
Ptx=5;ASE=17.85*10^(-6);X1=3.09*10^4;X2=1.05*10^4;
NLI=Ptx^3*X1+Ptx^3*X2*(u-2);
SNR=Ptx/(ASE^2+NLI);%求解SNReff；
fprintf('SNRmax:  %8.7d\n',SNR);
bar3(P,0.7);%画概率分布图
fprintf('entropy： %18.17d\n',entropy);
function [u,P]=func(x) %x(1)=lamda;x(2)=p;
    A=1/sqrt(42); e=exp(1);
    X=[-7:2:7]'.*A;Y=[-7:2:7]'.*A;
    denominator=sum(e.^(-(x(1).*abs(X(:)).^x(2))))^2;%分母
    P=zeros(8,8);H=zeros(8,8);Q=zeros(8,8);
    for i=1:8
        for j=1:8
            t1=e^(-(x(1)*abs(X(i))^x(2)));
            t2=e^(-(x(1)*abs(Y(j))^x(2)));
            P(i,j)=t1*t2/denominator;
            H(i,j)=(X(i)^2+Y(j)^2)^2*P(i,j);
            Q(i,j)=(X(i)^2+Y(j)^2)*P(i,j);
        end
    end
    u=sum(sum(H))/(sum(sum(Q)))^2;
end
