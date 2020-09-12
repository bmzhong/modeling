clc;clear;
Data=xlsread('附件.xlsx');
P=Data(:,2);%附件第二列的温度
velocity=70/60;%题干中的速度
Tm=[175 195 235 255];%题干中四个区域的温度
for i=0.20e-4:0.01e-4:0.38e-4
    for j=0.11:0.01:0.21
        for u=0.32e-4:0.01e-4:0.50e-4
            for v=0.0035:0.001:0.050
                para=[i,j,u,v];
                [R,U]=getTemperature(Tm,velocity,para);
                R(1:38)=[];
                % disp(max(abs(R(1:709)-P')));
                error=mean(abs(R(1:709)-P'));
            end
        end
    end
end

len1=length(P);
len2=length(R);
X=(0:len1-1)*0.5;
plot(X,P,'-og','LineWidth',4,'MarkerIndices',1:35:len1,'MarkerSize',7,'MarkerFaceColor','g');
hold on
X=(0:len2-1)*0.5;
plot(X,R,'-db','LineWidth',4,'MarkerIndices',1:35:len2,'MarkerSize',7,'MarkerFaceColor','b');
axis([0 360 0 250]);
xlabel('时间(s)');
ylabel('温度(℃)');
legend('附件数据的炉温曲线','拟合的炉温曲线');
grid on;
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);
set(gca,'xtick',0:15:360);
set(gca,'ytick',0:20:250);