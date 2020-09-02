%%第一问
clc;clear;
M=10^5;N=10^6;dt=0.001;
count=zeros(1,31);
for i=1:M
    x0=[rand();rand();rand();rand()];
    H=getH(x0);
    for j=1:N
        H(j)=floor(H(j));
        if H(j)>30
            continue;
        end
        count(H(j)+1)=count(H(j)+1)+1;
    end
end
figure(1)
plot(0:30,count./(M*N));
xlabel('H');ylabel('p(H)');
%%
% 第二问
x0=[rand();rand();rand();rand()];
count=zeros(N,31);
for i=1:M
    H=getH(x0);
    for j=1:N
        H(j)=floor(H(j));
        if H(j)>30
            continue;
        end
        count(j,H(j)+1)=count(j,H(j)+1)+1;
    end
end
figure(2)
Y=dt:dt:N*dt;
X=0:30;
Z=count./M;
mesh(X,Y,Z);
xlabel('t');ylabel('H');zlabel('p(H)');
%%
%第三问
Hc=40;
x0=[0;sqrt(5);0;sqrt(5)];
count=zeros(1,N);
for i=1:M
    H=getH(x0);
    for j=1:N
        if H(j)<= Hc
            count(j)=count(j)+1;
        end    
    end
end
figure(3)
plot(dt:dt:N*dt,count./M);
xlabel('t');ylabel('p(H在安全范围内)');