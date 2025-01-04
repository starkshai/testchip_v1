clear all;
format long
%for 10-bit dac voltage to hex convert
dataraw= 0x200;%1v->0x238
dataraw_s=bitshift(dataraw,2);
datadac=dec2hex(dataraw_s)
VDACc=hex2dec('200')/1024*1.8;
IDACc=VDACc/3.3*1000;

dataraw2= 0x316;%1v->0x238,1.8v->3FF
dataraw2_s=bitshift(dataraw2,2);
datadac2=dec2hex(dataraw2_s)
VDACf=hex2dec('316')/1024*1.8;
IDACf=(1.8-VDACf)/16*1000;
Itot=IDACc+IDACf;
%Vcomp
dataraw3= 0x257;%0.909v->0x205
dataraw3_s=bitshift(dataraw3,2);
datadac3=dec2hex(dataraw3_s)
VDAC=hex2dec('257')/1024*1.8;
VTH=1.2-VDAC/3;