clear all;
close all;
clc;
format long;
%load data
f1=readmatrix('./board2/debug2in1mv.csv');
f2=readmatrix('./board2/debug2in2mv.csv');

f3=fopen('d2v1_post.matlab');
nline=0;
while ~feof(f3)
   a{nline+1}=fgets(f3);
   nline=nline+1;
end
fclose(f3);
datain1=zeros(nline-1,2);
for i=1:1:nline-1
   raw=str2double(strsplit(a{1,i+1},','));
   datain1(i,1)=raw(1,1);
   datain1(i,2)=raw(1,2);
end

f4=fopen('d2v2_post.matlab');
nline=0;
while ~feof(f4)
   a{nline+1}=fgets(f4);
   nline=nline+1;
end
fclose(f4);
datain2=zeros(nline-1,2);
for i=1:1:nline-1
   raw=str2double(strsplit(a{1,i+1},','));
   datain2(i,1)=raw(1,1);
   datain2(i,2)=raw(1,2);
end

plot(f1(3:end,1)*1e9,f1(3:end,2)*1000);
hold on;
plot(f1(3:end,1)*1e9,f2(3:end,2)*1000);
hold on;
plot(datain1(:,1)*1e9-21,datain1(:,2)*1000);
hold on;
plot(datain2(:,1)*1e9-21,datain2(:,2)*1000);
grid on;
xlabel('time (ns)');
ylabel('voltage (mV)');
legend('measured debug2 output w/i 1mV input','measured debug2 output w/i 2mV input',...
    'simulated debug2 output w/i 1mV input','simulated debug2 output w/i 2mV input');
title('board 2 debug2 output');