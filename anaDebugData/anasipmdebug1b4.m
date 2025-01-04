clear all;
close all;
clc;
format long;

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
f3=readmatrix("board4\vov4a1spe1.csv");

plot(datain2(:,1)*1e9,datain2(:,2)*1000,'LineWidth',3);
grid on;
hold on;
plot(f3(3:1002,1)*1e9+11.5,f3(3:1002,2)*1000,'LineWidth',2);
xlabel('Time (ns)');
ylabel('Voltage (mV)');
legend('simulated CG output with 4 V VoV',...
    'measured CG output with 4 V VoV');
set(gca,'FontSize',12);
%title('board 1 debug1 output with SiPM');