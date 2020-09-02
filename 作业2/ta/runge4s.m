function [x,y]=runge4s(dyfun,xspan,y0,h,Gausswhite)
%�Ľ����������΢�ַ�����
%dyfunΪ΢�ַ����飬xspanΪx��Χ[]��y0Ϊ��ʼֵ���У�������hΪ����
%xΪ�Ա�����yΪ��x�ϵ��������
x=xspan(1):h:xspan(2);
N=(xspan(2)-xspan(1))/h;%N=length(x)-1
y=zeros(length(y0),length(x));
y(:,1)=y0;%��ʼֵ
W1=Gausswhite(1,:);W2=Gausswhite(2,:);W3=Gausswhite(3,:);W4=Gausswhite(4,:);
for n=1:N
    W=[W1(2*n),W2(2*n+1),W3(2*n+1),W4(2*n+2)];
    k1=feval(dyfun,x(n),y(:,n),W);
    k2=feval(dyfun,x(n)+h/2,y(:,n)+h/2*k1,W);
    k3=feval(dyfun,x(n)+h/2,y(:,n)+h/2*k2,W);
    k4=feval(dyfun,x(n+1),y(:,n)+h*k3,W);
    y(:,n+1)=y(:,n)+(h/6).*(k1+2*k2+2*k3+k4);
%     y(:,n+1)
    d=0;
end

end