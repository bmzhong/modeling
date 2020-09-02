clc;clear;
e=exp(1); %底数e；
syms u;   %符号变量u；
%求P(i,j);P(i,j)是关于u的符号函数；
denominator=sum(e.^(-(2.*[1:8]'-9).^2*u))^2;
for i=1:8
    for j=1:8
        P(i,j)=(e^(-(2*i-9)^2*u)*e^(-(2*j-9)^2*u))/denominator;
        H(i,j)=-P(i,j)*log2(P(i,j));
    end
end
f=sum(sum(H));
u=eval(vpasolve(f==5,u,0.1)); %求解u,指定初始猜测值0.1；
%求解每个点的概率P(i,j);
P=zeros(8,8); 
denominator=sum(e.^(-(2.*[1:8]'-9).^2*u))^2;
for i=1:8
    for j=1:8
        P(i,j)=(e^(-(2*i-9)^2*u)*e^(-(2*j-9)^2*u))/denominator;
        H(i,j)=-P(i,j)*log2(P(i,j));
    end
end
verify1=eval(sum(sum(H)))==5; %验证上面的解是否符合条件；
verify2=sum(sum(P))==1;    %验证概率和是否为1；
bar3(P,0.7);%画图
xlabel('dimension1');
ylabel('dimension2');
zlabel('probability');