function S=fitness2(T)
Tm=T(1:4);
velocity=T(5)/60;
dt=0.001;  %离散化后时间的最小变化单位，
omega1=0.6;
omega2=0.4;
[~,U]=getTemperature(Tm,velocity);
flag=isConstraint(U);
[~,peakIndex]=max(U); %查找峰值及其下标
Rise=U(1:peakIndex);%取温度上升部分的数据
if flag==1
    index3=find(Rise>217,1);
    S1=0;
    for k=index3:peakIndex-1
        S1=S1+(Rise(k)-217)*dt;
    end
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
else
    S1=inf;
    S2=inf;
end
S=S1*omega1+S2*omega2;
end