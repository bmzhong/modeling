clc;clear;
w1=0.5e-4;
lambda1=0.0495;
w=0.52e-4;
lambda=0.11;
smallZones=30.5;
interval=5;
behindZone=25;
afterZone=25;
thickness=0.00015;
velocity=68/60;
dx=0.000001;
dt=0.001; 
X=ceil(thickness/dx);
Tm=[182 203 237 254];
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
plot(R);
flag=1;
[peak,peakIndex]=max(R);
if peak<240||peak>250
    flag=0;
end
dt=0.5;
index1=find(R>217);
time1=(index1(end)-index1(1))*dt;
if time1<40||time1>90
    flag=0;
end
Rise=R(1:peakIndex);
index2(1)=find(Rise>=150,1);
index2(2)=find(Rise>=190,1)-1;
time2=(index2(2)-index2(1))*dt;
if time2<60||time2>120
    flag=0;
end
len=length(R);
for i=1:len-1
    if abs(R(i+1)-R(i))>3*dt
        flag=0;
        break;
    end
end
disp(flag);