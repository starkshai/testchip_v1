clear all;
close all;
clc;
format long;
f1=fopen('d1sipm1Q8_post.matlab');
nline=0;
while ~feof(f1)
   a{nline+1}=fgets(f1);
   nline=nline+1;
end
fclose(f1);
datain1=zeros(nline-1,2);
for i=1:1:nline-1
   raw=str2double(strsplit(a{1,i+1},','));
   datain1(i,1)=raw(1,1);
   datain1(i,2)=raw(1,2);
end
f4=readmatrix("board4\vov4a1spe1.csv");

f2=fopen('d2sipm1Q8_post.matlab');
nline=0;
while ~feof(f2)
   a{nline+1}=fgets(f2);
   nline=nline+1;
end
fclose(f2);
datain2=zeros(nline-1,2);
for i=1:1:nline-1
   raw=str2double(strsplit(a{1,i+1},','));
   datain2(i,1)=raw(1,1);
   datain2(i,2)=raw(1,2);
end
f3=readmatrix("board4\vov4a2spe1.csv");

plot(datain1(:,1)*1e9,datain1(:,2)*1000,'LineWidth',3);
hold on
plot(f4(3:1002,1)*1e9+11.5,f4(3:1002,2)*1000,'LineWidth',3);
hold on
plot(datain2(:,1)*1e9,datain2(:,2)*1000,'LineWidth',3);
grid on
hold on
plot(f3(3:1002,1)*1e9+11.5,f3(3:1002,2)*1000,'LineWidth',3);
xlabel('Time (ns)');
ylabel('Voltage (mV)');
l1=legend('Simulated CG output with 4 V VoV','Measured CG output with 4 V VoV',...
    'Simulated NFBCG output with 4 V VoV','Measured NFBCG output with 4 V VoV');
set(gca,'FontSize',13);
l1.FontSize=13;
%title('board 1 debug1 output with SiPM');