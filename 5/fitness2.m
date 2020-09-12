function S=fitness2(T)
Tm=T(1:4);
velocity=T(5)/60;
[~,U]=getTemperature(Tm,velocity);
flag=isConstraint(U);
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
S=[S1,S2];
end