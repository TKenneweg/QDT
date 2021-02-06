%simulating superluminal light (see: L.J. Wang, A. Kuzmich, and A. Dogariu.
%Gain-assisted superluminal light propagation, Nature 406, 227-279 (2000).)
clear; close all;
s = System;
gaps = [2.2 1.2];
a = Nlevel(gaps);
a.setDipole([2 0], 1);
a.setDipole([2 1], 1); 
s.addEntity(a,'atom');
s.addExternalField(Gausspulse(0.05,750,150,3),'atom');
s.addExternalField(Gausspulse(0.05,750,150,2.95),'atom');
s.addExternalField(Gausspulse(0.01,750,10,0.775),'atom');
s.addDecoherence('atom',300,[2 0]);
s.addDecoherence('atom',300,[2 1]);
s.setTmax(1500);
s.setTimestep(0.1);
s.simulate;

s.plotEfields;
% s.plotRoh;
figure;

plot(2*pi*s.f,real(s.getRefractiveIndex('atom',10e-7)));
axis([0 2*pi -inf inf]);
hold on; 
plot(2*pi*s.f,imag(s.getRefractiveIndex('atom',10e-7)));
xlabel('Frequency in a.u.');
ylabel('Refractive index in a.u.');
title('Superluminal Light');



