%Izracun i prikaz amplitudno frekvencijske i fazno frekvencijske 

%Ulazni parametri su:
%     R2 - ulazna otpornost osciloskopa
%     C2 - ulazna kapacitivnost osciloskopa
%     R1 - otpornost sonde
%     C1 - kapacitivnost sonde
function AmplFrekvSondaFazori(R2,C2,R1,C1)

fmin=1e1;%Hz
fmax=1e6;%Hz
gustoca=1000;%Broj tocaka po dekadi

Amplitudna_y=[];
Snaga=[];
Napon_C=[];
fazniAll=[];
fAll=[];
for f_br=1:gustoca*ceil(log10(fmax/fmin))
    f=10^(floor(log10(fmin)))*10^(f_br/gustoca);
    fAll=[fAll f];
    
    w=2*pi*f;
    Z1=paralela(R1,1/(1i*w*C1));
    Z2=paralela(R2,1/(1i*w*C2));
    H=Z2/(Z1+Z2); 
       
Amplitudna_y=[Amplitudna_y abs(H)];
fazniAll=[fazniAll angle(H)];

end

figure(5);
subplot(2,1,1);
loglog(fAll.',Amplitudna_y,'linewidth',2);
legend('U2/U1');
grid on;
xlabel('Frekvencija [Hz]');
ylabel('Funkcija mreže');
subplot(2,1,2);
semilogx(fAll.',180/pi*fazniAll.','linewidth',2);
ylabel('Kut [stupnjevi]');
grid on;

end





