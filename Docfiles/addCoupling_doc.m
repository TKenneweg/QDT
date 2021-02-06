%% addCoupling
% Implements dipole coupling between two subsystems.


%% Syntax
% * addCoupling(name1,name2,y) 
% * addCoupling(name1,levelsA,name2,y)
% * addCoupling(name1,levelsA,name2,levelsB,y)

%% Description
% * addCoupling(name1,name2,y) couples the two subsystems _name1_ and _name2_ with coupling strength _y_ (in atomic units).
% * addCoupling(name1,levelsA,name2,y) _levelsA_ is a vector of length 2. Couples the transition betweens levels _levelsA(1)_ and _levelsA(2)_
% of subsystem _name1_ to subsystem _name2_.
% * addCoupling(name1,levelsA,name2,levelsB,y) _levelsA_ and levelsB_ are vectors of length 2. Couples the transition betweens levels _levelsA(1)_
% and _levelsA(2)_ of subsystem _name1_ to the transition betweens levels _levelsB(1)_ and _levelsB(2)_ of subsystem _name2_.

%% Detailed Description and Examples
% Coupling between two subsystems A and B is based upon the lowering and raising operators $\sigma^{-}$ and $\sigma^{+}$ of these systems. 
% For each coupling a Hamiltonian is added to the total Hamiltonian of the system. 
%
% $$H_y = y (\sigma_A^{+}\sigma_B^{-} + \sigma_A^{-}\sigma_B^{+})$$
%
% if the level option is given when calling the function, not the full lowering and raising operators are used
% but rather operators which perform lowering and raising only between the specified levels. If non-specific coupling 
% is used only transition between neighbouring levels is implemented.

%% Example of a qbit coupled to a mode of the lightfield.

s = System;
s.addEntity(Nlevel(1),'qbit');
s.addEntity(Qoscillator(3,1),'cavity');
s.addCoupling('qbit','cavity',0.05);
s.addExternalField(Gausspulse(0.04,50,15,1),'qbit'); %external laser pulse excites the system
s.setTimestep(0.1);
s.simulate();

%plot part of the gained data
plot(s.time, s.getEnergy('qbit'));
hold on;
plot(s.time, s.getEnergy('cavity'));
plot(s.time, s.getOpValue(s.H));
s.plotEfields;
xlabel('Time');
ylabel('Energy');
title('Qbit Coupled to a cavity');
thelegend = legend('qbit' ,'cavity','total','laserpuls','Location','northeast');
set(thelegend,'FontSize',16);

%% Example of specified couplings a seen in the Figure below
clear; close all;
s = System;
a1 = Nlevel([1 1]); %equidistant three level subsystem 
a2 = Nlevel([1 1]);
s.addEntity(a1,'a1');
s.addEntity(a2,'a2');
s.addCoupling('a1',[2 1] ,'a2', [1 0], 0.05);
s.addCoupling('a1', [1 0],'a2',[1 0],0.05);
s.addExternalField(Gausspulse(0.05,50,15,1),'a1');
s.setTmax(400);
s.setTimestep(0.1);
s.simulate();
%plot part of the gained data
plot(s.time, s.getEnergy('a1'));
hold on;
plot(s.time, s.getEnergy('a2'));
plot(s.time, s.getOpValue(s.H));
xlabel('Time in s');
ylabel('Energy in J');
title('Gap Test');
thelegend = legend('a1' ,'a2','Total','Location','northeast');
set(thelegend,'FontSize',16);