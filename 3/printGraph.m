% x=[-7:2:7];y=[7:-2:-7];
% dot=zeros(64,2);
% n=length(x);
% c=1;
% for j=1:n
%     for i=1:n
%         dot(c,1)=x(i);
%         dot(c,2)=y(j);
%         c=c+1;
%     end
% end
% str = strings(1,64);
% str(1)='A1';
% for i=1:64
%     str(i)=['A',num2str(i)];
% end
% plot(dot(:,1),dot(:,2),'r*','Markersize',6);
% text(dot(:,1)+0.12,dot(:,2),str(:),'FontAngle','italic','FontWeight','bold');
% xlabel('In-phase');
% ylabel('Quadrature');
% load('p3.mat');
% R=r(1:64);
% thelta=zeros(1,64);x=zeros(1,64);y=zeros(1,64);
% for i=1:64
%     thelta(i)=rand()*2*pi;
%     x(i)=R(i)*cos(thelta(i));
%     y(i)=R(i)*sin(thelta(i));
% end
% plot(x,y,'*');
% hold on
% plot(0,0,'.');
% plot(r(1:64),r(65:128),'.');