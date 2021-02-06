%% getPopulation
% returns the expactation value of an arbitrary operator
%% Syntax 
% * getPopulation(name, level)
% * getPopulation(namel, level, it)
%% Description
% getPopulation(name, level, it) returns a vector containing the population of a certain _level_ 
% in the subsystem _name_ over time. Indexing starts at zero (lowest level is zeroth level). If a specific iteration is given (_it_), the method returns a scalar
% for this iteration. 
%% Example: Qbit in a cavity
clear; close all;
s = System;
a = Nlevel(1);
s.addEntity(a,'qbit');
s.addEntity(Qoscillator(3,1),'cavity');
s.addCoupling('qbit','cavity',0.05);
s.addDissipation('qbit',200);
s.addExternalField(Gausspulse(0.04,100,30,1),'qbit');
s.setTmax(400);
s.setTimestep(0.1);
s.simulate;

h =plot(s.time,s.getPopulation('cavity',2));
xlabel('Time in au');
ylabel('Energy');
legend('Level 2 of cavity');
%% 
% The above example shows the population of the second excited state of the harmonic oscillator. 
% Although the cavity is only inderectly excited via a qbit, there is still a chance to measure two photons
% in it. This corresponds to the scenario in which the qbit transfers its energy into the cavity, gets excited
% again by the external laser pulse and transfers energy again.