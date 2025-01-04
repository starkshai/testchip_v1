clear all;
close all;
clc;
gensig=[23.7 20.3 21.1 17.2 14.4;57 24.1 20.2 23.1 19.7;140 56 24.1 21.5 19.6];
Q=[1 2 3 4 5];
sigma_raw=[98.74 71.45 52.73 46.45 42.48];
for i=1:5
    sigma(i)=sqrt(sigma_raw(1,i)^2-gensig(1,i)^2);
end
err=[1/sqrt(1000)*sigma(1) 1/sqrt(1000)*sigma(2) 1/sqrt(993)*sigma(3)...
     1/sqrt(994)*sigma(4) 1/sqrt(992)*sigma(5)];
E1=errorbar(Q,sigma*2*sqrt(2*log(2)),err*2*sqrt(2*log(2)));
set(E1,'LineStyle', 'none ','Color', 'r','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
xlim([0.5 5.5]);
ylim([0 320]);
xticks([1 2 3 4 5]);
set(gca,'FontSize',12);
xlabel('Input Amplitude (PE)');
ylabel('Time Jitter FWHM (ps)');
grid on
hold on

sig2s2p_raw=[128.6 92.17 72.88 58.57 54.87];
for i=1:5
    sig2s2p(i)=sqrt(sig2s2p_raw(1,i)^2-gensig(2,i)^2);
end
err2s2p=[1/sqrt(1000)*sig2s2p(1) 1/sqrt(992)*sig2s2p(2) 1/sqrt(988)*sig2s2p(3) 1/sqrt(984)*sig2s2p(4) 1/sqrt(972)*sig2s2p(5)];
E2=errorbar(Q,sig2s2p*2*sqrt(2*log(2)),err2s2p*2*sqrt(2*log(2)));
set(E2,'LineStyle', 'none ','Color', 'g','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on

sig4s2p_raw=[185.21 115.98 90.14 80.28 65.76];
for i=1:5
    sig4s2p(i)=sqrt(sig4s2p_raw(1,i)^2-gensig(3,i)^2);
end
err4s2p=[1/sqrt(1000)*sig4s2p(1) 1/sqrt(1000)*sig4s2p(2) 1/sqrt(989)*sig4s2p(3) 1/sqrt(993)*sig4s2p(4) 1/sqrt(957)*sig4s2p(5)];
E3=errorbar(Q,sig4s2p*2*sqrt(2*log(2)),err4s2p*2*sqrt(2*log(2)));
set(E3,'LineStyle', 'none ','Color', 'b','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on
simsig1=[45.7 22.14 24.06 18.86 15.16];

plot(Q,simsig1*2*sqrt(2*log(2)),'r--');

legend('Measurement with C_{single SiPM}','Measurement with C_{2s2p SiPM array}',...
    'Measurement with C_{4s2p SiPM array}','Simulation with C_{single SiPM}');
