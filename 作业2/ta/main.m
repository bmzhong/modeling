%% 初值设置
clear,clc
xspan=[0 60];%自变量范围
y0=[0 0 0 0];%给定解的初始值
h=0.001;%步长
N=(xspan(2)-xspan(1))/h;%N=length(x)-1

D1=0.6;D2=0.55;D3=0.6;D4=0.55;%噪声强度
W1=Gausswhite(D1,2*N+2,h/2);W2=Gausswhite(D2,2*N+2,h/2);W3=Gausswhite(D3,2*N+2,h/2);W4=Gausswhite(D4,2*N+2,h/2);%噪声长度为2*（N+1），步长为h/2
Gausswhite=[W1;W2;W3;W4];

%% 第一问求解并作图
[t,y]=runge4s(@dyfun,xspan,y0,h,Gausswhite);
figure(1);
subplot(2,2,1);plot(t,y(1,:));xlabel('t');ylabel('X1');title('X1的解曲线');
subplot(2,2,2);plot(t,y(2,:));xlabel('t');ylabel('X2');title('X2的解曲线');
subplot(2,2,3);plot(t,y(3,:));xlabel('t');ylabel('X3');title('X3的解曲线');
subplot(2,2,4);plot(t,y(4,:));xlabel('t');ylabel('X4');title('X4的解曲线');
%% 第二问求解并作图
Y1=[];Y2=[];Y3=[];Y4=[];%分别为X1到X4的解
for i=1:10
    y0=[1 1 1 1]*i/10;%初始值取0.1到1
    [t,y]=runge4s(@dyfun,xspan,y0,h,Gausswhite);
    Y1=[Y1;y(1,:)];Y2=[Y2;y(2,:)];Y3=[Y3;y(3,:)];Y4=[Y4;y(4,:)];
end
R(1,:)=mean(Y1);R(2,:)=mean(Y2);R(3,:)=mean(Y3);R(4,:)=mean(Y4);
figure(2);
subplot(2,2,1);plot(t,R(1,:));xlabel('t');ylabel('E(X1)');title('X1的解的均值曲线');
subplot(2,2,2);plot(t,R(2,:));xlabel('t');ylabel('E(X2)');title('X2的解的均值曲线');
subplot(2,2,3);plot(t,R(3,:));xlabel('t');ylabel('E(X3)');title('X3的解的均值曲线');
subplot(2,2,4);plot(t,R(4,:));xlabel('t');ylabel('E(X4)');title('X4的解的均值曲线');