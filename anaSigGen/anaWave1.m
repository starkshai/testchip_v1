clear all;
close all;
clc;
format long;

vtrig_mid=500;%in mV
vch1_mid=2.5;%in mV

%load data
f1=readmatrix('db30v949.csv');
eventsize=640;
filesize=size(f1);

eventnumb=1;
j=0;
for i=3:filesize(1,1)
    if(i== (eventnumb*eventsize+3))
          eventnumb=eventnumb+1; 
          j=0;
    end
    j=j+1;
    %t_nom(eventnumb,j)=(f1(i,1)-(eventnumb-1)*1e-3)*1e9;%normalized time in ns
    t_ori(eventnumb,j)=f1(i,1);%original time
    Vtrig(eventnumb,j)=f1(i,3)*1e3;%trigger voltage in mV
    VCH1(eventnumb,j)=f1(i,2)*1e3;%LVDS output voltage in mV
end

t_diff_max=[0,0];
t_diff_min=[0,1000];
for i=1:eventnumb
    t_trig_half(i)=findHalftime(t_ori(i,:),Vtrig(i,:),vtrig_mid,[100,400]);%43 for 100mV trigger, 500 for 1V
    t_lvds_half(i)=findHalftime(t_ori(i,:),VCH1(i,:),vch1_mid,[100,300]);
    t_diff(i)=(t_trig_half(i)-t_lvds_half(i))*1e9;
    if(t_diff(i)>t_diff_max(2))
        t_diff_max(2)=t_diff(i);
        t_diff_max(1)=i;
    end
    if(t_diff(i)<t_diff_min(2))
        t_diff_min(2)=t_diff(i);
        t_diff_min(1)=i;
    end
end

%manually tune
bin_left=-1.2;
bin_right=0.5;
j=1;
for i=1:eventnumb
    if(t_diff(i)>=bin_left && t_diff(i)<=bin_right)
        t_diff_tune(j)=t_diff(i);
        j=j+1;
    end
end
%plot and fit
figure(1)
h=histfit(t_diff);
pd=fitdist(t_diff','Normal');
mu=pd.mu;
sigma=pd.sigma*1e3;%in ps
FWHM=2*sqrt(2*log(2))*sigma;
eventnumb1=length(t_diff);

xlabel('Time difference between trigger and output (ns)');
ylabel('Counts (arb.)');
title('sig-gen 2-ch ToA distribution with 949mV (30dB-att) step');
txt = {['event number = ' num2str(eventnumb1)] , ['mean = ' num2str(mu) ' ns'] , ['sigma = ' num2str(sigma) ' ps'] , ['FWHM = ' num2str(FWHM) ' ps']};
text(13.07,90,txt);

figure(2)
h2=histfit(t_diff_tune);
pd2=fitdist(t_diff_tune','Normal');
mu2=pd2.mu;
sigma2=pd2.sigma*1e3;%in ps
FWHM2=2*sqrt(2*log(2))*sigma2;
eventnumb2=length(t_diff_tune);
set(gca,'FontSize',12);
xlabel('ToA (ns)');
ylabel('Counts (arb.)');
%title('sig-gen 2-ch ToA distribution with 949mV (30dB-att) step');
%txt = {['event number = ' num2str(eventnumb2)] , ['mean = ' num2str(mu2) ' ns'] , ['sigma = ' num2str(sigma2) ' ps'] , ['FWHM = ' num2str(FWHM2) ' ps']};
legend('Measurement','Fit');
txt = {['\sigma = ' num2str(sigma2) ' ps'] , ['FWHM = ' num2str(FWHM2) ' ps']};
text(0.38,80,txt);
