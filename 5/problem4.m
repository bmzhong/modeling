clc;clear;
lb=[175-10 195-10 235-10 255-10 65];
ub=[175+10 195+10 235+10 255+10 100];
IntCon=1:5;%上述五个变量都限制为整数
VarNumber=5;%变量个数
options=optimoptions('ga','PlotFcn',@gaplotbestf);
[x,fval,exitflag,output,population,scores]=ga(@fitness2,VarNumber,[],[],[],[],lb,ub,[],IntCon,options);