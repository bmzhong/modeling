clc;clear;
Tm=[182 203 237 254];
velocity_LB=76/60;
velocity_UB=100/60;
while velocity_UB-velocity_LB>1e-5
    velocity=(velocity_UB+velocity_LB)/2;
    [~,U]=getTemperature(Tm,velocity);
    flag=isConstraint(U);
    if flag==1
        velocity_LB=velocity;
    else
        velocity_UB=velocity;
    end
end
resultVelocity=velocity_LB*60;
disp(resultVelocity);
disp(flag);