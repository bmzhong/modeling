clc;clear;
lb=[175-10 195-10 235-10 255-10 65];
ub=[175+10 195+10 235+10 255+10 100];
options=optimoptions('gamultiobj','PlotFcn',@gaplotpareto);
[x,fval,exitflag,output,population,scores]=gamultiobj(@fitness2,5,[],[],[],[],lb,ub,[],options);