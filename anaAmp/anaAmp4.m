clear all;
close all;
clc;
format long;

freq=[1 2 5 10 20 50 80 100 120 150 180 200 220 250];%MHz
inVpp=[50.2+48.2 48.9+50.9 50.9+48.9 48.2+50.9 50.2+47.5 47.7+48.9 46.2+48.2 48.6+46.8 45.9+47.9 47.6+45.2 44.7+47.5 46.8+44.9 43.8+46.6 45+42.8];
outVpp=[44.2+44.9 44.9+45.5 45.5+44.9 45.5+44.9 43.5+44.9 43.4+41.5 41.3+39.5 38.8+39.1 36.7+37.6 35.8+35.8 32.9+33.9 33.2+32.3 29.3+30.1 26.7+28.1];
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
title('board 4 amp. w/i 100mVpp sin input');
%figure(2)
%plot(freq,gain,'r--+');