clear, clc 
x0=[174, 179, 183, 189, 207, 234, 220.5, 256, 270, 285]';
n=length(x0);
lamda=x0(1:n-1)./x0(2:n); %计算级比
range=minmax(lamda');%计算级比范围
x1=cumsum(x0); %一次累加
B=[-0.5*(x1(1:n-1)+x1(2:n)),(0.5*(x1(1:n-1)+x1(2:n))).^2];
Y=x0(2:n);
u=B\Y; %拟合参数 u(1)=a,u(2)=b
x=dsolve('Dx+a*x=b*x^2','x(0)=x0');%求微分方程的符号解
x=subs(x,{'a','b','x0'},{u(1),u(2),x0(1)});% 代入估计值和初始值
yuce1=subs(x,'t',[0:n-1]); %求已知数据的预测值(只代入不求解)
yuce2=eval(yuce1);%求解
yuce=[x0(1),diff(yuce2)]; %还原数据
E=x0'-yuce; %计算残差
e=abs(E./x0');
rho=abs(1-(1-0.5*u(1))/(1+0.5*u(1))*lamda)';