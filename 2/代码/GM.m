function [res,error]=GM(A)
[row,col]=size(A);
if row>col
    A=A';
end
syms a u;
c=[a,u]';%���ɾ���
% A=[24 26 26 26 27 27 29 30 30 30 31 31 31 31 34 35 45];%�������ݣ������޸�
Ago=cumsum(A);%ԭʼ����һ���ۼ�,�õ�1-AGO����xi(1)��
n=length(A);%ԭʼ���ݸ���
number=2*n;%Ԥ�������ݸ���
for k=1:(n-1)
    Z(k)=(Ago(k)+Ago(k+1))/2; %Z(i)Ϊxi(1)�Ľ��ھ�ֵ��������
end
Yn =A;%YnΪ����������
Yn(1)=[]; %�ӵڶ�������ʼ����x(2),x(3)...
Yn=Yn';
E=[-Z;ones(1,n-1)]';%�ۼ�������������ֵ
c=(E'*E)\(E'*Yn);%���ù�ʽ���a��u
c= c';
a=c(1);%�õ�a��ֵ
u=c(2);%�õ�u��ֵ
F=[];
F(1)=A(1);
for k=2:number
    F(k)=(A(1)-u/a)/exp(a*(k-1))+u/a;%���GM(1,1)ģ�͹�ʽ
end
G=[];
G(1)=A(1);
for k=2:number
    G(k)=F(k)-F(k-1);%�������ԭԭ���У��õ�Ԥ������
end
%��������
e=A-G(1:n);
q=abs(e./A);%������
res=G;
error=q;
% disp(q);
% disp(G);
