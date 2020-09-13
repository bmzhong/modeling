%{
作用：求解第三问。
%}
clc;clear;
%小温区1~5，小温区6，小温区7，小温区8~9的温度以及速度的上下界
%此处的速度单位为cm/min,
lb=[175-10 195-10 235-10 255-10 65];
ub=[175+10 195+10 235+10 255+10 100];
IntCon=1:5;%上述五个变量都限制为整数
VarNumber=5;%变量个数
%遗传算法求解，fitness1为适应度函数
options=optimoptions('ga','PlotFcn',@gaplotbestf);
[x,fval,exitflag,output,population,scores]=ga(@fitness1,VarNumber,[],[],[],[],lb,ub,[],IntCon,options);

