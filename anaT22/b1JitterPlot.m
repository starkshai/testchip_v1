clear all;
close all;
clc;

vin=[2 3 4 5 6 7 8 9 10];
sigma=[291 190 156 135 118 106 97 90 85];
err=[1/sqrt(999)*sigma(1) 1/sqrt(1000)*sigma(2) 1/sqrt(1000)*sigma(3) ...
    1/sqrt(1000)*sigma(4) 1/sqrt(1000)*sigma(5) 1/sqrt(1000)*sigma(6) ...
    1/sqrt(1000)*sigma(7) 1/sqrt(1000)*sigma(8) 1/sqrt(1000)*sigma(9)];

fitfun=@(A,x)sqrt(A(1)*x.^(-2)+A(2));
xf0=[0.9,140];
A=lsqcurvefit(fitfun,xf0,vin,sigma);

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

simin=[2 6 8];
simsig=[214.7 100.2 87.2];
simerr=[1/sqrt(40)*simsig(1) 1/sqrt(40)*simsig(2) 1/sqrt(40)*simsig(3)];
E2=errorbar(simin,simsig,simerr);
set(E2,'LineStyle', 'none ','Color', 'g','LineWidth', 3, 'Marker', '.', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
legend('measurement data','measured data fitting','simulation data');
title('Board 1 T22 timing performance');