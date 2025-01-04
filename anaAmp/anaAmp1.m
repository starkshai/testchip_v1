clear all;
close all;
clc;
format long;

freq=[1 2 5 10 20 50 80 100 120 150 180 200 220 250];%MHz
inVpp=[48.2+50.5 50.2+49.5 48.8+50.5 48.3+49.5 48.2+49.1 48.1+48.9 48.2+46.9 44.9+48.2 45.5+47.9 45.1+47.6 45.4+46.1 46.6+45.1 46.8+44.5 43.9+45.2];
outVpp=[44.9+46.2 46.2+44.2 45.3+46.3 46.2+44.7 44.9+44.2 40.9+43.1 40.8+39.1 38.1+39.2 38.1+36.1 34.4+36.2 32.6+32.7 30.5+31.5 28.7+30 27.9+27.3];
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