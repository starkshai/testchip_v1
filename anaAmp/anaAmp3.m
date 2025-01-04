clear all;
close all;
clc;
format long;

freq=[1 2 5 10 20 50 80 100 120 150 180 200 220 250];%MHz
inVpp=[50.2+49.5 50.2+49.5 48.8+50.5 48.3+49.5 48.2+49.1 48.1+48.9 48.2+46.9 44.9+48.2 45.5+47.5 48.2+44.9 45+47.4 45.6+46.2 46+43.8 44.4+46.6 44.9+43.5];
outVpp=[45.8+44.9 46.3+45.3 45.6+46.9 44.5+45.7 43.8+45.5 41.5+42.8 38.8+40.5 39.5+37.9 38.5+36.8 34.4+35.7 34.1+33.2 31.8+30.2 30.5+29.7 26.7+28.2];
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