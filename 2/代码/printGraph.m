years=2020:2035;
sz=xlsread('深圳预测.xlsx');
ny=xlsread('纽约预测.xlsx');
p=6.9812;
szGDP=sz(19:34,6);
nyGDP=ny(19:34,6);
nyGDP=nyGDP.*10000*p;
figure(1)
plot(years,szGDP,'Color','b','LineWidth',2);
hold on
plot(years,nyGDP,'Color','r','LineWidth',2);
xlabel('年份');
ylabel('人均GDP/元');
title('深圳和纽约的对比图');