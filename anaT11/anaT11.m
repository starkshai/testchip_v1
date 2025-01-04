clear all;
close all;
clc;
format long;
%load data
f1=readmatrix('board1\v284.csv');
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
    VLVDS(eventnumb,j)=f1(i,2)*1e3;%LVDS output voltage in mV
end
for i=1:eventnumb
    [t_trig_half(i),fail_trig]=findHalftime(t_ori(i,:),Vtrig(i,:),500);%43 for 100mV trigger, 500 for 1V
    [t_lvds_half(i),fail_lvds]=findHalftime(t_ori(i,:),VLVDS(i,:),0);
    t_diff(i)=(t_trig_half(i)-t_lvds_half(i))*1e9;
end
%manually tune
bin_left=-3.6;
bin_right=-1;
j=1;
for i=1:eventnumb
    if(t_diff(i)>=bin_left && t_diff(i)<=bin_right)
        t_diff_tune(j)=t_diff(i);
        j=j+1;
    end
end

figure(1)
histfit(t_diff);
pd=fitdist(t_diff','Normal');
mu=pd.mu;
sigma=pd.sigma*1e3;%in ps
FWHM=2*sqrt(2*log(2))*sigma;

xlabel('Time difference between trigger and output (ns)');
ylabel('Counts (arb.)');
title('T11 ToA distribution with 4mV step input');
txt = {['mean = ' num2str(mu) ' ns'] , ['sigma = ' num2str(sigma) ' ps'] , ['FWHM = ' num2str(FWHM) ' ps']};
text(5.1,100,txt);

figure(2)
h2=histfit(t_diff_tune);
pd2=fitdist(t_diff_tune','Normal');
mu2=pd2.mu;
sigma2=pd2.sigma*1e3;%in ps
FWHM2=2*sqrt(2*log(2))*sigma2;
eventnumb2=length(t_diff_tune);

xlabel('Time difference between trigger and output (ns)');
ylabel('Counts (arb.)');
title('T11 ToA distribution with 126mV (30dB-att) step');
txt = {['event number = ' num2str(eventnumb2)] , ['mean = ' num2str(mu2) ' ns'] , ['sigma = ' num2str(sigma2) ' ps'] , ['FWHM = ' num2str(FWHM2) ' ps']};
text(5.1,90,txt);