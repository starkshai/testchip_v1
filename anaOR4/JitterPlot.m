clear all;
close all;
clc;

vin=[2 3 4 5 6 7 8 9 10];
ch1sigma=[271 192 145 120 114 102 102 94 85];
ch1err=[1/sqrt(998)*ch1sigma(1) 1/sqrt(999)*ch1sigma(2) 1/sqrt(977)*ch1sigma(3) ...
    1/sqrt(976)*ch1sigma(4) 1/sqrt(960)*ch1sigma(5) 1/sqrt(960)*ch1sigma(6) ...
    1/sqrt(993)*ch1sigma(7) 1/sqrt(978)*ch1sigma(8) 1/sqrt(961)*ch1sigma(9)];
ch2sigma=[255 182 146 144 133 129 112 102 92];
ch2err=[1/sqrt(989)*ch2sigma(1) 1/sqrt(993)*ch2sigma(2) 1/sqrt(991)*ch2sigma(3) ...
    1/sqrt(986)*ch2sigma(4) 1/sqrt(976)*ch2sigma(5) 1/sqrt(996)*ch2sigma(6) ...
    1/sqrt(983)*ch2sigma(7) 1/sqrt(994)*ch2sigma(8) 1/sqrt(970)*ch2sigma(9)];
ch3sigma=[254 176 125 117 106 103 91 91 82];
ch3err=[1/sqrt(969)*ch3sigma(1) 1/sqrt(979)*ch3sigma(2) 1/sqrt(967)*ch3sigma(3) ...
    1/sqrt(983)*ch3sigma(4) 1/sqrt(972)*ch3sigma(5) 1/sqrt(988)*ch3sigma(6) ...
    1/sqrt(980)*ch3sigma(7) 1/sqrt(983)*ch3sigma(8) 1/sqrt(975)*ch3sigma(9)];
ch4sigma=[266 175 132 115 98 86 84 81 72];
ch4err=[1/sqrt(961)*ch4sigma(1) 1/sqrt(981)*ch4sigma(2) 1/sqrt(997)*ch4sigma(3) ...
    1/sqrt(992)*ch4sigma(4) 1/sqrt(997)*ch4sigma(5) 1/sqrt(986)*ch4sigma(6) ...
    1/sqrt(992)*ch4sigma(7) 1/sqrt(996)*ch4sigma(8) 1/sqrt(988)*ch4sigma(9)];

fitfun=@(A,x)sqrt(A(1)*x.^(-2)+A(2));
xf0=[0.9,140];
A1=lsqcurvefit(fitfun,xf0,vin,ch1sigma);
A2=lsqcurvefit(fitfun,xf0,vin,ch2sigma);
A3=lsqcurvefit(fitfun,xf0,vin,ch3sigma);
A4=lsqcurvefit(fitfun,xf0,vin,ch4sigma);

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
title('Board 2 OR4 timing performance');