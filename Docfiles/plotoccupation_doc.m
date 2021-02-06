%% plotoccupation
% creates multiple subplots, one for each diagonal element of the density matrix. Very popular
%% Syntax 
% * plotoccupation
% * plotoccupation(i)
%% Description
% plotoccupation creates multiple subplots, one for each diagonal element of the density matrix.
% Subplot titles are automatically generated and can be found in the _statenames_ variable of the system class.
% If _i_ is provided only the i-th element is plottet.


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

figure('units','normalized','outerposition',[0 0 1 1]) %make full screen figure
s.plotoccupation;

