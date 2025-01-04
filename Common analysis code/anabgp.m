clear all;
close all;
clc;
format long;
%load data
f1=readmatrix('v2board2\b2bgpo.csv');
filesize=size(f1);
t=f1(3:end,1)*1e6;% in us
v=f1(3:end,2)*1e3;% in mV
plot(t,v);
xticks(-50:5:50);
grid on;
xlabel('Time (us)');
ylabel('Bandgap VREF (mV)');
vref=mean(v);
vnrms=rms(v-vref);
fprintf('vref = %f mV, vn = %f mV.',vref,vnrms);