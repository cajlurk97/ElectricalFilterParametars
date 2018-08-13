%Simulacija amplitudno-ferkvencijske karakteristike sonde osciloskopa i
%simulacija valnih oblika napona
%%---------------------------------------------------------------------
% Pozivaju se funkcije:
% 
% [ampl,faza,frekv]=Furier_napon([t.' u.'],br_harm)
%     t - vektor vremena 
%     u - vektor valnog oblika signala
%     br_harm - broj harmonika kojim se aproksimira ulazni signal
%     ampl - vektor amplituda pojedinog harmonika kosinusnog Fourierovog reda
%     faza - vektor faza pojedinih harmonika
%     frekv - vektor frekvencija pojedinih harmonika

% [H_izvor,fi_izvor]=AmplFrekvSondaFazori_funkcija(frekv(i),R2,C2,R1,C1)
%     frekv(i) - frekvencija i-tog harmonika
%     R2 - ulazna otpornost osciloskopa
%     C2 - ulazna kapacitivnost osciloskopa
%     R1 - otpornost sonde
%     C1 - kapacitivnost sonde
%     H_izvor - apsolutna vrijednost funkcije mreže na frekvenciji i-tog harmonika
%     fi_izvor - argument funkcije mreže na frekvenciji i-tog harmonika

% AmplFrekvSondaFazori(R2,C2,R1,C1);
%     R2 - ulazna otpornost osciloskopa
%     C2 - ulazna kapacitivnost osciloskopa
%     R1 - otpornost sonde
%     C1 - kapacitivnost sonde

%%--------------------------------------------------------------------
clear all;clc;

%Ulazni parametri---------------------------
frekv=1*10^3;% [Hz] frekvencija ulaznog signala
br_harm=5;% broj harmonika kojim se aproksimira ulazni signal
t=1/(2*pi*frekv)*(0:pi/(24*br_harm):2*pi);

%Parametri osciloskopa
R2=10^6; %[ohm]
C2=33*10^-12;% [F]

%Parametri sonde
R1=9*R2; %[ohm]
C1=1*C2/9;% [F]

%Pravokutni valni oblik (signal)
t_lom=1/(2*pi*frekv)*[ pi 2*pi];% tocke diskontinuiteta pravokutnog signala
for i=1:length(t)
    if t(i)<t_lom(1)
        u(i)=5; % pozitivna amplituda
    elseif t(i)<t_lom(2) 
        u(i) = -5;% negativna amplituda
   else         
         
        u(i)=-5;
    end
end
%------------------------------------------------------------------------

[ampl,faza,frekv]=Furier_napon([t.' u.'],br_harm); %Funkcija (Furier_napon) za izraèun koeficijenata kosinusnog Fourierovog reda ulaznog (višeharmonijskog) signala

valniOblik_poticaj=zeros(size(u));
for i=1:br_harm % Aproksimacija ulaznog signala rastavom na jednoharmonijske funkcije
    
    valniOblik_poticaj=valniOblik_poticaj+ampl(i)*sqrt(2)*cos(2*pi*frekv(i)*t+pi*faza(i)/180);   
   
    
end

figure(1);% Prikaz originalnog i aproksimiranog valnog oblika ulaznog signala
plot(t,[u;valniOblik_poticaj],'linewidth',2);
grid on;title('Valni oblik napona');
ylabel('U [V]');xlabel('Vrijeme [s]');

figure(2);% Prikaz amplituda i faza pojedinog harmonika ulagnog signala
subplot(2,1,1);
bar(frekv,ampl,'linewidth',2);
grid on;title('Ampitudno(RMS) -frekv');
ylabel('U [V]');xlabel('Frekvencija [Hz]');
subplot(2,1,2);
bar(frekv,faza,'linewidth',2);
grid on;title('Fazno-frekv');
ylabel('Faza [°]');xlabel('Frekvencija [Hz]');

valniOblik_napon=zeros(size(u));

for i=2:br_harm %Izraèun izlaznog signala
    [H_izvor,fi_izvor]=AmplFrekvSondaFazori_funkcija(frekv(i),R2,C2,R1,C1); %Funkcija za izraèun amplitudno-frekv i fazno-frekv karakteristike funkcije mreže
    valniOblik_napon=valniOblik_napon+ampl(i)*H_izvor*sqrt(2)*cos(2*pi*frekv(i)*t+pi*faza(i)/180+fi_izvor);
     harm(i)=ampl(i)*H_izvor;
end

figure(4);
subplot(2,1,1);
plot([t t+t(end)],[u u],'linewidth',2);
grid on;title('Valni oblik napona');
ylabel('U [V]');xlabel('Vrijeme [s]');
subplot(2,1,2);
plot([t t+t(end)],[valniOblik_napon valniOblik_napon],'linewidth',2);
grid on;title('Napon osciloskopa');
ylabel('U2 [A]');xlabel('Vrijeme [s]');

AmplFrekvSondaFazori(R2,C2,R1,C1); %Funkcija za prikaz Bodeovog dijagrama funkcije mreže

figure(5); % Prikaz ampl.-frekv. i fazno-frekv. karakteristike izlaznog signala

bar(frekv,[ampl;harm].' ,'linewidth',2);
grid on;title('Ampitudno(RMS) -frekv');
ylabel('U [V]');xlabel('Frekvencija [Hz]');

