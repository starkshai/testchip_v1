clear all;
close all;
clc;
format long;

f1=fopen('d1sipm1Q_post.matlab');
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

f2=fopen('d1sipm1Q8_post.matlab');
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
f3=readmatrix("board1\sipm2.csv");

plot(datain1(:,1)*1e9-12,datain1(:,2)*1000);
grid on;
hold on;
plot(datain2(:,1)*1e9-12,datain2(:,2)*1000);
hold on;
plot(f3(3:1002,1)*1e9,f3(3:1002,2)*1000);
xlabel('time (ns)');
ylabel('voltage (mV)');
legend('simulated debug1 output w/i Vov=2.2','simulated debug1 output w/i Vov=4',...
    'measured debug1 output w/i Vov=2.4');
title('board 1 debug1 output with SiPM');