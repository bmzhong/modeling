function S=fitness1(T)
Tm=T(1:4);
velocity=T(5)/60;
dt=0.001;  %离散化后时间的最小变化单位，
[~,U]=getTemperature(Tm,velocity);
flag=isConstraint(U);
[~,peakIndex]=max(U); %查找峰值及其下标
Rise=U(1:peakIndex);%取温度上升部分的数据
if flag==1
    index3=find(Rise>217,1);
    S=0;
    for k=index3:peakIndex-1
        S=S+(Rise(k)-217)*dt;
    end
else
    S=inf;
end
end