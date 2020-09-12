clc;clear;
w1=0.32e-4;
lambda1=0.0425;
w=0.38e-4;
lambda=0.12;
smallZones=30.5;
interval=5;
behindZone=25;
afterZone=25;
thickness=0.00015;
velocity=78/60;
dx=0.000001;
dt=0.001;
X=ceil(thickness/dx);
Tm=[173 198 230 257];
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
t3=(25+2.5*smallZones+interval)/velocity;
index3=floor(t3/dt);
T3=U(index3);
t6=(25+5.5*smallZones+5*interval)/velocity;
index6=floor(t6/dt);
T6=U(index6);
t8=(25+8*smallZones+7*interval)/velocity;
index8=floor(t8/dt);
T8=U(index8);

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
index1=find(R>217);
time1=(index1(end)-index1(1))*0.5;
if time1<40||time1>90
    flag=0;
end
Rise=U(1:peakIndex);
index3=find(Rise>217,1);
S=0;
for k=index3:peakIndex-1
    S=S+(Rise(k)-217)*dt;
end
index2(1)=find(Rise>=150,1);
index2(2)=find(Rise>190,1)-1;
time2=(index2(2)-index2(1))*dt;
if time2<60||time2>120
    flag=0;
end
len=length(U);
maxSlope=0;
for i=1:len-1
    maxSlope=max(maxSlope,abs(U(i+1)-U(i))/dt);
    if abs(U(i+1)-U(i))>3*dt
        flag=0;
    end
end
disp(flag);
len=length(R);
[peak,peakIndex]=max(R);
index3=find(R>=217);
index3=index3(end);
len=length(R);
X=(0:len-1)*0.5;
plot(X,R,'-db','LineWidth',2.5,'MarkerIndices',1:30:len,'MarkerSize',7,'MarkerFaceColor','b');
xlabel('时间(s)');
ylabel('温度(℃)');
legend('炉温曲线');
x0=[0,peakIndex*0.5];
y0=[peak,peak];
hold on
g1=plot(x0,y0,'--','LineWidth',1.5);
set(g1,'handlevisibility','off');
text(5,peak-5,'峰值温度','FontSize',12);
x1=[0,index3*0.5];
y1=[217,217];
hold on
g2=plot(x1,y1,'--','LineWidth',1.5);
set(g2,'handlevisibility','off');
text(5,217-5,'217','FontSize',12);
axis([0 340 0 250]);
set(gca,'xtick',0:20:340);
set(gca,'ytick',0:20:250);