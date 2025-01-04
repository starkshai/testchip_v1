clear all;
close all;
clc;

vin=[1.125 2 3 4 5 6 7 8 9 10];
ch1sigma=[520 338 213 176 168 129 106 102 98];
ch1err=[1/sqrt(978)*ch1sigma(1) 1/sqrt(983)*ch1sigma(2) 1/sqrt(946)*ch1sigma(3) ...
    1/sqrt(1000)*ch1sigma(4) 1/sqrt(998)*ch1sigma(5) 1/sqrt(1000)*ch1sigma(6) ...
    1/sqrt(1000)*ch1sigma(7) 1/sqrt(967)*ch1sigma(8) 1/sqrt(971)*ch1sigma(9)];
ch2sigma=[605 246 171 135 119 103 94 90 81 76];
ch2err=[1/sqrt(888)*ch2sigma(1) 1/sqrt(995)*ch2sigma(2) 1/sqrt(1000)*ch2sigma(3) ...
    1/sqrt(996)*ch2sigma(4) 1/sqrt(1000)*ch2sigma(5) 1/sqrt(1000)*ch2sigma(6) ...
    1/sqrt(1000)*ch2sigma(7) 1/sqrt(1000)*ch2sigma(8) 1/sqrt(1000)*ch2sigma(9) 1/sqrt(1000)*ch2sigma(10)];
ch3sigma=[699 312 236 171 154 134 124 118 117 105];
ch3err=[1/sqrt(877)*ch3sigma(1) 1/sqrt(957)*ch3sigma(2) 1/sqrt(1000)*ch3sigma(3) ...
    1/sqrt(995)*ch3sigma(4) 1/sqrt(1000)*ch3sigma(5) 1/sqrt(1000)*ch3sigma(6) ...
    1/sqrt(968)*ch3sigma(7) 1/sqrt(1000)*ch3sigma(8) 1/sqrt(1000)*ch3sigma(9) 1/sqrt(1000)*ch3sigma(10)];
ch4sigma=[566 267 205 157 130 116 113 105 99 92];
ch4err=[1/sqrt(868)*ch4sigma(1) 1/sqrt(991)*ch4sigma(2) 1/sqrt(1000)*ch4sigma(3) ...
    1/sqrt(998)*ch4sigma(4) 1/sqrt(1000)*ch4sigma(5) 1/sqrt(1000)*ch4sigma(6) ...
    1/sqrt(1000)*ch4sigma(7) 1/sqrt(1000)*ch4sigma(8) 1/sqrt(1000)*ch4sigma(9) 1/sqrt(1000)*ch4sigma(10)];

fitfun=@(A,x)sqrt(A(1)*x.^(-2)+A(2));
xf0=[0.9,140];
A1=lsqcurvefit(fitfun,xf0,vin(1:end-1),ch1sigma);
A2=lsqcurvefit(fitfun,xf0,vin,ch2sigma);
A3=lsqcurvefit(fitfun,xf0,vin,ch3sigma);
A4=lsqcurvefit(fitfun,xf0,vin,ch4sigma);

E1=errorbar(vin(1:end-1),ch1sigma,ch1err);
set(E1,'LineStyle', 'none ','Color', 'r','LineWidth', 3, 'Marker', '.', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on
times = linspace(vin(1),vin(end));
plot(times,fitfun(A1,times),'r--','LineWidth', 2);
hold on
E2=errorbar(vin,ch2sigma,ch2err);
set(E2,'LineStyle', 'none ','Color', 'g','LineWidth', 3, 'Marker', '.', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on
plot(times,fitfun(A2,times),'g--','LineWidth', 2);
hold on
E3=errorbar(vin,ch3sigma,ch3err);
set(E3,'LineStyle', 'none ','Color', 'b','LineWidth', 3, 'Marker', '.', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on
plot(times,fitfun(A3,times),'b--','LineWidth', 2);
hold on
E4=errorbar(vin,ch4sigma,ch4err);
set(E4,'LineStyle', 'none ','Color', 'm','LineWidth', 3, 'Marker', '.', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on
plot(times,fitfun(A4,times),'m--','LineWidth', 2);

xlabel('input(mV)');
ylabel('jitter rms(ps)');
grid on
legend('ch1 measurement data','ch1 measured data fitting',...
    'ch2 measurement data','ch2 measured data fitting',...
    'ch3 measurement data','ch3 measured data fitting',...
    'ch4 measurement data','ch4 measured data fitting');
title('Board 5 OR4 timing performance');