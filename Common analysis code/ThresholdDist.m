clear all;
close all;
clc;
format long;
ithT11=[242.4,279.8,270.3,284.5,283.3];
ithT12=[314.3,317.5,279.3,266.2,318.1];
ithT22=[128.4,131.8,114.3,129.6,130.9];
vth1=[897,893,900,899,898];
ithOR=[268,302,280,308;...
    249,260,347,320;...
    257.1,254.5,251.5,283.9;...
    292.3,232.4,284.4,292.0;...
    264.7,313.5,247.9,242.0];

arr1=[ithT11,ithT12,ithOR(1,:),ithOR(2,:),ithOR(3,:),ithOR(4,:),ithOR(5,:)];
h1=histfit(arr1);
pd1=fitdist(arr1','Normal');
sig1=pd1.sigma;
mu1=pd1.mu;
range1=[mu1-3*sig1,mu1+3*sig1];

pd2=fitdist(ithT22','Normal');
sig2=pd2.sigma;
mu2=pd2.mu;
range2=[mu2-3*sig2,mu2+3*sig2];

pd3=fitdist(vth1','Normal');
sig3=pd3.sigma;
mu3=pd3.mu;
range3=[mu3-3*sig3,mu3+3*sig3];
