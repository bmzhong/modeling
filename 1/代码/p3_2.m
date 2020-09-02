clc;clear;
appendix2=xlsread("C题附件2.xlsx");
%p3_1中得到的路径
n11=[1 9 7 6 14 11 8 2];
n12=fliplr(n11);
n21=[10 12 15 27 16 13 5];
n22=fliplr(n21);
n31=[3 28 24 23 22 21 4];
n32=fliplr(n31);
n41=[17 19 29 26 25 18 20];
n42=fliplr(n41);
N=30;R=6378000;%地球半径
data.DMAT=zeros(N,N);%两个传感器之间的距离
%求距离
for i=1:N
    for j=1:N
        ja=appendix2(i,1)*pi/180;wa=appendix2(i,2)*pi/180;jb=appendix2(j,1)*pi/180;wb=appendix2(j,2)*pi/180;
        data.DMAT(i,j)=real(R*acos(cos(wa)*cos(wb)*cos(jb-ja)+sin(wa)*sin(wb)));
    end
end
%求每条路线的总距离
L1=data.DMAT(1,n11(1)+1)+data.DMAT(n11(end)+1,1);
for i=1:length(n11)-1
    L1=L1+data.DMAT(n11(i)+1,n11(i+1)+1);
end
L2=data.DMAT(1,n21(1)+1)+data.DMAT(n21(end)+1,1);
for i=1:length(n21)-1
    L2=L2+data.DMAT(n21(i)+1,n21(i+1)+1);
end
L3=data.DMAT(1,n31(1)+1)+data.DMAT(n31(end)+1,1);
for i=1:length(n31)-1
    L3=L3+data.DMAT(n31(i)+1,n31(i+1)+1);
end
L4=data.DMAT(1,n41(1)+1)+data.DMAT(n41(end)+1,1);
for i=1:length(n41)-1
    L4=L4+data.DMAT(n41(i)+1,n41(i+1)+1);
end
Q1(:,1)=fun2(n11,appendix2,L1);
Q1(:,2)=fun2(n12,appendix2,L1);
Q2(:,1)=fun2(n21,appendix2,L2);
Q2(:,2)=fun2(n22,appendix2,L2);
Q3(:,1)=fun2(n31,appendix2,L3);
Q3(:,2)=fun2(n32,appendix2,L3);
Q4(:,1)=fun2(n41,appendix2,L4);
Q4(:,2)=fun2(n42,appendix2,L4);