clc;
rareData=xlsread("C题附件1.xlsx");
plot(rareData(1,1),rareData(1,2),'.','Color',[1,0,1],'MarkerSize',20);
hold on
text(rareData(1,1),rareData(1,2),'数据中心','Color','b');
for i=2:30
    plot(rareData(i,1),rareData(i,2),'.','Color','r','MarkerSize',15);
    hold on
    text(rareData(i,1),rareData(i,2),['传感器',num2str(i-1)],'Color','b');
end
title('数据中心和传感器的分布图');
XY=xlsread("appendix1.xlsx");
N=30;
R=6378000;
dist=zeros(N,N);
for i=1:N
    for j=1:N
        ja=XY(i,1)*pi/180;wa=XY(i,2)*pi/180;jb=XY(j,1)*pi/180;wb=XY(j,2)*pi/180;
        dist(i,j)=R*acos(cos(wa)*cos(wb)*cos(jb-ja)+sin(wa)*sin(wb));
    end
end
Z=xlsread("x矩阵.xlsx");
x=1;
for i=1:31
    for j=1:30
        t=Z(x,j);
        y=j;
        if t==1
            break;
        end
    end
    plot([rareData(x,1),rareData(y,1)],[rareData(x,2),rareData(y,2)],'-');
    hold on;
    x=y;
end
