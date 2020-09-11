function [sumMatrial,matrial,process_1,process_2,faultInformation]=process2(fault,dataClass)
if nargin==0
    fault=0;dataClass=1;
elseif nargin==1
    dataClass=1;
end
[sumMatrial,matrial,process_1,process_2,faultInformation]=solve(fault,dataClass);
end
function [sumMatrial,matrial,process_1,process_2,faultInformation]=solve(fault_,dataClass)
global process1 process2 moveTime fault
global processTime1 processTime2 oddTime evenTime washTime
fault=fault_;
if dataClass==1
    moveTime=[0,20,33,46];processTime1=400;processTime2=378;
    oddTime=28;evenTime=31;washTime=25;
elseif dataClass==2
    moveTime=[0,23,41,59];processTime1=280;processTime2=500;
    oddTime=30;evenTime=35;washTime=30;
elseif dataClass==3
    moveTime=[0,18,32,46];processTime1=455;processTime2=182;
    oddTime=27;evenTime=32;washTime=25;
end
process=[1,2,3,4,5,6,7,8];process1=[];process2=[];
sumMatrialMax=0;matrialMax=[];
for i=1:7
    A=nchoosek(process,i);
    length1=size(A,1);
    for j=1:length1
        B=A(j,:);
        process1=[];process2=[];
        for x=1:8
            if isempty(find(B==x,1))
                process1=[process1 x];
            else
                process2=[process2 x];
            end
        end
        [sumMatrial_1,matrial_1,faultInformation_]=caculate();
        if sumMatrial_1>sumMatrialMax
            sumMatrialMax=sumMatrial_1;
            matrialMax=matrial_1;
            process_1=process1;
            process_2=process2;
            faultInformation=faultInformation_;
        end
    end
end
sumMatrial=sumMatrialMax;
matrial=matrialMax;
end
function [sumMatrial,matrial,faultInformation]=caculate()
global process1 process2 len1 len2  status t
global processTime1 faultNum
global k sumMatrial T nextTime pos matrial faultInformation
T=8*60*60; %每班次连续时间（单位秒）；
t=0;%当前时刻；
k=0;
sumMatrial=0;
len1=length(process1);
len2=length(process2);
status=zeros(8,2);
matrial=zeros(1000,6);
nextTime=zeros(8,1);
faultInformation=zeros(100,4);
faultNum=0;
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
    matrial(k,2)=t-minTime;
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
    [minTime1,CNCNumber1]=getMinTimeAndCNCNumber(1);
    [minTime2,CNCNumber2]=finishedMatrial();
    if minTime1<minTime2
        handle1(minTime1,CNCNumber1);
    else
        handle2(minTime2,CNCNumber2);
    end
end
end
function [minTime,CNCNumber]=getMinTimeAndCNCNumber(phase)
global process1 process2 len1 len2  status moveTime
global oddTime evenTime washTime nextTime pos
minTime=inf;
CNCNumber=0;
if phase==1
    thisWashTime=washTime;
    process=process1;
    len=len1;
else
    thisWashTime=0;
    process=process2;
    len=len2;
end
for i=1:len
    j=process(i);
    if mod(j,2)==1
        r=abs(j-pos)/2+1;
        upDownTime=oddTime;
    else
        r=abs(j-1-pos)/2+1;
        upDownTime=evenTime;
    end
    if status(j,2)~=0
        nextTime(j)=moveTime(r)+upDownTime+thisWashTime;
    else
        nextTime(j)=moveTime(r)+upDownTime;
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
function [minTime,CNCNumber]=finishedMatrial()
global process2 status len2 oddTime evenTime
global nextTime washTime moveTime pos
minTime=inf;
CNCNumber=0;
for i=1:len2
    j=process2(i);
    if mod(j,2)==1
        r=abs(j-pos)/2+1;
        upDownTime=oddTime;
    else
        r=abs(j-1-pos)/2+1;
        upDownTime=evenTime;
    end
    if status(j,2)~=0
        nextTime(j)=moveTime(r)+upDownTime+washTime;
        if status(j,1)~=0 && moveTime(r)<status(j,1)
            nextTime(j)=nextTime(j)+status(j,1)-moveTime(r);
        end
        if nextTime(j)<minTime
            minTime=nextTime(j);
            CNCNumber=j;
        end
    end
end
end
function []=handle1(minTime,CNCNumber)
global status t k sumMatrial T  pos matrial fault faultNum
global processTime1 processTime2 oddTime evenTime washTime faultInformation
t=t+minTime;
k=k+1;
if mod(CNCNumber,2)==0
    pos=CNCNumber-1;
else
    pos=CNCNumber;
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
    breakDownTimePoint=1;
    isBreakDown=0;
    handleTime=0;
end
if isBreakDown
    status(CNCNumber,1)=round(processTime1*breakDownTimePoint+handleTime);
    faultNum=faultNum+1;
    faultInformation(faultNum,1)=k;
    faultInformation(faultNum,2)=CNCNumber;
    faultInformation(faultNum,3)=t+round(processTime1*breakDownTimePoint);
    faultInformation(faultNum,4)=faultInformation(faultNum,3)+round(handleTime);
else
    status(CNCNumber,1)=processTime1;
end
matrial(k,1)=CNCNumber;
matrialNumber=status(CNCNumber,2);
if mod(CNCNumber,2)==0
    matrial(matrialNumber,3)=t-evenTime;
    matrial(k,2)=t-evenTime;
else
    matrial(matrialNumber,3)=t-oddTime;
    matrial(k,2)=t-oddTime;
end
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
if isBreakDown
    return
end
beakDownPercentage=rand();
if fault
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
prepareMatrial=matrialNumber;
[minTime,CNCNumber]=getMinTimeAndCNCNumber(2);
t=t+minTime;
if mod(CNCNumber,2)==0
    pos=CNCNumber-1;
else
    pos=CNCNumber;
end
if status(CNCNumber,2)~=0
    matrialNumber=status(CNCNumber,2);
    if mod(CNCNumber,2)==0
        matrial(matrialNumber,6)=t-evenTime-washTime;
    else
        matrial(matrialNumber,6)=t-oddTime-washTime;
    end
    if matrial(matrialNumber,6)<=T
        sumMatrial=sumMatrial+1;
    end
end
matrial(prepareMatrial,4)=CNCNumber;
if status(CNCNumber,2)~=0
    if mod(CNCNumber,2)==0
        matrial(prepareMatrial,5)=t-washTime-evenTime;
    else
        matrial(prepareMatrial,5)=t-washTime-oddTime;
    end
else
    if mod(CNCNumber,2)==0
        matrial(prepareMatrial,5)=t-evenTime;
    else
        matrial(prepareMatrial,5)=t-oddTime;
    end
end
if status(CNCNumber,2)~=0
    if isBreakDown
        status(CNCNumber,1)=round((processTime2-washTime)*breakDownTimePoint+handleTime);
    else
        status(CNCNumber,1)=(processTime2-washTime);
    end
else
    if isBreakDown
        status(CNCNumber,1)=round(processTime2*breakDownTimePoint+handleTime);
        faultNum=faultNum+1;
        faultInformation(faultNum,2)=CNCNumber;
        faultInformation(faultNum,3)=t+round(processTime2*breakDownTimePoint);
        faultInformation(faultNum,4)=faultInformation(faultNum,3)+round(handleTime);
    else
        status(CNCNumber,1)=processTime2;
    end
end
if isBreakDown
    status(CNCNumber,2)=0;
else
    status(CNCNumber,2)=prepareMatrial;
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
function []=handle2(minTime,CNCNumber)
global status t sumMatrial T  pos matrial
global oddTime evenTime washTime
t=t+minTime;
if mod(CNCNumber,2)==0
    pos=CNCNumber-1;
else
    pos=CNCNumber;
end
matrialNumber=status(CNCNumber,2);
if mod(CNCNumber,2)==0
    matrial(matrialNumber,6)=t-evenTime-washTime;
else
    matrial(matrialNumber,6)=t-oddTime-washTime;
end
if matrial(matrialNumber,6)<=T
    sumMatrial=sumMatrial+1;
end
status(CNCNumber,2)=0;
status(CNCNumber,1)=0;
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