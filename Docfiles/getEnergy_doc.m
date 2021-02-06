%% getEnergy
% returns a vector containing the energy of a subystem
%% Syntax 
% getEnergy(name)
%% Description
% getEnergy(name) returns a vector containing the energy of the subsystem
% _name_.
%% Example of two qbits which are coupled via a cavity
clear; close all;
s = System;
a = Nlevel(1);
s.addEntity(a,'qbit');
s.addEntity(Qoscillator(3,1),'cavity');
s.addEntity(Nlevel(1),'qbit2');
s.addCoupling('qbit','cavity',0.05);
s.addCoupling('cavity','qbit2',0.05);
s.addDissipation('qbit',200);
s.addExternalField(Gausspulse(0.04,100,30,1),'qbit');
s.setTmax(400);
s.setTimestep(0.1);
s.simulate;
h =plot(s.time,s.getEnergy('qbit'));
hold on;
plot(s.time,s.getEnergy('cavity'));
plot(s.time,s.getEnergy('qbit2'));
xlabel('Time in au');
ylabel('Energy');
legend('qbit','cavity','qbit2');
