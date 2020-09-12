function [R,U]=
function [D,R,U]=calculatePhase(distance,velocity,U0,w,lambda,Tm,judge)
thickness=0.00015;
interval=5;
behindZone=25;
T_max=distance/velocity;
dt=0.001;
dx=0.000001;
X=ceil(thickness/dx);
T=ceil(T_max/dt);
U=zeros(X,T);
U(:,1)=U0;
for j=1:T-1
    for i=2:X-1
        U(i,j+1)=(1-2*lambda)*U(i,j)+lambda*(U(i+1,j)+U(i-1,j));
    end
    if judge==1
        T0=25+((Tm(1)-25)/behindZone)*velocity*j*dt;
    elseif judge==2
        T0=Tm(1);
    elseif judge==3
        T0=Tm(1)+((Tm(2)-Tm(1))/interval)*velocity*j*dt;
    elseif judge==4
        T0=Tm(2);
    elseif judge==5
        T0=Tm(2)+((Tm(3)-Tm(2))/interval)*velocity*j*dt;
    elseif judge==6
        T0=Tm(3);
    elseif judge==7
        T0=Tm(3)+((Tm(4)-Tm(3))/interval)*velocity*j*dt;
    elseif judge==8
        T0=Tm(4);
    elseif judge==9
        T0=Tm(4)+((25-Tm(4))/interval)*velocity*j*dt;
    elseif judge==10
        T0=25;
    elseif judge==11
        T0=25;
    end
    U(1,j+1)=(dx*T0+w*U(2,j+1))/(dx+w);
    U(X,j+1)=(dx*T0+w*U(X-1,j+1))/(dx+w);
end
D=U(:,T);
R=U(floor(X/2),1:floor(0.5/dt):end);
U=U(floor(X/2),:);
end