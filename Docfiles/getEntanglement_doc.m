%% getEntanglment
% returns the entanglement between two qbits, using Wooters
% formula (Entanglement of Formation of an Arbitrary State of
% Two Qubits). The entanglement differs from the concurrence by a monotone
% function and is thus qualitatively nearly identical.
%% Syntax 
% getEntanglment()
%% Description
% getEntanglment() returns the entanglement, which is very similar to he concurrence between two qbits. This command
% can be used in the context of an arbitrary system. However, if the system
% contains more than 2 qbits all other qibts have to be traced out first
% using the traceOut(name) command.
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
s.traceOut('cavity')
h =plot(s.time,s.getEntanglement);
xlabel('Time in au');
ylabel('Entanglement')
%%
% The above graphs show the entanglement between the two indirectly coupled
% qbits. This entanglement is calculated using the reduced density matrix  _reduced_rho_hist_.