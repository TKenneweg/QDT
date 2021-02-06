clear; close all;
s = System; %create a System
s.addEntity(Nlevel(1),'qbit1'); %add the created qbit and call it qbit1
s.addEntity(Qoscillator(3,1),'cavity'); %add a quantum harmonic oscillator with 5 levels and energydiffernce of 1 a.u.
s.addEntity(Nlevel(1),'qbit2'); %add another qbit and call it qbit2
s.addCoupling('qbit1','cavity',0.05); %add a coupling between the first qbit and the cavity
s.addCoupling('qbit2','cavity',0.05); %add a coupling between the second qbit and the cavity
s.addDissipation('qbit1',50); %Set the lifetime of qbit1 to 50 a.u.
s.addExternalField(Gausspulse(0.04,50,30,1),'qbit1'); %set an external electric field that interacts only with qbit1
%done
 
s.setTmax(200); %set the maximum time
s.setTimestep(0.1);
s.simulate; % start the simulation

h = plot(s.time,s.getEnergy('qbit1')); %plot the energy expectation value of the first qbit over time
h.LineWidth =3;
hold on;
h =plot(s.time,s.getEnergy('qbit2'));
h.LineWidth =3;
h = plot(s.time,s.getEnergy('cavity'));
h.LineWidth =3;
h = plot(s.time,s.getTotalEnergy); 
h.LineWidth =3;
xlabel('Time in a.u.');
ylabel('Energy Exectation Value in a.u.');
title('Energy Expectation Value over Time');
legend('Qbit1','Qbit2','Cavity', 'Total Energy');

figure;
s.plotEfields;