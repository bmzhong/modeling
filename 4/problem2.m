process1=[1,2,3,4];
process2=[5,6,7,8];
len1=length(process1);
len2=length(process2);
moveTime=[0,20,33,46];%RGV移动i个单位所需时间；
status=zeros(8,2);
processTime1=400;%加工第一道工序所需时间；
processTime2=378;
oddTime=28;%RGV为CNC1#，3#，5#，7#一次上下料所需时间;
evenTime=31;%RGV为CNC2#，4#，6#，8#一次上下料所需时间;
washTime=25;%RGV完成一个物料的清洗作业所需时间;
k=0;
sumMatrial=0;
T=8*60*60; %每班次连续时间（单位秒）；
t=0;%当前时刻；
nextTime=zeros(8,1);
pos=1;
minTime=inf;
while t<=T
    for i=1:len1
        j=process1(i);
        if mod(j,2)==1
            r=abs(j-pos)/2+1;
            if status(j,2)~=0
                nextTime(j)=moveTime(r)+oddTime+washTime;
            else
                nextTime(j)=moveTime(r)+oddTime;
            end
            if status(j,1)~=0 && moveTime(r)<status(j,1)
                nextTime(j)=nextTime(j)+status(j,1)-moveTime(r);
            end
        else
            r=abs(j-1-pos)/2+1;
            if status(j,2)~=0
                nextTime(j)=moveTime(r)+evenTime+washTime;
            else
                nextTime(j)=moveTime(r)+evenTime;
            end
            if status(j,1)~=0 && moveTime(r)<status(j,1)
                nextTime(j)=nextTime(j)+status(j,1)-moveTime(r);
            end
        end
    end
end
