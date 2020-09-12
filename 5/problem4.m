clc;clear;
tic;
w1=0.32e-4;
lambda1=0.0425;
w=0.38e-4;
lambda=0.12;
smallZones=30.5;
interval=5;
behindZone=25;
afterZone=25;
thickness=0.00015;
dx=0.000001;
dt=0.001;
X=ceil(thickness/dx);
TmMin=[175-10 195-10 235-10 255-10];
TmMax=[175+10 195+10 235+10 255+10];
velocityMin=65/60;
velocityMax=100/60;
resultTm=[];
resultVelocity=[];
resultS=inf;
flag1=1;
Tm0=[];
velocity0=0;
Record=[];
T0=[170,205,235,265 100/60];
for i=170
    for j=205
        for u=235
            for v=265
                for velocity=100/60
                    Tm=[i j u v];
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
                    R=[R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11];
                    U=[U1 U2 U3 U4 U5 U6 U7 U8 U9 U10 U11];
                    flag=1;
                    [peak,peakIndex]=max(U);
                    if peak<240||peak>250
                        flag=0;
                    end
                    index1=find(U>217);
                    time1=(index1(end)-index1(1))*dt;
                    if time1<40||time1>90
                        flag=0;
                    end
                    Rise=U(1:peakIndex);
                    index2(1)=find(Rise>=150,1);
                    index2(2)=find(Rise>=190,1)-1;
                    time2=(index2(2)-index2(1))*dt;
                    if time2<60||time2>120
                        flag=0;
                    end
                    len=length(U);
                    for k=1:len-1
                        if abs(U(k+1)-U(k))>3*dt
                            flag=0;
                            break;
                        end
                    end
                    if flag==1
                        if flag1==1
                            Tm0=Tm;
                            velocity0=velocity;
                            flag1=0;
                        end
                        index3=find(Rise>217,1);
                        S1=0;
                        for k=index3:peakIndex-1
                            S1=S1+(Rise(k)-217)*dt;
                        end
                        if S1<resultS
                            resultS=S1;
                            resultTm=Tm;
                            resultVelocity=velocity;
                        end
                        Temp=[Tm velocity*60 S1 flag];
                        Record=[Record;Temp];
                    end
                end
            end
        end
    end
end
% disp(Record);
time=toc;
% disp(flag);
index=find(U>217);
t1=index(1);
t3=index(end);
[~,t2]=max(U);
n=t2-t1;
m=t3-t2;
S2=0;
x0=min(n,m);
y0=max(n,m);
for k=1:x0
    S2=S2+abs(U(t2+k)-U(t2-k))*dt;
end
s=sign(n-m);
for k=x0:y0
    S2=S2+(U(t2+(-1)^s*k)-217)*dt;
end

