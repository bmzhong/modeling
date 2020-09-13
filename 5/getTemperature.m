%{ 
���룺С����1~5��С����6��С����7��С����8~9���¶�����Tm
      ��cm/sΪ��λʱ���ٶ�ֵvelocity��
      para=[w1 lambda1 w2 lambda2],�����ô˺���ʱû�д��ݲ���para��
      ��Ĭ����searchParameters.m����õ��Ĳ�����
����������������ĵ�ʱ����Ϊ0.5s���¶�����R��
      �����������ĵ�ʱ����Ϊdt���¶�����U��
���ã��󺸽�����������ʱ��仯���¶����ݡ�
%}
function [R,U]=getTemperature(Tm,velocity,para)
if nargin<3 %û��������paraʱ��Ĭ�ϲ���searchParameters.m����õ��Ĳ�����
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
smallZones=30.5;%С�����ĳ���
interval=5;     %����С����֮��ļ������
behindZone=25;  %¯ǰ���򳤶�
afterZone=25;   %¯�����򳤶�
%�ܹ����Ի���Ϊ11����ͬ��������Щ����ĳ��ȣ��¶Ȳ�ͬ���ֱ������Щ����
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
%�������̵ĺ������������¶����ݡ�
R=[R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11];
U=[U1 U2 U3 U4 U5 U6 U7 U8 U9 U10 U11];
end

%{ 
���룺�������ĳ���distance����cm/sΪ��λʱ���ٶ�ֵvelocity��
      �������ĳ�ʼ�¶�U0,����w��lambda��
      С����1~5��С����6��С����7��С����8~9���¶�����Tm
      ��ǰ��������ı��judge��
�������������������·�岻ͬ��ȴ����¶�D
      ��������ں������ĵ�ʱ����Ϊ0.5s���¶�����R��
      ��������ں������ĵ�ʱ����Ϊdt���¶�����U��
���ã����judge������ĺ�������������ʱ��仯���¶�����
      �����������ұ߽��¶ȡ�
%}
function [D,R,U]=calculatePhase(distance,velocity,U0,w,lambda,Tm,judge)
thickness=0.00015; %��·���ȣ���λΪcm��
interval=5;        %����С����֮��ļ�����ȣ�
behindZone=25;     %¯�����򳤶ȣ�
T_max=distance/velocity; %��·�徭����������ʱ�䣬
dt=0.001;          %��ɢ����ʱ�����С�仯��λ��
dx=0.000001;       %��ɢ����λ�õ���С�仯��λ��
X=ceil(thickness/dx); %��ɢ��������λ�ã�
T=ceil(T_max/dt);   %��ɢ��֮������ʱ�䣬
U=zeros(X,T);      
U(:,1)=U0;     %��ʼ�¶�
for j=1:T-1
    for i=2:X-1  %�����ڲ��������
        U(i,j+1)=(1-2*lambda)*U(i,j)+lambda*(U(i+1,j)+U(i-1,j));
    end
    %�������������򣬶Գ�ʼT0���и�ֵ
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
    %����߽��¶ȣ�
    U(1,j+1)=(dx*T0+w*U(2,j+1))/(dx+w);
    U(X,j+1)=(dx*T0+w*U(X-1,j+1))/(dx+w);
end
D=U(:,T);  %ȡ��������������ͬλ�õ��¶ȣ�
%��������ں������ĵ�ʱ����Ϊ0.5s���¶�����R��
R=U(floor(X/2),1:floor(0.5/dt):end);
%��������ں������ĵ�ʱ����Ϊdt���¶�����U��
U=U(floor(X/2),:);
end