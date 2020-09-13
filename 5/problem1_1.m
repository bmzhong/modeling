%{
���ã�����һ�ʣ�����С����3,6,7���ļ�С����8�����������������ĵ��¶ȣ�
      ��¯�����ߣ�������д��result.csv�С�
%}
clc;clear;
dt=0.001;  %��ɢ����ʱ�����С�仯��λ��
smallZones=30.5; %С�����ĳ���
interval=5;  %����С����֮��ļ�����ȣ�
Tm=[173 198 230 257];%С����1~5��С����6��С����7��С����8~9���¶�����Tm
velocity=78/60; %��cm/sΪ��λʱ���ٶ�ֵvelocity��
[R,U]=getTemperature(Tm,velocity); %�õ��¶�����
t3=(25+2.5*smallZones+interval)/velocity;%�˶���С����3�е�����ʱ�䣬
index3=floor(t3/dt);%����С����3�е��¶���U�е��±꣬
T3=U(index3);%С����3�е��¶�
t6=(25+5.5*smallZones+5*interval)/velocity;%�˶���С����6�е�����ʱ�䣬
index6=floor(t6/dt);%����С����6�е��¶���U�е��±꣬
T6=U(index6);%С����6�е��¶ȣ�
t7=(25+6.5*smallZones+6*interval)/velocity;%�˶���С����7�е�����ʱ�䣬
index7=floor(t7/dt);%����С����7�е��¶���U�е��±꣬
T7=U(index7);%С����7�е��¶ȣ�
t8=(25+8*smallZones+7*interval)/velocity;%�˶���С����8����������ʱ�䣬
index8=floor(t8/dt);%����С����8�������¶���U�е��±�
T8=U(index8);%С����8�������¶ȣ�
flag=isConstraint(U);%�Ƿ������Ƴ̽��ޣ�1��ʾ�ǣ�0��ʾ��
fprintf('�Ƿ������Ƴ̽���(1��ʾ���㣬0��ʾ������):   %d\n',flag);
fprintf('С����3,6,7���ĺ����������ĵ��¶�: %d  %d   %d\n',T3,T6,T7);
fprintf('С����8�����������������ĵ��¶�: %5d\n',T8);

%��¯������
[peak,peakIndex]=max(R);%���ҷ�ֵ�����±�
index3=find(R>=217);
index3=index3(end);%���һ�����ڵ���217����±꣬
len=length(R);
X=(0:len-1)*0.5;%ʱ����
plot(X,R,'-db','LineWidth',2.5,'MarkerIndices',1:30:len,'MarkerSize',7,'MarkerFaceColor','b');
xlabel('ʱ��(s)');
ylabel('�¶�(��)');
x0=[0,peakIndex*0.5];
y0=[peak,peak];
hold on
g1=plot(x0,y0,'--','LineWidth',1.5);
set(g1,'handlevisibility','off');
text(5,peak-5,'��ֵ�¶�','FontSize',12);
x1=[0,index3*0.5];
y1=[217,217];
hold on
g2=plot(x1,y1,'--','LineWidth',1.5);
set(g2,'handlevisibility','off');
text(5,217-5,'217','FontSize',12);
plot(peakIndex*0.5,peak,'or','MarkerSize',7,'MarkerFaceColor','r');
legend('¯������','��ֵ');
text(peakIndex*0.5-15,peak-8,['��ֵ(',num2str(floor(peakIndex*0.5)),',',num2str(floor(peak)),')']);
axis([0 340 0 250]);
set(gca,'xtick',0:20:340);
set(gca,'ytick',0:20:250);
grid on
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);
%������д��result.csv�У�ȡ�������ע�ͼ���д������
% Data=[X;R];
% Data=Data';
% range=['A2:B',num2str(len+1)];
% csvwrite('result.csv',Data,1,0);