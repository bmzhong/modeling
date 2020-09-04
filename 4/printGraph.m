function []=printGraph(matrial)
count=50;
figure(1)
X=1:count;
Y=matrial(1:count,1);
plot(X,Y,'.b','MarkerSize',15);
hold on
for i=1:count-1
    PlotLineArrow(gca, [X(i), X(i + 1)], [Y(i), Y(i + 1)]);
end
grid on 
hold off
figure(2)
AX=matrial(1:count,2)';
BX=matrial(1:count,3)';
X=[AX;BX];
AY=1:count;
BY=1:count;
Y=[AY;BY];
plot(AX,1:count,'+','MarkerSize',8);
hold on
plot(BX,1:count,'x','MarkerSize',8);
hold on
line(X,Y,'LineWidth',1.5);
grid on
end

function PlotLineArrow(obj, x, y)
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
arrow=annotation('arrow', xNew, yNew);
arrow.HeadWidth =6;
arrow.Color=[0.3010 0.7450 0.9330];
end