clear all;
close all;
clc;
format long;

%%% analyze multiple files %%%

vtrig_mid=500;%in mV
vch1_mid=1;%in mV

%load data
eventsize=640;


for fn=1:7
f1=readmatrix(['ch16db4mch21v' num2str(fn) '.csv']);
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
    t_ori(eventnumb+(fn-1)*1000,j)=f1(i,1);%original time
    Vtrig(eventnumb+(fn-1)*1000,j)=f1(i,3)*1e3;%trigger voltage in mV
    VCH1(eventnumb+(fn-1)*1000,j)=f1(i,2)*1e3;%LVDS output voltage in mV
end
end

t_diff_max=[0,0];
t_diff_min=[0,1000];
for i=1:eventnumb+(fn-1)*1000
    t_trig_half(i)=findHalftime(t_ori(i,:),Vtrig(i,:),vtrig_mid,[200,400]);%43 for 100mV trigger, 500 for 1V
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
bin_left=3.2;
bin_right=4.2;
j=1;
for i=1:eventnumb+(fn-1)*1000
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
title('sig-gen 2-ch ToA distribution with 5mV (0dB-att) step');
txt = {['event number = ' num2str(eventnumb1)] , ['mean = ' num2str(mu) ' ns'] , ['sigma = ' num2str(sigma) ' ps'] , ['FWHM = ' num2str(FWHM) ' ps']};
text(13.07,90,txt);

figure(2)
h2=histfit(t_diff_tune);
pd2=fitdist(t_diff_tune','Normal');
mu2=pd2.mu;
sigma2=pd2.sigma*1e3;%in ps
FWHM2=2*sqrt(2*log(2))*sigma2;
eventnumb2=length(t_diff_tune);

xlabel('Time difference between trigger and output (ns)');
ylabel('Counts (arb.)');
title('sig-gen 2-ch ToA distribution with 5mV (0dB-att) step');
txt = {['event number = ' num2str(eventnumb2)] , ['mean = ' num2str(mu2) ' ns'] , ['sigma = ' num2str(sigma2) ' ps'] , ['FWHM = ' num2str(FWHM2) ' ps']};
text(13.07,60,txt);