clear all;
close all;
clc;
format long;
cx=5e-13;
cin=320e-12;
Q=200e-15;
gamma=1/2;
k=1.38e-23;
T=300;
g_mn1=20e-3;
g_mp1=2e-3;
jitter=cin/(Q*g_mn1^(1/2)*g_mp1^(1/2))*sqrt(gamma*k*T*cx)