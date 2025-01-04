clear all;
close all;
clc;

gensig=[23.7 20.3 21.1 17.2 14.4;57 24.1 20.2 23.1 19.7;140 56 24.1 21.5 19.6];
Q=[1 2 3 4 5];
sigma_raw=[123 91.32 60.72 48.83 41.45];
for i=1:5
    sigma(i)=sqrt(sigma_raw(1,i)^2-gensig(1,i)^2);
end
err=[1/sqrt(978)*sigma(1) 1/sqrt(1000)*sigma(2) 1/sqrt(1000)*sigma(3)...
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

sig2s2p_raw=[198.47 126.11 93.13 70.63 54.72];
for i=1:5
    sig2s2p(i)=sqrt(sig2s2p_raw(1,i)^2-gensig(2,i)^2);
end
err2s2p=[1/sqrt(995)*sig2s2p(1) 1/sqrt(1000)*sig2s2p(2) 1/sqrt(1000)*sig2s2p(3) 1/sqrt(1000)*sig2s2p(4) 1/sqrt(1000)*sig2s2p(5)];
E2=errorbar(Q,sig2s2p*2*sqrt(2*log(2)),err2s2p*2*sqrt(2*log(2)));
set(E2,'LineStyle', 'none ','Color', 'g','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on

sig4s2p_raw=[275.98 149.80 122.02 98.60 81.86];
for i=1:5
    sig4s2p(i)=sqrt(sig4s2p_raw(1,i)^2-gensig(3,i)^2);
end
err4s2p=[1/sqrt(997)*sig4s2p(1) 1/sqrt(1000)*sig4s2p(2) 1/sqrt(1000)*sig4s2p(3) 1/sqrt(1000)*sig4s2p(4) 1/sqrt(1000)*sig4s2p(5)];
E3=errorbar(Q,sig4s2p*2*sqrt(2*log(2)),err4s2p*2*sqrt(2*log(2)));
set(E3,'LineStyle', 'none ','Color', 'b','LineWidth', 3, 'Marker', '*', 'MarkerSize', 8, ...
         'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor' , [0,1,1]);
hold on
simsig1=[31.3 14.78 11.11 9.3 8.32];
% simsig2s2p=[92.32 27.82 18.52 14.48 12.24];
% simsig4s2p=[324 37.56 21.8 16.99 14.27];
plot(Q,simsig1*2*sqrt(2*log(2)),'r--');
% hold on
% plot(Q,simsig2s2p*2*sqrt(2*log(2)),'g--');
% hold on
% plot(Q,simsig4s2p*2*sqrt(2*log(2)),'b--');

%legend('Measurement with C_{single SiPM}','Measurement with C_{2s2p SiPM array}',...
%    'Measurement with C_{4s2p SiPM array}','Simulation with C_{single SiPM}',...
%    'Simulation with C_{2s2p SiPM array}','Simulation with C_{4s2p SiPM array}');
legend('Measurement with C_{single SiPM}','Measurement with C_{2s2p SiPM array}',...
    'Measurement with C_{4s2p SiPM array}','Simulation with C_{single SiPM}');
%title('Board 1 T11 timing performance');