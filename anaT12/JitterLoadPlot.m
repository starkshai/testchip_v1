clear all;
close all;
clc;
gensig=[23.7 20.3 21.1 17.2 14.4;57 24.1 20.2 23.1 19.7;140 56 24.1 21.5 19.6];
Q=[1 2 3 4 5];
sigma_raw=[137 92.6 53 47.8 39.4];
for i=1:5
    sigma(i)=sqrt(sigma_raw(1,i)^2-gensig(1,i)^2);
end
err=[1/sqrt(982)*sigma(1) 1/sqrt(1000)*sigma(2) 1/sqrt(1000)*sigma(3)...
     1/sqrt(1000)*sigma(4) 1/sqrt(1000)*sigma(5)];
E1=errorbar(Q,sigma*2*sqrt(2*log(2)),err*2*sqrt(2*log(2)));
set(E1,'LineStyle', 'none ','Color', 'r','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
xlim([0.5 5.5]);
xticks([1 2 3 4 5]);
set(gca,'FontSize',12);
xlabel('Input Amplitude (PE)');
ylabel('Time Jitter FWHM (ps)');
grid on
hold on

sig2s2p_raw=[153.5 119.3 92.6 72.5 57.3];
for i=1:5
    sig2s2p(i)=sqrt(sig2s2p_raw(1,i)^2-gensig(2,i)^2);
end
err2s2p=[1/sqrt(1000)*sig2s2p(1) 1/sqrt(1000)*sig2s2p(2) 1/sqrt(1000)*sig2s2p(3) 1/sqrt(1000)*sig2s2p(4) 1/sqrt(1000)*sig2s2p(5)];
E2=errorbar(Q,sig2s2p*2*sqrt(2*log(2)),err2s2p*2*sqrt(2*log(2)));
set(E2,'LineStyle', 'none ','Color', 'g','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on

sig4s2p_raw=[267.2 148.1 129 89.6 81.9];
for i=1:5
    sig4s2p(i)=sqrt(sig4s2p_raw(1,i)^2-gensig(3,i)^2);
end
err4s2p=[1/sqrt(997)*sig4s2p(1) 1/sqrt(1000)*sig4s2p(2) 1/sqrt(996)*sig4s2p(3) 1/sqrt(1000)*sig4s2p(4) 1/sqrt(1000)*sig4s2p(5)];
E3=errorbar(Q,sig4s2p*2*sqrt(2*log(2)),err4s2p*2*sqrt(2*log(2)));
set(E3,'LineStyle', 'none ','Color', 'b','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on
simsig1=[30.61 16.54 12.66 10.93 9.68];

plot(Q,simsig1*2*sqrt(2*log(2)),'r--');

legend('Measurement with C_{single SiPM}','Measurement with C_{2s2p SiPM array}',...
    'Measurement with C_{4s2p SiPM array}','Simulation with C_{single SiPM}');
