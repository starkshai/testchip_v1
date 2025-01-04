clear all;
close all;
clc;
format long;
x=0:1:200;
v=(1e4+x)/(2e4+200)*1800;
plot(x,v);
xticks(0:10:200);
grid on;