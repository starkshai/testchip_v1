clear all;
close all;
clc;
format long;

%load data
windowlen=640;
eventnumb=1;
for i=10:1:13
    f1=readmatrix(['v2board2\t1vth838v58f' num2str(i) '.csv']);
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
    %for j=91:1:141%153ns to 157ns window
    for j=27:1:90%153ns to 157ns window
        if (evtarr(i,j)<0) && (evtarr(i,j+1)>0)
            hitfound=1;
            hitnumb=hitnumb+1;
            hitrisetime(1,hitnumb)=tarr(j);
            hitrisetime(2,hitnumb)=i;
            break
        end
    end
    %for j=142:windowlen
    for j=91:windowlen
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
    if hitwidth(1,i)<18.5 && hitwidth(1,i)>5%SPE width
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
histogram(hitwidth);
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
title('V2B2 T22 SPE ToA distribution @ VB=56, Th=131.89');
txt = {['mean = ' num2str(mu) ' ns'] , ['sigma = ' num2str(sigma) ' ps'] , ['FWHM = ' num2str(FWHM) ' ps'] , ['hit number = ' num2str(SPEnumb)]};
text(155.5,120,txt);
subplot(1,3,2)
histogram(hitSPE(3,:));
xlabel('ToT (ns)');
ylabel('Counts (arb.)');
title('V2B2 T22 SPE ToT distribution @ VB=56, Th=131.89');
subplot(1,3,3)
TOA1numb=0;
for i=1:SPEnumb
    if (hitSPE(1,i)>152) && (hitSPE(1,i)<156)%cut
        TOA1numb=TOA1numb+1;
        hitTOA1(1,TOA1numb)=hitSPE(1,i);
    end
end
h2=histogram(hitTOA1(1,:),17);
hold on
h2Values=h2.Values';
h2BinEdges=h2.BinEdges(1:end-1)';
fo2=fitoptions('gauss1');
fo2.Lower=[10 153 0];
fo2.Upper=[1000 156 1];
h2fit=fit(h2BinEdges,h2Values,'gauss1',fo2);
fplot(@(x) h2fit.a1*exp(-((x-h2fit.b1)/h2fit.c1)^2),[h2.BinEdges(1) h2.BinEdges(end)],'r');
ylim([0 200]);
xlabel('ToA (ns)');
ylabel('Counts (arb.)');
sigma1=h2fit.c1/sqrt(2)*1e3;%in ps
FWHM1=round(sigma1*2*sqrt(2*log(2)));
txt2={['SPTR FWHM=' num2str(FWHM1) ' ps']};
l1=legend('Measurement','Gaussuan fit');
l1.FontSize=18;
text(154.8,160,txt2,'FontSize',18);
set(gca,'FontSize',18);
hold off
figure(4)%paper plot
h3=histogram(hitTOA1(1,:),17);
hold on
h3Values=h3.Values';
h3BinEdges=h3.BinEdges(1:end-1)';
fo3=fitoptions('gauss1');
fo3.Lower=[10 153 0];
fo3.Upper=[1000 156 1];
h3fit=fit(h3BinEdges+h3.BinWidth/2,h3Values,'gauss1',fo3);
fplot(@(x) h3fit.a1*exp(-((x-h3fit.b1)/h3fit.c1)^2),[h3.BinEdges(1)+h3.BinWidth/2 h3.BinEdges(end)+h3.BinWidth/2],'r');
ylim([0 200]);
xlabel('ToA (ns)');
ylabel('Counts (arb.)');
sigma3=h3fit.c1/sqrt(2)*1e3;%in ps
FWHM3=round(sigma3*2*sqrt(2*log(2)));
txt3={['SPTR FWHM=' num2str(FWHM3) ' ps']};
l3=legend('Measurement','Gaussuan fit');
l3.FontSize=13;
text(155,150,txt3,'FontSize',13);
set(gca,'FontSize',13);
hold off