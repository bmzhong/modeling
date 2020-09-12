function S=fitness1(T)
Tm=T(1:4);
velocity=T(5)/60;
[~,U]=getTemperature(Tm,velocity);
flag=isConstraint(U);
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