clc;clear;
dt=0.001;  %��ɢ����ʱ�����С�仯��λ��
smallZones=30.5; %С�����ĳ���
interval=5;  %����С����֮��ļ�����ȣ�
Tm=[173 198 230 257];%С����1~5��С����6��С����7��С����8~9���¶�����Tm
velocity=78/60; %��cm/sΪ��λʱ���ٶ�ֵvelocity��
[R,U]=getTemperature(Tm,velocity); %�õ��¶�����

%��¯������
[peak,peakIndex]=max(R);%���ҷ�ֵ�����±�
index=find(R>=217);
index3=index(1);
index4=index(end);%���һ�����ڵ���217����±꣬
y1=R(peakIndex:index4);
x1=zeros(1,index4-peakIndex+1);
for i=peakIndex:index4
    x1(i-peakIndex+1)=(2*peakIndex-i)*0.5;
end
x1=flip(x1,2);
y1=flip(y1,2);
x2=zeros(1,peakIndex-index3+1);
for i=index3:peakIndex
    x2(i-index3+1)=i*0.5;
end
x2=flip(x2,2);
y2=R(index3:peakIndex);
y2=flip(y2,2);
x=[x1 x2];
y=[y1 y2];
g0=plot(x1,y1,':.m','LineWidth',4);
hold on
set(g0,'handlevisibility','off');
g00=fill(x,y,'g');
hold on
set(g00,'handlevisibility','off');
len=length(R);
g01=plot([peakIndex*0.5,peakIndex*0.5],[217,peak],':.k','LineWidth',1.5);
hold on
set(g01,'handlevisibility','off');
X=(0:len-1)*0.5;%ʱ����
plot(X,R,'-db','LineWidth',2.5,'MarkerIndices',1:30:len,'MarkerSize',7,'MarkerFaceColor','b');
xlabel('ʱ��(s)');
ylabel('�¶�(��)');
legend('¯������');
x0=[0,peakIndex*0.5];
y0=[peak,peak];
hold on
g1=plot(x0,y0,'--','LineWidth',1.5);
set(g1,'handlevisibility','off');
text(5,peak-5,'��ֵ�¶�','FontSize',12);
x3=[0,index4*0.5];
y3=[217,217];
hold on
g2=plot(x3,y3,'--','LineWidth',1.5);
hold on
% plot(x1,y1,'-k');
hold on
set(g2,'handlevisibility','off');
text(5,217-5,'217','FontSize',12);
text(240,220,'S2','FontSize',12);
text(251,228,'S1','FontSize',15);
axis([0 340 0 250]);
set(gca,'xtick',0:20:340);
set(gca,'ytick',0:20:250);
grid on
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);