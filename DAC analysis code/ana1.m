clear all;
close all;
clc
format long;
%load data
for i=1:16
    f1=readmatrix(['c0819d', num2str(i-1), '.csv'] );
    t(i,:)=f1(3:end,1);
    vcbank(i,:)=f1(3:end,2);
    vdac(i,:)=f1(3:end,3);
end
%cal mean and rms in mV
for i=1:16
    vcbank_mean(i)=mean(vcbank(i,:))*1000;
    vcbank_rms(i)=rms(vcbank(i,:)*1000-vcbank_mean(i));
    vdac_mean(i)=mean(vdac(i,:))*1000;
    vdac_rms(i)=rms(vdac(i,:)*1000-vdac_mean(i));
end
%plot
dec=0:15;
figure(1)
subplot(2,2,1);
plot(dec,vcbank_mean,'r--+');
xlabel('decimal input');
ylabel('output (mV)');
title('CBANK transfer function');
subplot(2,2,2);
plot(dec,vdac_mean,'r--+');
xlabel('decimal input');
ylabel('output (mV)');
title('DAC transfer function');
subplot(2,2,3);
plot(dec,vcbank_rms,'b:.');
xlabel('decimal input');
ylabel('output rms (mV)');
title('CBANK noise');
subplot(2,2,4);
plot(dec,vdac_rms,'b:.');
xlabel('decimal input');
ylabel('output rms (mV)');
title('DAC noise');