clc;clear;
smallZones=30.5;
interval=5;
Data=xlsread('附件.xlsx');
P=Data(:,2);
error_=inf;
W=0;LAMBDA=0;
w1=1e-4;
lambda1=0.079;
for w1=0.5e-4
    for lambda1=0.0495
        for w=0.52e-4
            for lambda=0.11
                [U1,R1]=fun1(25,25,1,w,lambda);
                [U2,R2]=fun1(5*smallZones+4*interval,U1,2,w,lambda);
                [U3,R3]=fun1(interval,U2,3,w,lambda);
                [U4,R4]=fun1(smallZones,U3,4,w,lambda);
                [U5,R5]=fun1(interval,U4,5,w,lambda);
                [U6,R6]=fun1(smallZones,U5,6,w,lambda);
                [U7,R7]=fun1(interval,U6,7,w,lambda);
                [U8,R8]=fun1(2*smallZones+interval,U7,8,w,lambda);
                [U9,R9]=fun1(interval,U8,9,w1,lambda1);
                [U10,R10]=fun1(2*smallZones+interval,U9,10,w1,lambda1);
                [U11,R11]=fun1(25,U10,11,w1,lambda1);
                R=[R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11];
                R(1:38)=[];
                len=min(length(P),length(R));
                error=0;
                for i=1:len
                    error=max(abs(P(i)-R(i)),error);
                end
                if error<error_
                    error_=error;
                    W=w;
                    LAMBDA=lambda;
                    W1=w1;
                    LAMBDA1=lambda1;
                end
            end
        end
    end
end
plot(R,'r');
hold on
% hold on
plot(P,'g');
hold on


w1=0.5e-4;
lambda1=0.0495;
w=0.52e-4;
lambda=0.11;
smallZones=30.5;
interval=5;
behindZone=25;
afterZone=25;
thickness=0.00015;
velocity=70/60;
dx=0.000001;
dt=0.001; 
X=ceil(thickness/dx);
Tm=[175 195 235 255];
[D1,R1,U1]=fun(behindZone,velocity,25,w,lambda,Tm,1);
[D2,R2,U2]=fun(5*smallZones+4*interval,velocity,D1,w,lambda,Tm,2);
[D3,R3,U3]=fun(interval,velocity,D2,w,lambda,Tm,3);
[D4,R4,U4]=fun(smallZones,velocity,D3,w,lambda,Tm,4);
[D5,R5,U5]=fun(interval,velocity,D4,w,lambda,Tm,5);
[D6,R6,U6]=fun(smallZones,velocity,D5,w,lambda,Tm,6);
[D7,R7,U7]=fun(interval,velocity,D6,w,lambda,Tm,7);
[D8,R8,U8]=fun(2*smallZones+interval,velocity,D7,w,lambda,Tm,8);
[D9,R9,U9]=fun(interval,velocity,D8,w1,lambda1,Tm,9);
[D10,R10,U10]=fun(2*smallZones+interval,velocity,D9,w1,lambda1,Tm,10);
[D11,R11,U11]=fun(afterZone,velocity,D10,w1,lambda1,Tm,11);
R0=[R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11];
U=[U1 U2 U3 U4 U5 U6 U7 U8 U9 U10 U11];
R0(1:38)=[];
plot(R0,'b');