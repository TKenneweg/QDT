clear;
close all;

s = System;
s.lso = true;  %use the lindblad superoperator
 
gaps = [2.0*s.evtoau];
a = Nlevel(gaps);
a.setDipole([1 0], 1);
s.addEntity(a, 'molecule');
s.addDissipation('molecule', 50*s.fstoau, [1 0]);
s.addDecoherence('molecule', 30*s.fstoau, [1 0]);
s.setTmax(500*s.fstoau);
s.setTimestep(0.1*s.fstoau);
 
c = CMDS(s);

% Experimental parameters
gamma0 = 0.0; %0.0 = full rotating frame; 1.0 = lab frame
E0 = 2.0*s.evtoau; % Central energy of the laser pulses
amp=5e-4; %external field amplitude
t_pulse = 20*s.fstoau; %pulse duration (FWHM)
c.setdelayMaxs([100 120 120]*s.fstoau); %Three-pulse sequence, with the first pulse starting at 100 fs with delays scanned up to 90 fs
c.setdelaySteps([21 21]);
c.setPcScheme([1 5 2]); %Phase cycling scheme for photon echo contribution
c.setContributions([-1 2 -1]);
c.setEfieldparameter(amp,t_pulse,E0,gamma0);
c.setReturnFunction(returnExcited)

c.parallel = true; % enable parallel computing
c.generate_CMDS('molecule');

plotContribution = [-1 2 -1];
nzp = 5;
c.plotCMDS(plotContribution,1,1,nzp,'rephasing');
