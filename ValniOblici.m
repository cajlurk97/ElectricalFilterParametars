clear all;close all;clc;
R1=4; %[Ohm]

podatci = importdata('D:\Posao\2017_18\ZavrsniDiplomski Rad\VukadinZR2018\Minus1fi_180.csv');
data=podatci.data;

t = data(:,1);
u = data(:,2);
iL = 10*data(:,4) - 0.1;

flux = cumtrapz(t,u-R1*iL);

figure(1);
subplot(3,1,1);
plot(t,[u  u-R1*iL]);
grid on;
subplot(3,1,2);
plot(t,iL);
grid on;
subplot(3,1,3);
plot(t,flux);
grid on;

figure(2);
plot(t,flux);grid on;