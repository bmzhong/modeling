function [res,error]=GM(A)
[row,col]=size(A);
if row>col
    A=A';
end
syms a u;
c=[a,u]';%构成矩阵
% A=[24 26 26 26 27 27 29 30 30 30 31 31 31 31 34 35 45];%输入数据，可以修改
Ago=cumsum(A);%原始数据一次累加,得到1-AGO序列xi(1)。
n=length(A);%原始数据个数
number=2*n;%预测总数据个数
for k=1:(n-1)
    Z(k)=(Ago(k)+Ago(k+1))/2; %Z(i)为xi(1)的紧邻均值生成序列
end
Yn =A;%Yn为常数项向量
Yn(1)=[]; %从第二个数开始，即x(2),x(3)...
Yn=Yn';
E=[-Z;ones(1,n-1)]';%累加生成数据做均值
c=(E'*E)\(E'*Yn);%利用公式求出a，u
c= c';
a=c(1);%得到a的值
u=c(2);%得到u的值
F=[];
F(1)=A(1);
for k=2:number
    F(k)=(A(1)-u/a)/exp(a*(k-1))+u/a;%求出GM(1,1)模型公式
end
G=[];
G(1)=A(1);
for k=2:number
    G(k)=F(k)-F(k-1);%两者做差还原原序列，得到预测数据
end
%后验差检验
e=A-G(1:n);
q=abs(e./A);%相对误差
res=G;
error=q;
% disp(q);
% disp(G);
