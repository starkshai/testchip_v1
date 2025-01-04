clear all;
close all;
clc;

th=[237 238 239 240 241];
sig2m=[1041.6 828 767 818 644];
err2m=[1/sqrt(910)*sig2m(1,1) 1/sqrt(912)*sig2m(1,2) 1/sqrt(640)*sig2m(1,3) 1/sqrt(764)*sig2m(1,4) 1/sqrt(743)*sig2m(1,5)];

E1=errorbar(th,sig2m,err2m);
set(E1,'LineStyle', 'none ','Color', 'r','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on

sig6m=[320 337 312 301 357];
err6m=[1/sqrt(947)*sig6m(1,1) 1/sqrt(943)*sig6m(1,2) 1/sqrt(927)*sig6m(1,3) 1/sqrt(873)*sig6m(1,4) 1/sqrt(822)*sig6m(1,5)];

E2=errorbar(th,sig6m,err6m);
set(E2,'LineStyle', 'none ','Color', 'b','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);

xlabel('input(mV)');
ylabel('jitter rms(ps)');
grid on
hold on

sig8m=[260 196 197 275 295];
err8m=[1/sqrt(985)*sig8m(1,1) 1/sqrt(820)*sig8m(1,2) 1/sqrt(745)*sig8m(1,3) 1/sqrt(877)*sig8m(1,4) 1/sqrt(791)*sig8m(1,5)];

E2=errorbar(th,sig8m,err8m);
set(E2,'LineStyle', 'none ','Color', 'g','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on

scatter(240.7,285);
hold on
scatter(240.7,121);
hold on
scatter(240.7,91);
legend('external threshold set with 2mV input','external threshold set with 6mV input','external threshold set with 8mV input','internal threshold set with 2mV input','internal threshold set with 6mV input','internal threshold set with 8mV input');