%% getOpValue
% returns the expactation value of an arbitrary operator
%% Syntax 
% * getOpValue(op)
% * getOpValue(op,it)
%% Description
% getOpValue(op,it) returns the expactation value of an arbitrary operator
% _op_. This operator needs to have the correct Hilbert space dimension
% which can be achieved via the epxand(name) command. If the optional
% parameter _it_ is provided the method returns a scalar value, which
% denotes the expectation value of _op_ at iteration _it_, instead of a
% vector containing entries for all iterations.
%% Example: The Hamilton operator of a subystem returns its energy
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
h =plot(s.time,s.getOpValue(s.getSubsystem('qbit').H));
xlabel('Time in au');
ylabel('Energy');
legend('qbit');
