years=2020:2035;
sz=xlsread('����Ԥ��.xlsx');
ny=xlsread('ŦԼԤ��.xlsx');
p=6.9812;
szGDP=sz(19:34,6);
nyGDP=ny(19:34,6);
nyGDP=nyGDP.*10000*p;
figure(1)
plot(years,szGDP,'Color','b','LineWidth',2);
hold on
plot(years,nyGDP,'Color','r','LineWidth',2);
xlabel('���');
ylabel('�˾�GDP/Ԫ');
title('���ں�ŦԼ�ĶԱ�ͼ');