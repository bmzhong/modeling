function [sumMatrial,matrial,faultInformation]=process1(fault,dataClass)
if nargin==0
    fault=0;dataClass=1;
elseif nargin==1
    dataClass=1;
end
[sumMatrial,matrial,faultInformation]=solve(fault,dataClass);
end
function [sumMatrial,matrial,faultInformation]=solve(fault,dataClass)
moveTime=[0,20,33,46];%RGV移动i个单位所需时间；
processTime=560;%加工一道工序所需时间；
oddTime=28;%RGV为CNC1#，3#，5#，7#一次上下料所需时间;
evenTime=31;%RGV为CNC2#，4#，6#，8#一次上下料所需时间;
washTime=25;%RGV完成一个物料的清洗作业所需时间;
faultInformation=zeros(100,4);
faultNum=0;
if dataClass==1
    moveTime=[0,20,33,46];processTime=560;
    oddTime=28;evenTime=31;washTime=25;
elseif dataClass==2
    moveTime=[0,23,41,59];processTime=580;
    oddTime=30;evenTime=35;washTime=30;
elseif dataClass==3
    moveTime=[0,18,32,46];processTime=545;
    oddTime=27;evenTime=32;washTime=25;
end
T=8*60*60; %每班次连续时间（单位秒）；
t=0;%当前时刻；
status=zeros(8,2);
pos=1;%RGV当前时刻所在的位置，pos的值域为1,3,5,7。
matrial=zeros(1000,3);%matrial(i,:)的第1列第2列第3列分别表示第i个生料的
%加工CNC编号，上料开始时间，下料开始时间；
nextTime=zeros(8,1);%储存每个CNC需要多少时间才能进行到下一个状态。
k=0;
sumMatrial=0;
while t<=T
    for i=1:8
        if mod(i,2)==1
            r=abs(i-pos)/2+1;
            upDownTime=oddTime;
        else
            r=abs(i-1-pos)/2+1;
            upDownTime=evenTime;
        end
        if status(i,2)~=0
            nextTime(i)=moveTime(r)+upDownTime+washTime;
        else
            nextTime(i)=moveTime(r)+upDownTime;
        end
        if status(i,1)~=0 && moveTime(r)<status(i,1)
            nextTime(i)=nextTime(i)+status(i,1)-moveTime(r);
        end
    end
    minTime=min(nextTime);
    CNCNumber=find(nextTime==minTime);
    if length(CNCNumber)>1
        CNCNumber=CNCNumber(1);
    end
    t=t+minTime;
    k=k+1;
    if mod(CNCNumber,2)==0
        pos=CNCNumber-1;
    else
        pos=CNCNumber;
    end
    if status(CNCNumber,2)~=0
        matrialNumber=status(CNCNumber,2);
        if mod(CNCNumber,2)==0
            matrial(matrialNumber,3)=t-evenTime-washTime;
        else
            matrial(matrialNumber,3)=t-oddTime-washTime;
        end
        if matrial(matrialNumber,3)<=T
            sumMatrial=sumMatrial+1;
        end
    end
    if fault
        beakDownPercentage=rand();
        isBreakDown=0;
        if beakDownPercentage<0.01
            isBreakDown=1;
        end
        breakDownTimePoint=rand();
        handleTime=randn(900,1);
        if handleTime<10
            handleTime=600;
        end
        if handleTime>20
            handleTime=1200;
        end
    else
        isBreakDown=0;
        breakDownTimePoint=1;
        handleTime=0;
    end
    if status(CNCNumber,2)~=0
        if isBreakDown
            status(CNCNumber,1)=round((processTime-washTime)*breakDownTimePoint+handleTime);
            faultNum=faultNum+1;
            faultInformation(faultNum,1)=k;
            faultInformation(faultNum,2)=CNCNumber;
            faultInformation(faultNum,3)=t+round((processTime-washTime)*breakDownTimePoint);
            faultInformation(faultNum,4)=faultInformation(faultNum,3)+round(handleTime);  
        else
            status(CNCNumber,1)=processTime-washTime;
        end
    else
        if isBreakDown
            status(CNCNumber,1)=round(processTime*breakDownTimePoint+breakDownTimePoint);
        else
            status(CNCNumber,1)=processTime;
        end
    end
    matrial(k,1)=CNCNumber;
    if status(CNCNumber,2)~=0
        if mod(CNCNumber,2)==0
            matrial(k,2)=t-washTime-evenTime;
        else
            matrial(k,2)=t-washTime-oddTime;
        end
    else
        if mod(CNCNumber,2)==0
            matrial(k,2)=t-evenTime;
        else
            matrial(k,2)=t-oddTime;
        end
    end
    status(CNCNumber,2)=k;
    if isBreakDown
        status(CNCNumber,2)=0;
    end
    for j=1:8
        if j==CNCNumber
            continue;
        end
        if status(j,1)~=0
            if status(j,1)>minTime
                status(j,1)=status(j,1)-minTime;
            else
                status(j,1)=0;
            end
        end
    end
end
end