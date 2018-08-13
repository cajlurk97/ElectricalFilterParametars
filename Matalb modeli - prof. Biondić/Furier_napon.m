%Ulazni parametri su:
%- data -vektor napona (2. stupac - data) i vektor vremena (1.stupac -data)
%- br_harm- broj harmoinika koji se prikazuje


function [ampl,faza,frekv]=Furier_napon(data,br_harm)



n=length(data);
fs=1/(data(2,1)-data(1,1));
a=1;
b=n;

fft_napon = fft(data(a:b,2).')/(b-a-1);

ampl=[abs(fft_napon(1)) sqrt(2)*abs(fft_napon(2:br_harm))];
faza=180/pi*atan2(imag(fft_napon(1:br_harm)),real(fft_napon(1:br_harm)));
frekv=[0:br_harm-1]*fs/(b-a);


end






