%{
���ã��������ʡ�
%}
clc;clear;
%С����1~5��С����6��С����7��С����8~9���¶��Լ��ٶȵ����½�
%�˴����ٶȵ�λΪcm/min,
lb=[175-10 195-10 235-10 255-10 65];
ub=[175+10 195+10 235+10 255+10 100];
IntCon=1:5;%�����������������Ϊ����
VarNumber=5;%��������
%�Ŵ��㷨��⣬fitness1Ϊ��Ӧ�Ⱥ���
options=optimoptions('ga','PlotFcn',@gaplotbestf);
[x,fval,exitflag,output,population,scores]=ga(@fitness1,VarNumber,[],[],[],[],lb,ub,[],IntCon,options);

