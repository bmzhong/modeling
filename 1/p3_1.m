clc;clear;
appendix2=xlsread("C�⸽��2.xlsx");
N=30;
R=6378000;%����뾶
data.XY=appendix2(:,1:2);%����
data.DMAT=zeros(N,N);%����������֮��ľ���
%�����
for i=1:N
    for j=1:N
        ja=appendix2(i,1)*pi/180;wa=appendix2(i,2)*pi/180;jb=appendix2(j,1)*pi/180;wb=appendix2(j,2)*pi/180;
        data.DMAT(i,j)=real(R*acos(cos(wa)*cos(wb)*cos(jb-ja)+sin(wa)*sin(wb)));
    end
end
data.NSALESMEN =4;%����·��
data.NUMITER=10000;%��������
res = genetic_algorithm(data);