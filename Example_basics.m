clear; close all;
cf = 0.08;
s = System; %create a System
s.addEntity(Nlevel(cf),'qbit1'); %add the created qbit and call it qbit1 
s.addEntity(Qoscillator(3,cf),'cavity'); %add a quantum harmonic oscillator with 5 levels and energydiffernce of 1 a.u.
s.addEntity(Nlevel(cf),'qbit2'); %add another qbit and call it qbit2
s.addCoupling('qbit1','cavity',0.005); %add a coupling between the first qbit and the cavity
s.addCoupling('qbit2','cavity',0.005); %add a coupling between the second qbit and the cavity
s.addDissipation('qbit1',500); %Set the lifetime of qbit1 to 500 a.u.
s.addDissipation('qbit2',500);
s.addDecoherence('qbit1',500);
s.addDecoherence('qbit2',250);
s.addExternalField(Gausspulse(0.03,100,30,1),'qbit1'); %custom field


s.setTmax(500); %set the maximum time
s.setTimestep(1); 
s.lso=false;
% s.setState('qbit1',[0 1]); %set qfbit1 in the excited state
tic;
s.simulate; % start the simulation
toc;


h = plot(s.time,s.getEnergy('qbit1')); %plot the energy expectation value of the first qbit over time
hold on;
h2 = plot(s.time,s.getEnergy('qbit2'));
h3 = plot(s.time,s.getEnergy('cavity'));
h4 = plot(s.time,s.getTotalEnergy);
h.LineWidth = 3;
h2.LineWidth = 3;
h3.LineWidth = 3;
h4.LineWidth = 4;
xlabel('Time in a.u.','FontSize',14);
ylabel('Energy Expectation Value in a.u.','FontSize',14);
title('Energy Expectation Value over Time');
legend('Qbit1', 'Qbit2', 'Cavity','Total Energy');

figure;
s.plotEfields;

% 
% figure;
%  s.plotoccupation;