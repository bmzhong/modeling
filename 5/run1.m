clc;clear;
smallZones=30.5;
interval=5;
Data=xlsread('附件.xlsx');
P=Data(:,2);
error_=inf;
W=0;LAMBDA=0;
w1=1e-4;
lambda1=0.079;
for w1=0.8e-4:0.2e-4:1.1e-4
    for lambda1=0.070:0.01:0.095
        for w=0.78e-4:0.02e-4:1e-4
            for lambda=0.150:0.03:0.180
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
                R(1:22)=[];
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
plot(P,'b');