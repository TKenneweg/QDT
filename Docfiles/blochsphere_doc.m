%% blochsphere
% creates a blochsphere and the trace on the surface of that sphere of the bloch vector of one or more specified qbits
%% Syntax
% blochsphere(name1, name2, ... , nameN)
%% Description
% blochsphere(name1, name2, ... , nameN) creates the trace of the bloch vectors of the qbits specified by the supplied names.
%% Example
s = System;
a = Nlevel(1);
a.setDipole([1 0],1);
s.addEntity(a,'qbit');
s.addExternalField(CW(0.04,1,00),'qbit'); % continous wave excitation
s.setTmax(400);
s.setTimestep(0.1);
s.simulate;
s.blochsphere('qbit');