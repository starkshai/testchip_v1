clear all;
close all;
clc;

vin=[1.125 2 3 4 5 6 7 8 9 10];
sigma=[642 228 174 127 116 109 108 101 102 83];
err=[1/sqrt(866)*sigma(1) 1/sqrt(887)*sigma(2) 1/sqrt(955)*sigma(3) ...
    1/sqrt(965)*sigma(4) 1/sqrt(975)*sigma(5) 1/sqrt(965)*sigma(6) ...
    1/sqrt(987)*sigma(7) 1/sqrt(988)*sigma(8) 1/sqrt(988)*sigma(9) 1/sqrt(963)*sigma(10)];

fitfun=@(A,x)sqrt(A(1)*x.^(-2)+A(2));
xf0=[0.9,140];
A=lsqcurvefit(fitfun,xf0,vin(2:end),sigma(2:end));

%plot(vin,sigma,'r*');
E1=errorbar(vin,sigma,err);
set(E1,'LineStyle', 'none ','Color', 'r','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
xlabel('input(mV)');
ylabel('jitter rms(ps)');
grid on
hold on

times = linspace(vin(1),vin(end));
plot(times,fitfun(A,times),'b--','LineWidth', 2)
hold on

simin=[1.125 2 6 8];
simsig=[407 189 60.4 44.7];
simerr=[1/sqrt(40)*simsig(1) 1/sqrt(40)*simsig(2) 1/sqrt(40)*simsig(3) 1/sqrt(40)*simsig(4)];
E2=errorbar(simin,simsig,simerr);
set(E2,'LineStyle', 'none ','Color', 'g','LineWidth', 3, 'Marker', '.', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
legend('measurement data','measured data fitting','simulation data');
title('Board 2 T12 timing performance');