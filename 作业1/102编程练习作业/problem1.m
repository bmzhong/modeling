clear;clc;
N=60000;
dt=0.001;
D1=0.6;D2=0.55;
D3=0.6;D4=0.55;
W1=Gausswhite(D1,2*N+2,dt/2);
W2=Gausswhite(D2,2*N+2,dt/2);
W3=Gausswhite(D3,2*N+2,dt/2);
W4=Gausswhite(D4,2*N+2,dt/2);
omega1=1;omega2=2;a1=0.6;a2=0.8;b1=0.6;b2=0.68;
c1=0.1;c2=0.1;beta1=0.2;beta2=0.2;
lambda1=0.5;lambda2=0.5;alpha=2;
X1(1)=0;X2(1)=0;X3(1)=0;X4(1)=0;%∏≥≥ı÷µ
g1=@(t,x1,x2,x3,x4) x2;
g2=@(t,x1,x2,x3,x4) -beta1*(1-lambda1*x1^2-lambda1*x3^2)*x2-alpha*omega1^2*x1*(omega1^2*...
    x1^2+omega2^2*x3^2)-omega1^2*x1+(a1+b1*x1)*W1(floor(2*t/dt+1))+c1*x2*W3(floor(2*t/dt+1));
g3=@(t,x1,x2,x3,x4) x4;
g4=@(t,x1,x2,x3,x4) -beta2*(1-lambda2*x1^2-lambda2*x3^2)*x4-alpha*omega2^2*x3*(omega1^2*...
    x1^2+omega2^2*x3^2)-omega2^2*x3+(a2+b2*x3)*W3(floor(2*t/dt+1))+c2*x4*W4(floor(2*t/dt+1));
for t=0:dt:(N-2)*dt
    j=floor(t/dt+1+1e-10);
    k(1)=g1(t,X1(j),X2(j),X3(j),X4(j));
    L(1)=g2(t,X1(j),X2(j),X3(j),X4(j));
    S(1)=g3(t,X1(j),X2(j),X3(j),X4(j));
    P(1)=g4(t,X1(j),X2(j),X3(j),X4(j));
    
    k(2)=g1(t+dt/2,X1(j)+dt/2*k(1),X2(j)+dt/2*L(1),X3(j)+dt/2*S(1),X4(j)+dt/2*P(1));
    L(2)=g2(t+dt/2,X1(j)+dt/2*k(1),X2(j)+dt/2*L(1),X3(j)+dt/2*S(1),X4(j)+dt/2*P(1));
    S(2)=g3(t+dt/2,X1(j)+dt/2*k(1),X2(j)+dt/2*L(1),X3(j)+dt/2*S(1),X4(j)+dt/2*P(1));
    P(2)=g4(t+dt/2,+X1(j)+dt/2*k(1),X2(j)+dt/2*L(1),X3(j)+dt/2*S(1),X4(j)+dt/2*P(1));
    
    k(3)=g1(t+dt/2,X1(j)+dt/2*k(2),X2(j)+dt/2*L(2),X3(j)+dt/2*S(2),X4(j)+dt/2*P(2));
    L(3)=g2(t+dt/2,X1(j)+dt/2*k(2),X2(j)+dt/2*L(2),X3(j)+dt/2*S(2),X4(j)+dt/2*P(2));
    S(3)=g3(t+dt/2,X1(j)+dt/2*k(2),X2(j)+dt/2*L(2),X3(j)+dt/2*S(2),X4(j)+dt/2*P(2));
    P(3)=g4(t+dt/2,X1(j)+dt/2*k(2),X2(j)+dt/2*L(2),X3(j)+dt/2*S(2),X4(j)+dt/2*P(2));
    
    k(4)=g1(t+dt,X1(j)+dt*k(3),X2(j)+dt*L(3),X3(j)+dt*S(3),X4(j)+dt*P(3));
    L(4)=g2(t+dt,X1(j)+dt*k(3),X2(j)+dt*L(3),X3(j)+dt*S(3),X4(j)+dt*P(3));
    S(4)=g3(t+dt,X1(j)+dt*k(3),X2(j)+dt*L(3),X3(j)+dt*S(3),X4(j)+dt*P(3));
    P(4)=g4(t+dt,X1(j)+dt*k(3),X2(j)+dt*L(3),X3(j)+dt*S(3),X4(j)+dt*P(3));
    
    X1(j+1)=X1(j)+dt*(k(1)+2*k(2)+2*k(3)+k(4))/6;
    X2(j+1)=X2(j)+dt*(L(1)+2*L(2)+2*L(3)+L(4))/6;
    X3(j+1)=X3(j)+dt*(S(1)+2*S(2)+2*S(3)+S(4))/6;
    X4(j+1)=X4(j)+dt*(P(1)+2*P(2)+2*P(3)+P(4))/6;
end
figure(3)
subplot(2,2,1);
plot(0:dt:60-dt,X1);
subplot(2,2,2);
plot(0:dt:60-dt,X2);
subplot(2,2,3);
plot(0:dt:60-dt,X3);
subplot(2,2,4);
plot(0:dt:60-dt,X4);
legend('X1','X2','X3','X4');
title('problem1');