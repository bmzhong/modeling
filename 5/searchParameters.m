clc;clear;
Data=xlsread('����.xlsx');
P=Data(:,2);%�����ڶ��е��¶�
velocity=70/60;%����е��ٶ�
Tm=[175 195 235 255];%������ĸ�������¶�
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
xlabel('ʱ��(s)');
ylabel('�¶�(��)');
legend('�������ݵ�¯������','��ϵ�¯������');
grid on;
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);
set(gca,'xtick',0:15:360);
set(gca,'ytick',0:20:250);