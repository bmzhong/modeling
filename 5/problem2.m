%{
作用：用二分法查找允许最大的传送带过炉速度。
%}
Tm=[182 203 237 254];%小温区1~5，小温区6，小温区7，小温区8~9的温度向量Tm
velocity_LB=75/60;%先找一个符合条件的作为左边界
velocity_UB=100/60;%右边界
while velocity_UB-velocity_LB>1e-3
    velocity=(velocity_UB+velocity_LB)/2; %取左右边界的中点
    [~,U]=getTemperature(Tm,velocity); %获取温度数据
    flag=isConstraint(U);%判断是否满足制程界限
    if flag==1
        velocity_LB=velocity; %如果满足赋值给左边界
    else
        velocity_UB=velocity;%否则赋值给右边界
    end
end
resultVelocity=velocity_LB*60; %最大速度(单位cm/min),
fprintf('最大速度(单位cm/min): %d\n',resultVelocity);
% disp(flag);