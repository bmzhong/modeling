clc;clear;
shenzhen=xlsread('深圳.xlsx');
col=size(shenzhen,2);
for i=2:col
    A=shenzhen(:,i);
    if i==8
        A=A.*100000;
    end
    [res,relative_error]=GM(A);
    res=res';
    if i~=5&&i~=9&&i~=10&&i~=12
        res=floor(res);
    end
    error=sum(relative_error)/length(A);
    res=[res;error];
    if i==8
        res=res./100000;
    end
    writematrix(res,'深圳预测.xlsx','sheet',1,'range',[char(65+i-1),'2',':',char(65+i-1),'36']);
end
newyork=xlsread('纽约市.xlsx');
col=size(newyork,2);
for i=2:col
    A=newyork(:,i);
    if i==6
        A=A.*10000;
    end
    if i==8
        A=A.*100000;
    end
    [res,relative_error]=GM(A);
    res=res';
    if i~=5&&i~=9&&i~=10&&i~=12
        res=floor(res);
    end
    error=sum(relative_error)/length(A);
    res=[res;error];
    if i==8
        res=res./100000;
    end
    if i==6
        res=res./10000;
    end
    writematrix(res,'纽约预测.xlsx','sheet',1,'range',[char(65+i-1),'2',':',char(65+i-1),'36']);
end