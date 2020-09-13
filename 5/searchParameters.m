%{
    作用：搜索最优的参数，并画出炉温曲线和附件数据的相应曲线进行比较
%}
clc;clear;
Data=xlsread('附件.xlsx');
P=Data(:,2);%附件第二列的温度
velocity=70/60;%题干中的速度
Tm=[175 195 235 255];%题干中四个区域的温度
error=inf;%保存最小误差
resParameter=[];%保存误差最小时对应的参数。
resR=[];%保存误差最小时对应的温度数据
for i=0.28e-4:0.02e-4:0.38e-4 %w1
    for j=0.11:0.02:0.22      %lambda1
        for u=0.32e-4:0.02e-4:0.42e-4 %w2
            for v=0.0040:0.005:0.0425  %lambda2
                para=[i,j,u,v];
                [R,U]=getTemperature(Tm,velocity,para); %得到温度数据
                R(1:38)=[];  %将前19秒删除
                % disp(max(abs(R(1:709)-P')));
                error_=mean(abs(R(1:709)-P')); %计算平均误差
                if error_<error  %更新误差最小值
                    error=error_;
                    resParameter=para; %保留误差最小时对应的参数。
                    resR=R;
                end
            end
        end
    end
end
%输出最优的参数
fprintf("w1: %6.5d  lambda1: %6.5d\n",resParameter(1),resParameter(2));
fprintf("w2: %6.5d  lambda2: %6.5d\n",resParameter(3),resParameter(4));

% 画图比较程序得出的炉温曲线和附件数据的炉温曲线
R=resR;
len1=length(P);
len2=length(R);
X=(0:len1-1)*0.5; %时间轴
plot(X,P,'-og','LineWidth',4,'MarkerIndices',1:35:len1,'MarkerSize',7,'MarkerFaceColor','g');
hold on
X=(0:len2-1)*0.5; %时间轴
plot(X,R,'-db','LineWidth',4,'MarkerIndices',1:35:len2,'MarkerSize',7,'MarkerFaceColor','b');
axis([0 360 0 250]);
xlabel('时间(s)');
ylabel('温度(℃)');
legend('附件数据的炉温曲线','拟合的炉温曲线');
grid on;
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);
set(gca,'xtick',0:15:360);
set(gca,'ytick',0:20:250);