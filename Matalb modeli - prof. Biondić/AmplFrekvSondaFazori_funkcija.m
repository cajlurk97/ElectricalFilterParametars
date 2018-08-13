%Izracun amplitudno frekvencijske i fazno frekvencijske 
function [H_izvor,fi_izvor]=AmplFrekvSondaFazori_funkcija(f,R2,C2,R1,C1)
%%--------------------------------------------------------------

%%------------------------------------------------------------------------
   
    w=2*pi*f;
    Z1=paralela(R1,1/(1i*w*C1));
    Z2=paralela(R2,1/(1i*w*C2));
    H=Z2/(Z1+Z2); 
     
    
H_izvor=abs(H);
fi_izvor=angle(H);


end










