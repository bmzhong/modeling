clc;clear;
smallZones=30.5;
interval=5;
[U1,R1]=fun1(25,25,1);
[U2,R2]=fun1(5*smallZones+4*interval,U1,2);
[U3,R3]=fun1(interval,U2,3);
[U4,R4]=fun1(smallZones,U3,4);
[U5,R5]=fun1(interval,U4,5);
[U6,R6]=fun1(smallZones,U5,6);
[U7,R7]=fun1(interval,U6,7);
[U8,R8]=fun1(2*smallZones+interval,U7,8);
[U9,R9]=fun1(interval,U8,9);
[U10,R10]=fun1(2*smallZones+interval,U9,10);
[U11,R11]=fun1(25,U10,11);
R=[R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11];
R(1:22)=[];
% plot(R,'r');
% hold on
Data=xlsread('附件.xlsx');
P=Data(:,2);
len=min(length(P),length(R));
error=0;
for i=1:len
    error=error+(R(i)-P(i))^2;
end
% plot(Data(:,2),'b');
% len=25*2+11*30.5+10*5;
% v=70/60;
% T=len/v;