clear all;
close all;
clc;
format long;

freq=[1 2 5 10 20 50 80 100 120 150 180 200 220 250];%MHz
inVpp=[49.2+49.9 49.2+50.5 49.2+50.5 49.2+50.5 48.5+49.9 47.9+49.2 46.5+48.5 45.2+49.2 45.2+47.9 44.5+48.4 44.6+47.4 43.5+46.1 44.6+46.9 42.8+45.5];
outVpp=[45+44.7 47+45.4 47+46 46.4+46 45+44.7 41.7+42 39.7+40 38.3+38.4 36.3+36.7 35.4+35.1 33.7+33.8 31.1+30.5 28.6+28.6 26.8+25.8];
flen=length(freq);

for i=1:flen
    gain(i)=outVpp(i)/inVpp(i);
    gaindB(i)=20*log10(gain(i));
end
figure(1)
semilogx(freq,gaindB,'r--+');
grid on
xlabel('Frequency response (MHz)');
ylabel('Gain (dB)');
title('signal gen. 100mVpp sin input, Osc. 50ohm load');
%figure(2)
%plot(freq,gain,'r--+');