clear all;
close all;
clc;
format long;
%load data
f1=readmatrix('./board2/debug1in1mv.csv');
f2=readmatrix('./board2/debug1in2mv.csv');
f3=readmatrix('./board2/debug2in1mv.csv');
f4=readmatrix('./board2/debug2in2mv.csv');

plot(f1(3:end,1)*1e9,f1(3:end,2)*1000,'LineWidth',3);
hold on;
plot(f1(3:end,1)*1e9,f2(3:end,2)*1000,'LineWidth',3);
hold on;
plot(f1(3:end,1)*1e9,f3(3:end,2)*1000,'LineWidth',3);
hold on;
plot(f1(3:end,1)*1e9,f4(3:end,2)*1000,'LineWidth',3);
grid on;
xlim([-210 300]);
xlabel('Time (ns)');
ylabel('Voltage (mV)');
l1=legend('CG output with 1 mV input','CG output with 2 mV input',...
    'NFBCG output with 1 mV input','NFBCG output with 2 mV input');
set(gca,'FontSize',13);
l1.FontSize=13;
%title('debug1 & debug2 output');