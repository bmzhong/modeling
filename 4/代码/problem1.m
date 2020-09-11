clc;clear;
fault=0;
dataClass=1;
[sumMatrial,matrial]=process1(fault,dataClass);
printGraph(matrial);
T=8*60*60;
effiency=zeros(3,1);
disp('每个物料的信息在工作区中的变量matrial中或excel表中查看');
for dataClass=1:3
    time=zeros(8,1);
    [sumMatrial,matrial]=process1(fault,dataClass);
    for i=1:sumMatrial
        time(matrial(i,1))=time(matrial(i,1))+matrial(i,3)-matrial(i,2);
    end
    effiency(dataClass)=sum(time)/(8*T);
    fprintf("第%d组8小时已完成物料数量： %d\n",dataClass,sumMatrial);
%     number=1:sumMatrial;
%     Data=matrial(1:sumMatrial,:);
%     writematrix(number','Case_1_result.xls','sheet',dataClass,'range',['A2:A',num2str(sumMatrial+1)]);
%     writematrix(Data,'Case_1_result.xls','sheet',dataClass,'range',['B2:D',num2str(sumMatrial+1)]);
end
