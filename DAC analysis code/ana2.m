%analyze cbank & dac sweeping data
clear all;
close all;
clc
format long;
%load data
f1=readmatrix('board2\cbankCdacNsw1.csv');

for i=1:256
    eoffset1=(i-1)*2000+3;
    eoffset2=i*2000+2;
    vcbank(i,1:2000)=f1(eoffset1:eoffset2,2);
    vdac(i,1:2000)=f1(eoffset1:eoffset2,3);
    vcbank_mean(i)=mean(vcbank(i,1:2000))*1000;
    vcbank_rms(i)=rms(vcbank(i,1:2000)*1000-vcbank_mean(i));
    vdac_mean(i)=mean(vdac(i,1:2000))*1000;
    vdac_rms(i)=rms(vdac(i,1:2000)*1000-vdac_mean(i));
end
%calculate DNL/INL
cbank_lsb=(vcbank_mean(1)-vcbank_mean(end))/255;
cdac_lsb=(vdac_mean(end)-vdac_mean(1))/255;
for n=1:2^8-1
    cbank_dnl(n)=(vcbank_mean(n)-vcbank_mean(n+1))/cbank_lsb-1;
    cdac_dnl(n)=(vdac_mean(n+1)-vdac_mean(n))/cdac_lsb-1;
    cbank_inl(n)=sum(cbank_dnl(1:n));
    cdac_inl(n)=sum(cdac_dnl(1:n));
    %cbank_inl(n)=(vcbank_mean(n+1)+n*cbank_lsb)/cbank_lsb;
    %cdac_inl(n)=(vdac_mean(n+1)-n*cdac_lsb)/cdac_lsb;
end
%plot
dec=0:255;
figure(1)
subplot(4,2,1);
plot(dec,vcbank_mean,'r--+');
xlabel('decimal input');
ylabel('output (mV)');
title('CBANK transfer function');
subplot(4,2,2);
plot(dec,vdac_mean,'r--+');
xlabel('decimal input');
ylabel('output (mV)');
title('DAC transfer function');
subplot(4,2,3);
plot(dec,vcbank_rms,'b:.');
xlabel('decimal input');
ylabel('output rms (mV)');
title('CBANK noise');
subplot(4,2,4);
plot(dec,vdac_rms,'b:.');
xlabel('decimal input');
ylabel('output rms (mV)');
title('DAC noise');
subplot(4,2,5);
plot(dec(1:255),cbank_dnl,'b:.');
xlabel('decimal input');
ylabel('DNL (LSB)');
title('CBANK DNL');
subplot(4,2,6);
plot(dec(1:255),cdac_dnl,'b:.');
xlabel('decimal input');
ylabel('DNL (LSB)');
title('DAC DNL');
subplot(4,2,7);
plot(dec(1:255),cbank_inl,'b:.');
xlabel('decimal input');
ylabel('INL (LSB)');
title('CBANK INL');
subplot(4,2,8);
plot(dec(1:255),cdac_inl,'b:.');
xlabel('decimal input');
ylabel('INL (LSB)');
title('DAC INL');

f1=readmatrix('board2\cbankNdacCsw2.csv');
for i=1:256
    eoffset1=(i-1)*2000+3;
    eoffset2=i*2000+2;
    vcbank(i,1:2000)=f1(eoffset1:eoffset2,2);
    vdac(i,1:2000)=f1(eoffset1:eoffset2,3);
    vcbank_mean(i)=mean(vcbank(i,1:2000))*1000;
    vcbank_rms(i)=rms(vcbank(i,1:2000)*1000-vcbank_mean(i));
    vdac_mean(i)=mean(vdac(i,1:2000))*1000;
    vdac_rms(i)=rms(vdac(i,1:2000)*1000-vdac_mean(i));
end
%calculate DNL/INL
cbank_lsb=(vcbank_mean(1)-vcbank_mean(end))/255;
cdac_lsb=(vdac_mean(end)-vdac_mean(1))/255;
for n=1:2^8-1
    cbank_dnl(n)=(vcbank_mean(n)-vcbank_mean(n+1))/cbank_lsb-1;
    cdac_dnl(n)=(vdac_mean(n+1)-vdac_mean(n))/cdac_lsb-1;
    cbank_inl(n)=sum(cbank_dnl(1:n));
    cdac_inl(n)=sum(cdac_dnl(1:n));
end
%plot
dec=0:255;
figure(2)
subplot(4,2,1);
plot(dec,vcbank_mean,'r--+');
xlabel('decimal input');
ylabel('output (mV)');
title('CBANK transfer function');
subplot(4,2,2);
plot(dec,vdac_mean,'r--+');
xlabel('decimal input');
ylabel('output (mV)');
title('DAC transfer function');
subplot(4,2,3);
plot(dec,vcbank_rms,'b:.');
xlabel('decimal input');
ylabel('output rms (mV)');
title('CBANK noise');
subplot(4,2,4);
plot(dec,vdac_rms,'b:.');
xlabel('decimal input');
ylabel('output rms (mV)');
title('DAC noise');
subplot(4,2,5);
plot(dec(1:255),cbank_dnl,'b:.');
xlabel('decimal input');
ylabel('DNL (LSB)');
title('CBANK DNL');
subplot(4,2,6);
plot(dec(1:255),cdac_dnl,'b:.');
xlabel('decimal input');
ylabel('DNL (LSB)');
title('DAC DNL');
subplot(4,2,7);
plot(dec(1:255),cbank_inl,'b:.');
xlabel('decimal input');
ylabel('INL (LSB)');
title('CBANK INL');
subplot(4,2,8);
plot(dec(1:255),cdac_inl,'b:.');
xlabel('decimal input');
ylabel('INL (LSB)');
title('DAC INL');