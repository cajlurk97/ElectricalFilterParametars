R=1.5;
C=0.9;
L=4;
%serijski r,l,c, niskopropusni
H = tf([1/LC],[1,1/R*L,1/L*C]);
bode

%cstprefs default options, uncoment to change
identpref
opts = bodeoptions('cstprefs');
opts.YLabel.FontSize = 15;
opts.XLabel.FontSize = 15;
opts.Title.FontSize = 20;

opts.Title.String = 'Amplitudno-frekvencijska karakteristika';
%opts.YLabel.String = 'Amplituda';
%opts.XLabel.String = 'Frekvencija';
opts.MagVisible='on'
opts.PhaseVisible='off'
bode(H,{0.01,100}, opts);
grid off;
set(findall(gcf,'type','line'),'linewidth',4)
axes=findobj('type','axes');
h_magnitude=get(axes(1),'YLabel')
h_freq=get(axes(1),'XLabel')
set(h_freq,'String','Amplituda (abs)')
set(h_magnitude,'String','Fazni pomak [deg]')


%TO DO

plot(xMark,1/((2)^(1/2)),'r*')

rlc_gui

a=[1];
b=[1,1,1];
w=[0.01,10];
freqs(b,a,w);

