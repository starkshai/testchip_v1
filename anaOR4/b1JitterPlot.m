clear all;
close all;
clc;

vin=[2 3 4 5 6 7 8 9 10];
ch1sigma=[272 175 139 135 109 102 98 89 88];
ch1err=[1/sqrt(1000)*ch1sigma(1) 1/sqrt(1000)*ch1sigma(2) 1/sqrt(1000)*ch1sigma(3) ...
    1/sqrt(995)*ch1sigma(4) 1/sqrt(1000)*ch1sigma(5) 1/sqrt(1000)*ch1sigma(6) ...
    1/sqrt(1000)*ch1sigma(7) 1/sqrt(1000)*ch1sigma(8) 1/sqrt(990)*ch1sigma(9)];
ch2sigma=[295 193 124 121 95 85 81 74 72];
ch2err=[1/sqrt(1000)*ch2sigma(1) 1/sqrt(1000)*ch2sigma(2) 1/sqrt(1000)*ch2sigma(3) ...
    1/sqrt(994)*ch2sigma(4) 1/sqrt(1000)*ch2sigma(5) 1/sqrt(1000)*ch2sigma(6) ...
    1/sqrt(1000)*ch2sigma(7) 1/sqrt(1000)*ch2sigma(8) 1/sqrt(886)*ch2sigma(9)];
ch3sigma=[339 171 131 113 97 89 80 75 69];
ch3err=[1/sqrt(1000)*ch3sigma(1) 1/sqrt(1000)*ch3sigma(2) 1/sqrt(1000)*ch3sigma(3) ...
    1/sqrt(1000)*ch3sigma(4) 1/sqrt(1000)*ch3sigma(5) 1/sqrt(1000)*ch3sigma(6) ...
    1/sqrt(1000)*ch3sigma(7) 1/sqrt(1000)*ch3sigma(8) 1/sqrt(959)*ch3sigma(9)];
ch4sigma=[273 189 140 137 107 106 99 98 86];
ch4err=[1/sqrt(1000)*ch4sigma(1) 1/sqrt(1000)*ch4sigma(2) 1/sqrt(1000)*ch4sigma(3) ...
    1/sqrt(1000)*ch4sigma(4) 1/sqrt(1000)*ch4sigma(5) 1/sqrt(986)*ch4sigma(6) ...
    1/sqrt(1000)*ch4sigma(7) 1/sqrt(1000)*ch4sigma(8) 1/sqrt(1000)*ch4sigma(9)];

fitfun=@(A,x)sqrt(A(1)*x.^(-2)+A(2));
xf0=[0.9,140];
A1=lsqcurvefit(fitfun,xf0,vin(2:end),ch1sigma(2:end));
A2=lsqcurvefit(fitfun,xf0,vin(2:end),ch2sigma(2:end));
A3=lsqcurvefit(fitfun,xf0,vin(2:end),ch3sigma(2:end));
A4=lsqcurvefit(fitfun,xf0,vin(2:end),ch4sigma(2:end));

E1=errorbar(vin,ch1sigma,ch1err);
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
title('Board 1 OR4 timing performance');