function f = dyfun(t,X,Gausswhite )
%runge4s的微分方程组
omega1=1;omega2=2;a1=0.6;a2=0.8;b1=0.6;b2=0.68;c1=0.1;c2=0.1;
beta1=0.2;beta2=0.2;lambda1=0.5;lambda2=0.5;alpha=2;

W1=Gausswhite(1);W2=Gausswhite(2);W3=Gausswhite(3);W4=Gausswhite(4);%该时刻的噪声

f(1)=X(2);
f(2)=-beta1*(1-lambda1*X(1)^2-lambda1*X(3)^2)*X(1)-alpha*omega1^2*X(1)*(omega1^2*X(1)^2+omega2^2*X(3)^2)-omega1^2*X(1)+(a1+b1*X(1))*W1+c1*X(1)*W3;
f(3)=X(4);
f(4)=-beta2*(1-lambda2*X(1)^2-lambda2*X(3)^2)*X(3)-alpha*omega2^2*X(3)*(omega1^2*X(1)^2+omega2^2*X(3)^2)-omega2^2*X(3)+(a2+b2*X(3))*W2+c2*X(3)*W4;
f=f(:);

end

