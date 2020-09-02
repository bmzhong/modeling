function [forecast,relative_error]=Verhulst(A)
% A=[24 26 26 26 27 27 29 30 30 30 31 31 31 31 34 35 45];

[row,col]=size(A);
if row>col
    A=A';
end
n = length(A);%A�ĳ���
%��ԭʼA ���ۼ��õ�����Y
for i = 2:n
    Y(i) = A(i) - A(i - 1);
end
Y(1) = [];
%��ԭʼ���� A �����ھ�ֵ����
for i = 2:n
    z(i) = (A(i) + A(i-1))/2;
end
z(1) = []; 
B = [-z; z.^2];
Y = Y';
%ʹ����С���˷��������
u = inv(B*B')*B*Y;
u = u';
a = u(1); b = u(2);
%Ԥ������
F = []; F(1) = A(1);
for i = 2:(2*n)
    F(i) = (a*A(1))/(b*A(1)+(a - b*A(1))*exp(a*(i-1)));
end
forecast=F;
relative_error=abs(A(1:n)-F(1:n))./A(1:n);
