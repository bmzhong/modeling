%{
作用：判断U是否满足制程界限，
输入：温度数据U，
输出：flag,1表示满足制程界限，0表示不满足制程界限
%}
function flag=isConstraint(U)
flag=1;
dt=0.001;
[peak,peakIndex]=max(U); %查找峰值及其下标
if peak<240||peak>250 %判断峰值是否在240~250之间
    flag=0; 
end
index1=find(U>217);
time1=(index1(end)-index1(1))*dt;%大于217℃的时间
if time1<40||time1>90
    flag=0;
end
Rise=U(1:peakIndex);%取温度上升部分的数据
index2(1)=find(Rise>=150,1);
index2(2)=find(Rise>=190,1)-1;
time2=(index2(2)-index2(1))*dt;% 150℃~190℃的时间
if time2<60||time2>120
    flag=0;
end
len=length(U);
for k=1:len-1
    if abs(U(k+1)-U(k))>3*dt %判断上升或下降斜率
        flag=0;
        break;
    end
end