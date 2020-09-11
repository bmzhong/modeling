function []=printGraph(matrial)
count=50;
figure(1)
X=1:count;
Y=matrial(1:count,1);
plot(X,Y,'.g','MarkerSize',22,'MarkerEdgeColor','r');
hold on
for i=1:count-1
    PlotLineArrow(gca, [X(i), X(i + 1)], [Y(i), Y(i + 1)],'g');
end
grid on
hold off
figure(2)
AX1=matrial(1:count,2)';
BX1=matrial(1:count,3)';
X1=[AX1;BX1];
AY1=1:count;
BY1=1:count;
Y1=[AY1;BY1];
% plot(AX1,1:count,'+','MarkerSize',8);
% hold on
% plot(BX1,1:count,'x','MarkerSize',8);
% hold on
line(X1,Y1,'LineWidth',1.5);
grid on
end

function PlotLineArrow(obj, x, y,arrowColor)
plot(x, y);
% 获取 Axes 位置
posAxes = get(obj, 'Position');
posX = posAxes(1);
posY = posAxes(2);
width = posAxes(3);
height = posAxes(4);
% 获取 Axes 范围
limX = get(obj, 'Xlim');
limY = get(obj, 'Ylim');
minX = limX(1);
maxX = limX(2);
minY = limY(1);
maxY = limY(2);
% 转换坐标
xNew = posX + (x - minX) / (maxX - minX) * width;
yNew = posY + (y - minY) / (maxY - minY) * height;
% 画箭头
arrow=annotation('arrow', xNew, yNew,'LineWidth',2);
arrow.HeadWidth =15;
% arrow.Color=[0.3010 0.7450 0.9330];
arrow.Color=arrowColor;
end