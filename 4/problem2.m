global process1 process2 len1 len2  status t moveTime
global processTime1 processTime2 oddTime evenTime washTime
global k sumMatrial T nextTime pos matrial 
T=8*60*60; %每班次连续时间（单位秒）；
t=0;%当前时刻；
k=0;
sumMatrial=0;
process1=[1,2,3,4];
process2=[5,6,7,8];
len1=length(process1);
len2=length(process2);
moveTime=[0,20,33,46];%RGV移动i个单位所需时间；
status=zeros(8,2);
matrial=zeros(T,3);
processTime1=400;%加工第一道工序所需时间；
processTime2=378;
oddTime=28;%RGV为CNC1#，3#，5#，7#一次上下料所需时间;
evenTime=31;%RGV为CNC2#，4#，6#，8#一次上下料所需时间;
washTime=25;%RGV完成一个物料的清洗作业所需时间;
nextTime=zeros(8,1);
pos=1;
for i=1:len1
    [minTime,CNCNumber]=getMinTimeAndCNCNumber(1);
    t=t+minTime;
    k=k+1;
    if mod(CNCNumber,2)==0
        pos=CNCNumber-1;
    else
        pos=CNCNumber;
    end
    status(CNCNumber,1)=processTime1;
    matrial(k,1)=CNCNumber;
    status(CNCNumber,2)=k;
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
while t<=T
    [minTime,CNCNumber]=getMinTimeAndCNCNumber(1);
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
end

function [minTime,CNCNumber]=getMinTimeAndCNCNumber(phase)
    global process1  len1  status moveTime oddTime  washTime nextTime pos
    minTime=inf;
    CNCNumber=0;
    if phase==1
        thisWashTime=washTime;
    else
        thisWashTime=0;
    end
    for i=1:len1
        j=process1(i);
        if mod(j,2)==1
            r=abs(j-pos)/2+1;
        else
            r=abs(j-1-pos)/2+1;
        end
        if status(j,2)~=0
            nextTime(j)=moveTime(r)+oddTime+thisWashTime;
        else
            nextTime(j)=moveTime(r)+oddTime;
        end
        if status(j,1)~=0 && moveTime(r)<status(j,1)
            nextTime(j)=nextTime(j)+status(j,1)-moveTime(r);
        end
        if nextTime(j)<minTime
            minTime=nextTime(j);
            CNCNumber=j;
        end
    end
end

