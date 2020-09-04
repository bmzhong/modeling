% global x
% x=3;
% disp(func());
% function x=func()
%     global x
%     disp(x)
%     x=5;
% end
% Ax=[0 0 2 ];
% Ay=[0 -1 2]; %表示起始点集A为(0,0),(0,-1),(2,2)
% Bx=[1 -2 3];
% By=[1 2 3 ];%表示终点集为B(1,1),(-2,2),(3,3)
% 
% X=[Ax ; Bx];%2*n维矩阵，第一行放起点x值，第二行放终点x值
% Y=[Ay ; By];
% line(X,Y,'Marker','.','MarkerSize',10);
% annotation('arrow', [1, 0.5], [0.6, 0.5]);
test(1)
function []=test(p)
m=p;
x = 1 : 10;
y = sin(x);
plot(x, y, '.')
hold on
for i = 1 : 9
    PlotLineArrow(gca, [x(i), x(i + 1)], [y(i), y(i + 1)], 'b', 'r');
end
hold off
end
% function PlotLineArrow(obj, x, y, markerColor, lineColor)
% % 绘制带箭头的曲线
% %{
% clear; clc;
% x = 1 : 10;
% y = sin(x);
% plot(x, y, '.')
% hold on
% for i = 1 : 9
%     PlotLineArrow(gca, [x(i), x(i + 1)], [y(i), y(i + 1)], 'b', 'r');
% end
% hold off
% %}
% % 绘制散点图
% plot(x, y, 'o', 'Color', markerColor, 'MarkerFaceColor', markerColor);
% % 获取 Axes 位置
% posAxes = get(obj, 'Position');
% posX = posAxes(1);
% posY = posAxes(2);
% width = posAxes(3);
% height = posAxes(4);
% % 获取 Axes 范围
% limX = get(obj, 'Xlim');
% limY = get(obj, 'Ylim');
% minX = limX(1);
% maxX = limX(2);
% minY = limY(1);
% maxY = limY(2);
% % 转换坐标
% xNew = posX + (x - minX) / (maxX - minX) * width;
% yNew = posY + (y - minY) / (maxY - minY) * height;
% % 画箭头
% annotation('arrow', xNew, yNew, 'color', lineColor);
% end