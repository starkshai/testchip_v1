clear all;
close all;
clc;
format long;
%%plot 3 different Vbias%%
windowlen=640;
thre_h=-300+600*0.8;
thre_l=-300+600*0.2;
hittime=zeros(3,2000);
hitwidth=zeros(3,2000);
%process 1%
f1=readmatrix("board1\ov56led1v42.csv");
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

hitcnt1=0;
for i=1:evtnumb
    hitflag=0;
    for j=1:windowlen
        if evtarr(i,j)>=thre_h && hitflag==0
            hitflag=1;
            hitTOA=tarr(j,1);
        end
        if evtarr(i,j)<=thre_l && hitflag==1
            hitcnt1=hitcnt1+1;
            hittime(1,hitcnt1)=hitTOA;
            hitwidth(1,hitcnt1)=tarr(j,1)-hitTOA;
            hitflag=0;
        end
    end
end
%process 2%
f1=readmatrix("board1\ov58led1v42.csv");
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

hitcnt2=0;
for i=1:evtnumb
    hitflag=0;
    for j=1:windowlen
        if evtarr(i,j)>=thre_h && hitflag==0
            hitflag=1;
            hitTOA=tarr(j,1);
        end
        if evtarr(i,j)<=thre_l && hitflag==1
            hitcnt2=hitcnt2+1;
            hittime(2,hitcnt2)=hitTOA;
            hitwidth(2,hitcnt2)=tarr(j,1)-hitTOA;
            hitflag=0;
        end
    end
end
%process 3%
f1=readmatrix("board1\ov60led1v42.csv");
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

hitcnt3=0;
for i=1:evtnumb
    hitflag=0;
    for j=1:windowlen
        if evtarr(i,j)>=thre_h && hitflag==0
            hitflag=1;
            hitTOA=tarr(j,1);
        end
        if evtarr(i,j)<=thre_l && hitflag==1
            hitcnt3=hitcnt3+1;
            hittime(3,hitcnt3)=hitTOA;
            hitwidth(3,hitcnt3)=tarr(j,1)-hitTOA;
            hitflag=0;
        end
    end
end

figure(1)
h11=histogram(hittime(1,1:hitcnt1),'Normalization','probability',...
    'FaceColor','r','FaceAlpha',0.1);
set(h11,'EdgeColor','r');
set(h11,'LineWidth',1.5);
set(h11,'DisplayName','Vbias=56V');
hold on;
h12=histogram(hittime(2,1:hitcnt2),'Normalization','probability',...
    'FaceColor','g','FaceAlpha',0.1);
h12.FaceColor='g';
set(h12,'EdgeColor','g');
set(h12,'LineWidth',1.5);
set(h12,'DisplayName','Vbias=58V');
hold on;
h13=histogram(hittime(3,1:hitcnt3),'Normalization','probability',...
    'FaceColor','b','FaceAlpha',0.1);
h13.FaceColor='b';
set(h13,'EdgeColor','b');
set(h13,'LineWidth',1.5);
set(h13,'DisplayName','Vbias=60V');
xlabel('time (ns)');
ylabel('normalized counts');
xticks(-50:10:50);
hold off
legend;
title('TOA distribution with LED');

figure(2)
h21=histogram(hitwidth(1,1:hitcnt1),'Normalization','probability',...
    'FaceColor','r','FaceAlpha',0.1,'EdgeColor','r','LineWidth',1.5);
hold on;
h22=histogram(hitwidth(2,1:hitcnt2),'Normalization','probability',...
    'FaceColor','g','FaceAlpha',0.1,'EdgeColor','g','LineWidth',1.5);
hold on;
h23=histogram(hitwidth(3,1:hitcnt3),'Normalization','probability',...
    'FaceColor','b','FaceAlpha',0.1,'EdgeColor','b','LineWidth',1.5);
xlabel('time (ns)');
ylabel('normalized counts');
hold off
legend('Vbias=56V','Vbias=58V','Vbias=60V');
title('TOT distribution with LED');