clear; close all;
s = System; %create a System
s.addEntity(Nlevel(1),'qbit1'); %add a qbit and call it qbit1
s.addEntity(Nlevel(1),'qbit2'); %add another qbit and call it qbit2
s.addCoupling('qbit1','qbit2',0.05); %add a coupling between the qbits
s.addDissipation('qbit1',500); %Set the lifetime of qbit1 to 500 a.u.
s.addDissipation('qbit2',500); %Set the lifetime of qbit2 to 500 a.u.
s.addExternalField(Gausspulse(0.04,50,30,1),'qbit1'); %set an external electric field that interacts only with qbit1
 
s.setTmax(400); %set the maximum time
s.setTimestep(0.1);
s.simulate; % start the simulation
 
h = plot(s.time,s.getEntanglement); % plot the Entanglement
h.LineWidth =3;
xlabel('Time in a.u.');
ylabel('Entanglement');
title('Wooters Entanglment');
legend('Qbit1-Qbit2');

%two qbits in a cavity

s = System; %create a System
s.addEntity(Nlevel(1),'qbit1');
s.addEntity(Nlevel(1),'qbit2');
s.addEntity(Qoscillator(3,1),'cavity');
s.addCoupling('qbit1','cavity',0.05);
s.addCoupling('qbit2','cavity',0.05);
s.addDissipation('qbit1',500);
s.addDissipation('qbit2',500);
s.addDissipation('cavity',400);
s.addExternalField(Gausspulse(0.04,50,30,1),'qbit1');
 
s.setTmax(400); %set the maximum time
s.setTimestep(0.1);
s.simulate; % start the simulation
 
s.traceOut('cavity');
h = plot(s.time,s.getEntanglement);
h.LineWidth =3;
xlabel('Time in a.u.');
ylabel('Entanglement');
title('Entanglment over Cavity');
legend('Qbit1-Qbit2');

%bloch sphere stuff
% s.animateblochsphere('qbit1');
% s.blochsphere('qbit1');
