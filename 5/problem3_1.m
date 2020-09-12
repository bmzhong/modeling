clc;clear;
lb=[175-10 195-10 235-10 255-10 65];
ub=[175+10 195+10 235+10 255+10 100];
options=optimoptions('ga','PlotFcn',@gaplotbestf);
[x,fval,exitflag,output,population,scores]=ga(@fitness,5,[],[],[],[],lb,ub,[],1:5,options);

