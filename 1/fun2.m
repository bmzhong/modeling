function Q=fun2(n,data,L)%��ÿ���������ĵ�ص�����
v=80;r=200;f=5;N=length(n);%�������
A=eye(N,N);h=zeros(1,N);b=zeros(N,1);%��Ӧ���Ĺ�ʽ��A,h,b;
for i=1:N
    h(i)=data(n(i)+1,3)/3600;
end
for i=1:N
    for j=1:N
        if i~=j
            A(i,j)=-h(i)/(r-h(j));
        end
    end
end
for i=1:N
    t=0;
    for j=1:N
        if j~=i
            t=t+h(i)*f/(r-h(j));
        end
    end
    b(i)=f+h(i)*L/v-t;
end
Q=A\b;
end
