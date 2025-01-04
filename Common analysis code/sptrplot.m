clear all;
close all;
clc;
format long
th=[0.3 0.4 0.5 0.6 0.7];
sptrt11=[133 106 111 126 127]*2*sqrt(2*log(2));
sptrt12=[130 108 118 127 114]*2*sqrt(2*log(2));
sptrt22=[127 112 114 122 113]*2*sqrt(2*log(2));
sptrt1v=[179 139 109 111 111]*2*sqrt(2*log(2));
plot(th,sptrt11,'ro-','MarkerSize', 10);
hold on
grid on
xlim([0.25 0.75]);
ylim([240 430]);
xticks([0.3 0.4 0.5 0.6 0.7]);
plot(th,sptrt12,'b*-','MarkerSize', 10);
hold on
plot(th,sptrt22,'mx-','MarkerSize', 10);
hold on
plot(th,sptrt1v,'k.-','MarkerSize', 10);
hold off
set(gca,'FontSize',12);
xlabel('Threshold (PE)');
ylabel('SPTR (ps FWHM)');
l1=legend('T11','T12','T22','T1V');
l1.FontSize=20;