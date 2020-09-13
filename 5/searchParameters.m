%{
    ���ã��������ŵĲ�����������¯�����ߺ͸������ݵ���Ӧ���߽��бȽ�
%}
clc;clear;
Data=xlsread('����.xlsx');
P=Data(:,2);%�����ڶ��е��¶�
velocity=70/60;%����е��ٶ�
Tm=[175 195 235 255];%������ĸ�������¶�
error=inf;%������С���
resParameter=[];%���������Сʱ��Ӧ�Ĳ�����
resR=[];%���������Сʱ��Ӧ���¶�����
for i=0.28e-4:0.02e-4:0.38e-4 %w1
    for j=0.11:0.02:0.22      %lambda1
        for u=0.32e-4:0.02e-4:0.42e-4 %w2
            for v=0.0040:0.005:0.0425  %lambda2
                para=[i,j,u,v];
                [R,U]=getTemperature(Tm,velocity,para); %�õ��¶�����
                R(1:38)=[];  %��ǰ19��ɾ��
                % disp(max(abs(R(1:709)-P')));
                error_=mean(abs(R(1:709)-P')); %����ƽ�����
                if error_<error  %���������Сֵ
                    error=error_;
                    resParameter=para; %���������Сʱ��Ӧ�Ĳ�����
                    resR=R;
                end
            end
        end
    end
end
%������ŵĲ���
fprintf("w1: %6.5d  lambda1: %6.5d\n",resParameter(1),resParameter(2));
fprintf("w2: %6.5d  lambda2: %6.5d\n",resParameter(3),resParameter(4));

% ��ͼ�Ƚϳ���ó���¯�����ߺ͸������ݵ�¯������
R=resR;
len1=length(P);
len2=length(R);
X=(0:len1-1)*0.5; %ʱ����
plot(X,P,'-og','LineWidth',4,'MarkerIndices',1:35:len1,'MarkerSize',7,'MarkerFaceColor','g');
hold on
X=(0:len2-1)*0.5; %ʱ����
plot(X,R,'-db','LineWidth',4,'MarkerIndices',1:35:len2,'MarkerSize',7,'MarkerFaceColor','b');
axis([0 360 0 250]);
xlabel('ʱ��(s)');
ylabel('�¶�(��)');
legend('�������ݵ�¯������','��ϵ�¯������');
grid on;
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);
set(gca,'xtick',0:15:360);
set(gca,'ytick',0:20:250);