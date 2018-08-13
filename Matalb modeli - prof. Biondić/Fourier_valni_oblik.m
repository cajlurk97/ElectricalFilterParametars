%Pokazivanje instrumenata
clear all;clc;

frekv=0.05*10^3;% [Hz]
br_harm=100;
t=1/(2*pi*frekv)*(0:pi/10000:2*pi);

%Pravokutni
t_lom=1/(2*pi*frekv)*[ pi  2*pi];
for i=1:length(t)
    if t(i)<t_lom(1)
        u(i)=100;
    elseif t(i)<t_lom(2) 
        u(i) = -100;
    else         
        u(i)=100;
    end
end

%Poništen 3 i 5 harmonik
% t_lom=1/(2*pi*frekv)*[ pi/10 38/180*pi pi-38/180*pi pi-pi/10 pi pi+pi/10 pi+38/180*pi 2*pi-38/180*pi 2*pi-pi/10 2*pi];
% for i=1:length(t)
%     if t(i)<t_lom(1)
%         u(i)=300;
%     elseif t(i)<t_lom(2) 
%         u(i) = 0;
%     elseif t(i)<t_lom(3) 
%         u(i) = 300;
%     elseif t(i)<t_lom(4) 
%         u(i) = 0;  
%     elseif t(i)<t_lom(5) 
%         u(i) = 300; 
%     elseif t(i)<t_lom(6) 
%         u(i) = -300; 
%     elseif t(i)<t_lom(7) 
%         u(i) = 0; 
%     elseif t(i)<t_lom(8) 
%         u(i) = -300; 
%     elseif t(i)<t_lom(9) 
%         u(i) = 0; 
%     elseif t(i)<t_lom(10) 
%         u(i) = -300; 
%    else         
%          
%         u(i)=0;
%     end
% end

%Poništen 3 harmonik
% t_lom=1/(2*pi*frekv)*[ pi/3 pi 4*pi/3 2*pi];
% for i=1:length(t)
%     if t(i)<t_lom(1)
%         u(i)=0;
%     elseif t(i)<t_lom(2) 
%         u(i) = 300;
%     elseif t(i)<t_lom(3) 
%         u(i) = 0;
%     elseif t(i)<t_lom(4) 
%         u(i) = -300;    
%    else         
%          
%         u(i)=0;
%     end
% end

%Step
% clear t;
% k=20;
% t_lom=1/(2*pi*frekv)*[-pi pi];
% t=1/(2*pi*frekv)*(-2*k*pi:pi/1000:2*k*pi);
% for i=1:length(t)
%     if t(i)<t_lom(1)
%         u(i)=0;
%     elseif t(i)<t_lom(2)
%         u(i)=300;
%    else         
%         u(i)=0;
%     end
% end
% t=t-t(1);

%SIX STEP - Fazni naponi
% E=100;
% t_lom=1/(2*pi*frekv)*[ pi/3 2*pi/3 pi 4*pi/3 5*pi/3 2*pi];
% for i=1:length(t)
%     if t(i)<t_lom(1)
%         u(i)=2*E/3;
%     elseif t(i)<t_lom(2) 
%         u(i) = E/3;
%     elseif t(i)<t_lom(3) 
%         u(i) = -E/3;
%     elseif t(i)<t_lom(4) 
%         u(i) = -2*E/3;
%       elseif t(i)<t_lom(5)
%           u(i) = -E/3;
%       elseif t(i)<t_lom(6)
%           u(i) = E/3;
%    else      
%          
%         u(i)=2*E/3;
%     end
% end

[ampl,faza,frekv]=Furier_napon([t.' u.'],br_harm);

valniOblik_poticaj=zeros(size(u));
valniOblik_poticaj=ampl(1)*cos(2*pi*frekv(1)*t+pi*faza(1)/180);
for i=2:br_harm
    
    valniOblik_poticaj=valniOblik_poticaj+ampl(i)*sqrt(2)*cos(2*pi*frekv(i)*t+pi*faza(i)/180);    
    
end

figure(1);
plot(t,[u;valniOblik_poticaj],'linewidth',2);
grid on;title('Valni oblik napona');
ylabel('U [V]');xlabel('Vrijeme [s]');

figure(2);
subplot(2,1,1);
bar(frekv,ampl,'linewidth',2);
grid on;title('Ampitudno(RMS) -frekv');
ylabel('U [V]');xlabel('Frekvencija [Hz]');
subplot(2,1,2);
bar(frekv,faza,'linewidth',2);
grid on;title('Fazno-frekv');
ylabel('Faza [°]');xlabel('Frekvencija [Hz]');


