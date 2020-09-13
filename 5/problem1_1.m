%{
作用：求解第一问，计算小温区3,6,7中心及小温区8结束处焊接区域中心的温度，
      画炉温曲线，将数据写入result.csv中。
%}
clc;clear;
dt=0.001;  %离散化后时间的最小变化单位，
smallZones=30.5; %小温区的长度
interval=5;  %相邻小温区之间的间隔长度，
Tm=[173 198 230 257];%小温区1~5，小温区6，小温区7，小温区8~9的温度向量Tm
velocity=78/60; %以cm/s为单位时的速度值velocity，
[R,U]=getTemperature(Tm,velocity); %得到温度数据
t3=(25+2.5*smallZones+interval)/velocity;%运动到小温区3中点所用时间，
index3=floor(t3/dt);%计算小温区3中点温度在U中的下标，
T3=U(index3);%小温区3中点温度
t6=(25+5.5*smallZones+5*interval)/velocity;%运动到小温区6中点所用时间，
index6=floor(t6/dt);%计算小温区6中点温度在U中的下标，
T6=U(index6);%小温区6中点温度，
t7=(25+6.5*smallZones+6*interval)/velocity;%运动到小温区7中点所用时间，
index7=floor(t7/dt);%计算小温区7中点温度在U中的下标，
T7=U(index7);%小温区7中点温度，
t8=(25+8*smallZones+7*interval)/velocity;%运动到小温区8结束处所用时间，
index8=floor(t8/dt);%计算小温区8结束处温度在U中的下标
T8=U(index8);%小温区8结束处温度，
flag=isConstraint(U);%是否满足制程界限，1表示是，0表示否，
fprintf('是否满足制程界限(1表示满足，0表示不满足):   %d\n',flag);
fprintf('小温区3,6,7中心焊接区域中心的温度: %d  %d   %d\n',T3,T6,T7);
fprintf('小温区8结束处焊接区域中心的温度: %5d\n',T8);

%画炉温曲线
[peak,peakIndex]=max(R);%查找峰值及其下标
index3=find(R>=217);
index3=index3(end);%最后一个大于等于217℃的下标，
len=length(R);
X=(0:len-1)*0.5;%时间轴
plot(X,R,'-db','LineWidth',2.5,'MarkerIndices',1:30:len,'MarkerSize',7,'MarkerFaceColor','b');
xlabel('时间(s)');
ylabel('温度(℃)');
x0=[0,peakIndex*0.5];
y0=[peak,peak];
hold on
g1=plot(x0,y0,'--','LineWidth',1.5);
set(g1,'handlevisibility','off');
text(5,peak-5,'峰值温度','FontSize',12);
x1=[0,index3*0.5];
y1=[217,217];
hold on
g2=plot(x1,y1,'--','LineWidth',1.5);
set(g2,'handlevisibility','off');
text(5,217-5,'217','FontSize',12);
plot(peakIndex*0.5,peak,'or','MarkerSize',7,'MarkerFaceColor','r');
legend('炉温曲线','峰值');
text(peakIndex*0.5-15,peak-8,['峰值(',num2str(floor(peakIndex*0.5)),',',num2str(floor(peak)),')']);
axis([0 340 0 250]);
set(gca,'xtick',0:20:340);
set(gca,'ytick',0:20:250);
grid on
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);
%将数据写入result.csv中，取消下面的注释即可写入数据
% Data=[X;R];
% Data=Data';
% range=['A2:B',num2str(len+1)];
% csvwrite('result.csv',Data,1,0);