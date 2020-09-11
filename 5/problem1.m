clc;clear;
smallZones=30.5;
interval=5;
X_max=0.00015;
velocity=70/60;
distance=25;
T_max=distance/velocity;
dt=0.1; %时间步长
dx=0.000001;
% T0=7;
w=0.1;
lambda=0.2;
X=ceil(X_max/dx);
T=ceil(T_max/dt);
U=zeros(X,T);
U(:,1)=25;
for j=1:T-1
    for i=2:X-1
        U(i,j+1)=(1-2*lambda)*U(i,j)+lambda*(U(i+1,j)+U(i-1,j));
    end
    T0=25+7*j*dt;
    U(1,j+1)=(dx*T0+w*U(2,j+1))/(dx+w);
    U(X,j+1)=(dx*T0+w*U(X-1,j+1))/(dx+w);
end
R=U(:,T);
% plot(R);
R0=U(floor(X/2),1:5:end);
