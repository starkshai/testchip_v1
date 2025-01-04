clear all;
close all;
clc;
format long;
f1=readmatrix("board1\ov60led1v42.csv");
windowlen=640;
flen=size(f1);
evtnumb=(flen(1,1)-2)/windowlen;
evtarr=zeros(evtnumb,windowlen);
trigarr=zeros(evtnumb,windowlen);
amparr=zeros(evtnumb,1);
for i=1:evtnumb
    for j=1:windowlen
        trigarr(i,j)=f1((i-1)*windowlen+j+2,2)*1e3; 
        evtarr(i,j)=f1((i-1)*windowlen+j+2,3)*1e3;
    end
    amparr(i,1)=max(evtarr(i,:));
end
tarr=f1(3:(windowlen+2),1)*1e9;
%find hit
thre_h=-300+600*0.8;
thre_l=-300+600*0.2;
hitcnt=0;
hittime=zeros(1,evtnumb*2);
hitwidth=zeros(1,evtnumb*2);
for i=1:evtnumb
    hitflag=0;
    for j=1:windowlen
        if evtarr(i,j)>=thre_h && hitflag==0
            hitflag=1;
            hitTOA=tarr(j,1);
        end
        if evtarr(i,j)<=thre_l && hitflag==1
            hitcnt=hitcnt+1;
            hittime(1,hitcnt)=hitTOA;
            hitwidth(1,hitcnt)=tarr(j,1)-hitTOA;
            hitflag=0;
        end

    end
end
figure(1)
h1=histogram(hittime(1,1:hitcnt));
hold on;
x=h1.BinEdges(1,1:(end-1));
x1=h1.BinWidth/2;
x2=x+x1;
y=h1.Values(1,1:end);
fit1=fit(x2',y','gauss1');
plot(fit1,x2,y);
txt = {['A = ' num2str(fit1.a1)] ,...
    ['mean = ' num2str(fit1.b1) ] , ['sigma = ' num2str(fit1.c1) ]};
text(20,80,txt);
xlabel('time (ns)');
ylabel('counts');
title('TOA distribution with LED');
figure(2)
h2=histogram(hitwidth(1,1:hitcnt));
xlabel('time (ns)');
ylabel('counts');
title('TOT distribution with LED');