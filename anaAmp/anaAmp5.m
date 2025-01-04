clear all;
close all;
clc;
format long;

freq=[1 2 5 10 20 50 80 100 120 150 180 200 220 250];%MHz
inVpp=[50.9+48.2 48.9+50.9 48.9+50.9 49.5+50.2 48.2+50.2 47.5+49.5 48.7+46.2 45.8+49 48.1+44.6 45.1+49 47+44.8 44.6+46.2 47.2+44.2 42.9+45.5];
outVpp=[44.9+45.5 45.5+46.2 45.5+46.9 46.2+45.5 44.2+44.9 42.2+42.8 38.7+39.5 38.2+38.5 36.8+36.4 35+35.2 31.9+33.9 30.4+31.3 30.1+30.1 26.9+27.6];
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
title('board 5  amp. w/i 100mVpp sin input');
%figure(2)
%plot(freq,gain,'r--+');