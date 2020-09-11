function [D,R,U]=fun(velocity_,distance_,U0,w_,lambda_,Tm,judge)
X_max=0.00015;
velocity=velocity_;
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
R=U(floor(X/2),1:500:end);
end