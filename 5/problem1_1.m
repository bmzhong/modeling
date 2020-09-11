w1=8e-5;
lambda1=0.08;
w=7.8e-5;
lambda=0.18;
smallZones=30.5;
X_max=0.00015;
dx=0.000001;
dt=0.001; 
X=ceil(X_max/dx);
interval=5;
velocity=78/60;
[D1,R1,U1]=fun(25,25,1,w,lambda);
[D2,R2,U2]=fun(5*smallZones+4*interval,D1,2,w,lambda);
[D3,R3,U3]=fun(interval,D2,3,w,lambda);
[D4,R4,U4]=fun(smallZones,D3,4,w,lambda);
[D5,R5,U5]=fun(interval,D4,5,w,lambda);
[D6,R6,U6]=fun(smallZones,U5,6,w,lambda);
[D7,R7,U7]=fun(interval,D6,7,w,lambda);
[D8,R8,U8]=fun(2*smallZones+interval,D7,8,w,lambda);
[D9,R9,U9]=fun(interval,D8,9,w1,lambda1);
[D10,R10,U10]=fun(2*smallZones+interval,D9,10,w1,lambda1);
[D11,R11,U11]=fun(25,D10,11,w1,lambda1);
R=[R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11];
U=[U1 U2 U3 U4 U5 U6 U7 U8 U9 U10 U11];
plot(R,'b');
t3=(25+2.5*smallZones+interval)/velocity;
index3=floor(t3/dt);
T3=U(floor(X/2),index3);
t6=(25+5.5*smallZones+5*interval)/velocity;
index6=floor(t6/dt);
T6=U(floor(X/2),index6);
t8=(25+8*smallZones+7*interval)/velocity;
index8=floor(t8/dt);
T8=U(floor(X/2),index8);

function [D,R1,U]=fun(distance_,U0,judge,w_,lambda_)
X_max=0.00015;
velocity=78/60;
distance=distance_;
T_max=distance/velocity;
dt=0.001; %时间步长
dx=0.000001;
w=w_;
lambda=lambda_;
X=ceil(X_max/dx);
T=ceil(T_max/dt);
U=zeros(X,T);
U(:,1)=U0;
for j=1:T-1
    for i=2:X-1
        U(i,j+1)=(1-2*lambda)*U(i,j)+lambda*(U(i+1,j)+U(i-1,j));
    end
    if judge==1
        T0=25+((173-25)/25)*(78/60)*j*dt;
    elseif judge==2
        T0=173;
    elseif judge==3
        T0=173+((198-173)/5)*(78/60)*j*dt;
    elseif judge==4
        T0=198;
    elseif judge==5
        T0=198+((230-198)/5)*(78/60)*j*dt;
    elseif judge==6
        T0=230;
    elseif judge==7
        T0=230+((257-230)/5)*(78/60)*j*dt;
    elseif judge==8
        T0=257;
    elseif judge==9
        T0=257+((25-257)/5)*(78/60)*j*dt;
    elseif judge==10
        T0=25;
    elseif judge==11
        T0=25;
    end
    if judge==11||judge==12
        U(1,j+1)=25+(U(1,j)-25)*exp(1)^(-dt/w);
        U(X,j+1)=25+(U(X,j)-25)*exp(1)^(-dt/w);
    else
        U(1,j+1)=(dx*T0+w*U(2,j+1))/(dx+w);
        U(X,j+1)=(dx*T0+w*U(X-1,j+1))/(dx+w);
    end
end
D=U(:,T);
R1=U(floor(X/2),1:500:end);
end