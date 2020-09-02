function H=getH(x0)
N=10^6;
dt=0.001;
D1=0.6;D2=0.55;D3=0.6;D4=0.55;
omega1=1;omega2=2;a1=0.6;a2=0.8;b1=0.6;b2=0.68;c1=0.1;c2=0.1;
beta1=0.2;beta2=0.2;lambda1=0.5;lambda2=0.5;alpha=2;
W1=Gausswhite(D1,2*N+2,dt/2);
W2=Gausswhite(D2,2*N+2,dt/2);
W3=Gausswhite(D3,2*N+2,dt/2);
W4=Gausswhite(D4,2*N+2,dt/2);
X=zeros(4,N);H=zeros(1,N);
X(:,1)=x0;
f1=@(X,W) X(2);
f2=@(X,W) -beta1*(1-lambda1*X(1)^2-lambda1*X(3)^2)*X(1)-alpha*omega1^2*X(1)*(omega1^2*X(1)^2+omega2^2*X(3)^2)-omega1^2*X(1)+(a1+b1*X(1))*W(1)+c1*X(1)*W(3);
f3=@(X,W) X(4);
f4=@(X,W) -beta2*(1-lambda2*X(1)^2-lambda2*X(3)^2)*X(3)-alpha*omega2^2*X(3)*(omega1^2*X(1)^2+omega2^2*X(3)^2)-omega2^2*X(3)+(a2+b2*X(3))*W(2)+c2*X(3)*W(4);
f=@(X,W)[f1(X,W);f2(X,W);f3(X,W);f4(X,W)];
for i=1:N
    T=X(:,i);
    W=[W1(2*i),W2(2*i+1),W3(2*i+1),W4(2*i+2)];
    k1=f(T,W);
    k2=f(T+dt/2*k1,W);
    k3=f(T+dt/2*k2,W);
    k4=f(T+dt*k3,W);
    X(:,i+1)=X(:,i)+(dt/6).*(k1+2*k2+2*k3+k4);
    H(i+1)=0.5*(X(2,i+1)^2+X(4,i+1)^2)+0.5*(omega1^2*X(1,i+1)^2+omega2^2*X(3,i+1)^2)+alpha/4*(omega1^2*X(1,i+1)^2+omega2^2*X(3,i+1)^2)^2;
end
H(1)=0.5*(X(2,1)^2+X(4,1)^2)+0.5*(omega1^2*X(1,1)^2+omega2^2*X(3,1)^2)+alpha/4*(omega1^2*X(1,1)^2+omega2^2*X(3,1)^2)^2;