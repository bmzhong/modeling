function flag=isConstraint(U)
flag=1;
dt=0.001;
[peak,peakIndex]=max(U);
if peak<240||peak>250
    flag=0;
end
index1=find(U>217);
time1=(index1(end)-index1(1))*dt;
if time1<40||time1>90
    flag=0;
end
Rise=U(1:peakIndex);
index2(1)=find(Rise>=150,1);
index2(2)=find(Rise>=190,1)-1;
time2=(index2(2)-index2(1))*dt;
if time2<60||time2>120
    flag=0;
end
len=length(U);
for k=1:len-1
    if abs(U(k+1)-U(k))>3*dt
        flag=0;
        break;
    end
end