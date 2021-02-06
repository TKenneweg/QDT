%% getTotalEnergy
% returns the polarisation of a subsystem
%% Syntax 
% * getPolarisation(name)
%% Description
% getPolarisation(name) returns a vector containing the polarisation of the subystem _name_ over time.
% If the subsystem is a Nlevel system the dipole matrix is used to calculate this value.
% 
% $$ P(t) = tr(\rho \cdot (\mu + \mu^{\dagger}))$$
% 
% If the subystem is a quantum oscillator the lowering and raising operators are used
% 
% $$ P(t) = tr(\rho \cdot (\sigma^{-} + \sigma^{+}))$$
% 

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

h =plot(s.time,s.getPolarisation('qbit'));
xlabel('Time in au');
ylabel('Energy');
legend('qbit');
