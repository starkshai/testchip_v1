clear all;
close all;
clc;
format long;
f1=readmatrix("board1\sipm2.csv");
windowlen=1000;
flen=size(f1);
evtnumb=(flen(1,1)-2)/windowlen;
evtarr=zeros(evtnumb,windowlen);
amparr=zeros(evtnumb,1);
for i=1:evtnumb
    for j=1:windowlen
        evtarr(i,j)=f1((i-1)*windowlen+j+2,2)*1e3;       
    end
    amparr(i,1)=min(evtarr(i,:));
end
tarr=f1(3:(windowlen+2),1)*1e9;
%amplitude distribution
h1=histogram(amparr);
hold on;
x=h1.BinEdges(1,6:(end-1));
x1=h1.BinWidth/2;
x2=x+x1;
y=h1.Values(1,6:end);
fit1=fit(x2',y','gauss1');
plot(fit1,x2,y);
txt = {['A = ' num2str(fit1.a1)] ,...
    ['mean = ' num2str(fit1.b1) ] , ['sigma = ' num2str(fit1.c1) ]};
text(-11,250,txt);
xlabel('Amplitude (mV)');
ylabel('Counts (arb)');
title('SiPM SPE readout amplitude distribution (Vbias=56V)');