clc;clear;
data=xlsread("appendix1.xlsx");
N=30;
R=6378000;
dist=zeros(N,N);
for i=1:N
    for j=1:N
        ja=data(i,1)*pi/180;wa=data(i,2)*pi/180;jb=data(j,1)*pi/180;wb=data(j,2)*pi/180;
        dist(i,j)=R*acos(cos(wa)*cos(wb)*cos(jb-ja)+sin(wa)*sin(wb));
    end
end
