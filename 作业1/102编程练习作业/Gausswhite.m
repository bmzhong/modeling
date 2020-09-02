function [Wt]=Gausswhite(D,N,dt)
% RandStream.setDefaultStream(RandStream('mt19937ar','Seed',sum(100*clock)))%产生种子
% N=10000;
for i=1:N+1
    X1(i)=rand ();
    if (X1(i)<0.00001)
        i=i-1;
        continue;
    end
    X2(i)=rand ();
    if (X2(i)<0.00001)
        i=i-1;
        continue;
    end
end

% D1=0.01;
% dt=0.01;

for i=1:2: N
    Y1(i)=sqrt(-2*log(X1(i)))*cos(2*pi*X2(i+1));
    Wt(i)=sqrt(2*D/dt)*Y1(i);
    Y2(i)=sqrt(-2*log(X1(i)))*sin(2*pi*X2(i+1));
    Wt(i+1)=sqrt(2*D/dt)*Y2(i);
    
end


% t=0:dt:(N-1)*dt;
% plot (t, Wt)
% axis([0 100 -8 8])