M=1000;N=60000;
X1=zeros(1,N);X2=zeros(1,N);X3=zeros(1,N);X4=zeros(1,N);
for i=1:M
    x10=rand();x20=rand();x30=rand();x40=rand();
    [Z1,Z2,Z3,Z4]=fun1(x10,x20,x30,x40);
    X1=X1+Z1;X2=X2+Z2;X3=X3+Z3;X4=X4+Z4;
end
X1=X1./M;X2=X2./M;X3=X3./M;X4=X4./M;
plot(1:N,X1,'Color','c','LineWidth',2);
hold on
plot(1:N,X2,'Color','b','LineWidth',2);
hold on;
plot(1:N,X3,'Color','k','LineWidth',2);
hold on;
plot(1:N,X4,'Color','r','LineWidth',2);
legend('X1','X2','X3','X4');
title('problem2');