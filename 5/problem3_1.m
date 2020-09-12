clc;clear;
lb=[175-10 195-10 235-10 255-10 65];
ub=[175+10 195+10 235+10 255+10 100];
IntCon=1:5;
VarNumber=5;
options=optimoptions('ga','PlotFcn',@gaplotbestf);
[x,fval,exitflag,output,population,scores]=ga(@fitness1,VarNumber,[],[],[],[],lb,ub,[],IntCon,options);

