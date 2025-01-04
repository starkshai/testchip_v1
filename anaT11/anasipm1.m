clear all;
close all;
clc;
format long;

%load data
windowlen=640;
eventnumb=1;
%for i=0:1:3
for i=10:1:13
    f1=readmatrix(['v2board2\t11thac0v58f' num2str(i) '.csv']);
    flen=size(f1);
    evtnumbtot=(flen(1,1)-2)/windowlen;
    for j=1:evtnumbtot
        evtarr(eventnumb,1:windowlen)=f1(((j-1)*windowlen+3):((j-1)*windowlen+642),2);
        eventnumb=eventnumb+1;
    end
end
tarr=f1(3:642,1)*1e9;% ns unit

%plot for debug
figure(3)
for i=1:1:30
plot(tarr,evtarr(i,1:windowlen));
hold on
end

%find hit
hitnumb=0;
for i=1:(eventnumb-1)
    hitfound=0;
    for j=14:1:78%150ns to 160ns window
        if (evtarr(i,j)<0) && (evtarr(i,j+1)>0)
            hitfound=1;
            hitnumb=hitnumb+1;
            hitrisetime(1,hitnumb)=tarr(j);
            hitrisetime(2,hitnumb)=i;
            break
        end
    end
    for j=79:windowlen
        if hitfound==0
            break
        else
            if (evtarr(i,j-1)>0) && (evtarr(i,j)<0)
                hitfalltime(1,hitnumb)=tarr(j);
                hitwidth(1,hitnumb)=hitfalltime(1,hitnumb)-hitrisetime(1,hitnumb);
                break
            end
            if j==windowlen
                hitfalltime(1,hitnumb)=tarr(j);
                hitwidth(1,hitnumb)=hitfalltime(1,hitnumb)-hitrisetime(1,hitnumb);
                break
            end
        end
    end
end
%time walk correction
SPEnumb=0;
for i=1:hitnumb
    if hitwidth(1,i)<70 && hitwidth(1,i)>10%SPE width
    %if hitwidth(1,i)<25 && hitwidth(1,i)>15%MPE width    
        SPEnumb=SPEnumb+1;
        hitSPE(1,SPEnumb)=hitrisetime(1,i);
        hitSPE(2,SPEnumb)=hitfalltime(1,i);
        hitSPE(3,SPEnumb)=hitwidth(1,i);
        hitSPE(4,SPEnumb)=hitrisetime(2,i);
    end
end

figure(1)
subplot(1,2,1)
histogram(hitrisetime(1,:));
subplot(1,2,2)
histogram(hitwidth,100);
%xlim([0 90]);
%ylim([0 100]);
xlabel('ToT (ns)');
ylabel('Counts (arb.)');
figure(2)
subplot(1,3,1)
h1=histogram(hitSPE(1,:),20);
hold on
h1Values=h1.Values';
h1BinEdges=h1.BinEdges(1:end-1)';
fo1=fitoptions('gauss1');
fo1.Lower=[10 153 0];
fo1.Upper=[1000 156 1];
h1bincut=h1BinEdges(1:end);%select a part of bins for fit
h1valuecut=h1Values(1:end);
h1fit=fit(h1bincut,h1valuecut,'gauss1',fo1);
fplot(@(x) h1fit.a1*exp(-((x-h1fit.b1)/h1fit.c1)^2),[h1.BinEdges(1) h1.BinEdges(end)],'r');
mu=h1fit.b1;
sigma=h1fit.c1/sqrt(2)*1e3;%in ps
FWHM=2*sqrt(2*log(2))*sigma;
xlabel('ToA (ns)');
ylabel('Counts (arb.)');
title('V2B2 T22 SPE ToA distribution @ VB=58');
txt = {['mean = ' num2str(mu) ' ns'] , ['sigma = ' num2str(sigma) ' ps'] , ['FWHM = ' num2str(FWHM) ' ps'] , ['hit number = ' num2str(SPEnumb)]};
text(155.5,120,txt);
subplot(1,3,2)
histogram(hitSPE(3,:));
xlabel('ToT (ns)');
ylabel('Counts (arb.)');
title('V2B2 T22 SPE ToT distribution @ VB=58, Th=131.89');
subplot(1,3,3)
TOA1numb=0;
for i=1:SPEnumb
    if (hitSPE(1,i)>152) && (hitSPE(1,i)<155)%cut
        TOA1numb=TOA1numb+1;
        hitTOA1(1,TOA1numb)=hitSPE(1,i);
    end
end
h2=histogram(hitTOA1(1,:),11);
hold on
h2Values=h2.Values';
h2BinEdges=h2.BinEdges(1:end-1)';
fo2=fitoptions('gauss1');
fo2.Lower=[10 152 0];
fo2.Upper=[1000 156 1];
h2fit=fit(h2BinEdges,h2Values,'gauss1',fo2);
fplot(@(x) h2fit.a1*exp(-((x-h2fit.b1)/h2fit.c1)^2),[h2.BinEdges(1) h2.BinEdges(end)],'r');
sigma1=h2fit.c1/sqrt(2)*1e3;%in ps
FWHM1=2*sqrt(2*log(2))*sigma1;
xlabel('ToA (ns)');
ylabel('Counts (arb.)');
title('V2B2 T11 SPE ToA distribution @ VB=58');
txt = {['sigma = ' num2str(sigma1) ' ps'] , ['FWHM = ' num2str(FWHM1) ' ps'] , ['hit number = ' num2str(TOA1numb)]};
text(153.6,400,txt);
figure(4)%paper plot
%1st
% h3=histogram(hitwidth,100);
% xlim([0 90]);
% ylim([0 100]);
%2nd
h3=histogram(hitwidth,50);
xlim([0 90]);
ylim([0 160]);
xlabel('ToT (ns)');
ylabel('Counts (arb.)');
set(gca,'FontSize',13);
