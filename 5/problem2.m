%{
���ã��ö��ַ������������Ĵ��ʹ���¯�ٶȡ�
%}
Tm=[182 203 237 254];%С����1~5��С����6��С����7��С����8~9���¶�����Tm
velocity_LB=75/60;%����һ��������������Ϊ��߽�
velocity_UB=100/60;%�ұ߽�
while velocity_UB-velocity_LB>1e-3
    velocity=(velocity_UB+velocity_LB)/2; %ȡ���ұ߽���е�
    [~,U]=getTemperature(Tm,velocity); %��ȡ�¶�����
    flag=isConstraint(U);%�ж��Ƿ������Ƴ̽���
    if flag==1
        velocity_LB=velocity; %������㸳ֵ����߽�
    else
        velocity_UB=velocity;%����ֵ���ұ߽�
    end
end
resultVelocity=velocity_LB*60; %����ٶ�(��λcm/min),
fprintf('����ٶ�(��λcm/min): %d\n',resultVelocity);
% disp(flag);