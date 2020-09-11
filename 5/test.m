clear;
%问题 1：估计左右传热系数 CL,CR。
% p,c，k
A=[300 1377 0.082
    862 2100 0.37
    74.2 17260.045
    1.18 1005 0.028];
p=A(:,1); c=A(:,2); k=A(:,3); %各层的密度，比热，热传导率
dt=0.01; %时间步长
dx=[0.1,0.1,0.1,1]'*10^(-3); %各层 dx(列向量)
lamp=k./(c.*p).*dt./(dx.^2); %计算各层 lamp
t=0:dt:5400; %获得需要计算的时间点
n=length(t); %获得时间轴总点数
L=[0.6,6,3.6,5]'*10^(-3);
P=round(L./dx); %计算各层区间数
m=sum(P)+1;%计算 x 方向总点数
U=zeros(m,n);
load d:\dat\data_2018A.txt;
data=data_2018A;
% CL=113; CR=8.35; %左、右边界传热系数,err=0.0062
minCL=0; minCR=0; min_err=1;
for CL=110:114
    for CR=8.30:0.01:8.35
        %初始 U(x,1)=37;
        U(:,1)=37;
        %注意每层末尾点序号为 P(1)+1,P(1)+P(2)+1,P(1)+P(2)+P(3)+1,P(1)+P(2)+P(3)+P(4)+1
        % 1,...,P(1)+1,......,P(1)+P(2)+1，...,P(1)+P(2)+P(3)+1,...,P(1)+P(2)+P(3)+P(4)+1
        %1.计算各层内部点,(利用内部计算公式)
        for j=1:n-1 %计算各层时间点
            
            for i=2:P(1) %I 和 II 层接触面前一点
                U(i,j+1)=(1-2*lamp(1))*U(i,j)+lamp(1)*(U(i+1,j)+U(i-1,j)); %第 I 层内部点计算
            end
            for i=P(1)+2:P(1)+P(2) %II 层和 III 层接触面前一点
                U(i,j+1)=(1-2*lamp(2))*U(i,j)+lamp(2)*(U(i+1,j)+U(i-1,j)); %第 II 层内部点计算
            end
            for i=P(1)+P(2)+2:P(1)+P(2)+P(3) %III 层和 IV 层接触面前一点
                U(i,j+1)=(1-2*lamp(3))*U(i,j)+lamp(3)*(U(i+1,j)+U(i-1,j)); %第 III 层内部点计算
            end
            for i=P(1)+P(2)+P(3)+2:P(1)+P(2)+P(3)+P(4) %%IV 层尾端前一点
                U(i,j+1)=(1-2*lamp(4))*U(i,j)+lamp(4)*(U(i+1,j)+U(i-1,j)); %第 IV 层内部点计算
            end
            %2.计算相邻两层接触点（根据两层接触面公式）
            i=P(1)+1; %I 和 II 层接触点
            U(i,j+1)=(k(1)*dx(2)*U(i-1,j+1)+k(2)*dx(1)*U(i+1,j+1))/(k(1)*dx(2)+k(2)*dx(1));
            %t1=U(i,j+1)
            i=P(1)+P(2)+1;%II 和 III 层接触点
            U(i,j+1)=(k(2)*dx(3)*U(i-1,j+1)+k(3)*dx(2)*U(i+1,j+1))/(k(2)*dx(3)+k(3)*dx(2));
            %t2=U(i,j+1)
            i=P(1)+P(2)+P(3)+1;%III 和 IV 层接触点
            U(i,j+1)=(k(3)*dx(4)*U(i-1,j+1)+k(4)*dx(3)*U(i+1,j+1))/(k(3)*dx(4)+k(4)*dx(3));
            %t3=U(i,j+1)
            %计算左边界和右边界
            U(1,j+1)=(k(1)*U(2,j+1)+75*CL*dx(1))/(CL*dx(1)+k(1));
            U(m,j+1)=(k(4)*U(m-1,j+1)+37*CR*dx(4))/(CR*dx(4)+k(4));
        end
        %获得 t 中时间为 0,1,2,...,5400 秒的序号
        tp=1:100:540001;
        len=length(data); %获得原始数据的时间点数
        U1=zeros(len,1); U2=zeros(len,1);
        for i=1:5401
            % fprintf('%2d %2d\n',data(i,1),t(tp(i)));
            U1(i)=data(i,2); %获得原始时间点处温度值
            U2(i)=U(m,tp(i)); %获得计算出的时间点处温度值
        end
        t1=data(:,1);
        % plot(t1,U1,'r',t1,U2,'b');
        err=sqrt(sum((U1-U2).^2/len)); %均方误差根
        if err<min_err min_err=err; minCL=CL; minCR=CR; end
        fprintf('CL=%6.1f CR=%6.2f err=%6.4f\n',CL,CR,err);
    end
end
fprintf('\n minCL=%6.1f minCR=%6.2f min_err=%6.4f\n',minCL,minCR,min_err);