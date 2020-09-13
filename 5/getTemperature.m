%{ 
输入：小温区1~5，小温区6，小温区7，小温区8~9的温度向量Tm
      以cm/s为单位时的速度值velocity，
      para=[w1 lambda1 w2 lambda2],若调用此函数时没有传递参数para，
      则默认用searchParameters.m计算得到的参数。
输出：焊接区域中心的时间间隔为0.5s的温度数据R，
      焊接区域中心的时间间隔为dt的温度数据U。
作用：求焊接区域中心随时间变化的温度数据。
%}
function [R,U]=getTemperature(Tm,velocity,para)
if nargin<3 %没有数参数para时，默认采用searchParameters.m计算得到的参数。
    w2=0.32e-4;
    lambda2=0.0425;
    w1=0.38e-4;
    lambda1=0.12;
else
    w1=para(1);
    lambda1=para(2);
    w2=para(3);
    lambda2=para(4);
end
smallZones=30.5;%小温区的长度
interval=5;     %相邻小温区之间的间隔长度
behindZone=25;  %炉前区域长度
afterZone=25;   %炉后区域长度
%总共可以划分为11个不同的区域，这些区域的长度，温度不同，分别计算这些区域。
[D1,R1,U1]=calculatePhase(behindZone,velocity,25,w1,lambda1,Tm,1);
[D2,R2,U2]=calculatePhase(5*smallZones+4*interval,velocity,D1,w1,lambda1,Tm,2);
[D3,R3,U3]=calculatePhase(interval,velocity,D2,w1,lambda1,Tm,3);
[D4,R4,U4]=calculatePhase(smallZones,velocity,D3,w1,lambda1,Tm,4);
[D5,R5,U5]=calculatePhase(interval,velocity,D4,w1,lambda1,Tm,5);
[D6,R6,U6]=calculatePhase(smallZones,velocity,D5,w1,lambda1,Tm,6);
[D7,R7,U7]=calculatePhase(interval,velocity,D6,w1,lambda1,Tm,7);
[D8,R8,U8]=calculatePhase(2*smallZones+interval,velocity,D7,w1,lambda1,Tm,8);
[D9,R9,U9]=calculatePhase(interval,velocity,D8,w2,lambda2,Tm,9);
[D10,R10,U10]=calculatePhase(2*smallZones+interval,velocity,D9,w2,lambda2,Tm,10);
[~,R11,U11]=calculatePhase(afterZone,velocity,D10,w2,lambda2,Tm,11);
%整个过程的焊接区域中心温度数据。
R=[R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11];
U=[U1 U2 U3 U4 U5 U6 U7 U8 U9 U10 U11];
end

%{ 
输入：这个区域的长度distance，以cm/s为单位时的速度值velocity，
      这个区域的初始温度U0,参数w和lambda，
      小温区1~5，小温区6，小温区7，小温区8~9的温度向量Tm
      当前计算区域的编号judge。
输出：这个区域结束处电路板不同厚度处的温度D
      这个区域内焊接中心的时间间隔为0.5s的温度数据R，
      这个区域内焊接中心的时间间隔为dt的温度数据U。
作用：求第judge个区域的焊接区域中心随时间变化的温度数据
      和这个区域的右边界温度。
%}
function [D,R,U]=calculatePhase(distance,velocity,U0,w,lambda,Tm,judge)
thickness=0.00015; %电路板厚度，单位为cm，
interval=5;        %相邻小温区之间的间隔长度，
behindZone=25;     %炉后区域长度，
T_max=distance/velocity; %电路板经过这个区域的时间，
dt=0.001;          %离散化后时间的最小变化单位，
dx=0.000001;       %离散化后位置的最小变化单位，
X=ceil(thickness/dx); %离散化后的最大位置，
T=ceil(T_max/dt);   %离散后之后的最大时间，
U=zeros(X,T);      
U(:,1)=U0;     %初始温度
for j=1:T-1
    for i=2:X-1  %计算内部点的数据
        U(i,j+1)=(1-2*lambda)*U(i,j)+lambda*(U(i+1,j)+U(i-1,j));
    end
    %根据所处的区域，对初始T0进行赋值
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
    %计算边界温度，
    U(1,j+1)=(dx*T0+w*U(2,j+1))/(dx+w);
    U(X,j+1)=(dx*T0+w*U(X-1,j+1))/(dx+w);
end
D=U(:,T);  %取这个区域结束处不同位置的温度，
%这个区域内焊接中心的时间间隔为0.5s的温度数据R，
R=U(floor(X/2),1:floor(0.5/dt):end);
%这个区域内焊接中心的时间间隔为dt的温度数据U。
U=U(floor(X/2),:);
end