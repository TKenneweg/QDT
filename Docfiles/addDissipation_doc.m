%% addDissipation
% Implements a dissipation process via the Lindblad master equation in a specified subsystem.
%% Syntax
% * addDissipation(name,decay_time)
% * addDissipation(name,decay_time,levels)
% * addDissipation(interval,name,decay_time,levels)
%% Description
% * addDissipation(name,decay_time) adds a dissipation effect with decay time of _decay_time_ to the subsystem with name _name_.
% * addDissipation(name,decay_time,levels) _levels_ takes a vector of length 2. Adds a dissipation effect with decay time of _decay_time_
% between the levels _levels(2)_ and _levels(1)_ to the subsystem with name _name_.
% * addDissipation(interval,name,decay_time) interval takes a vector of length 2. Adds a dissipation effect with decay time of _decay_time_ to the subsystem with name _name_,
% within the timeframe specified by _interval(1)_ and _interval(2)_.
%% Detailed Description and Examples
% Dissipation between different levels within one subsystem is realised by the Lindblad master equation. The Liouville von Neumann Equation is expanded by an additional term, resulting in:
%
% $$\rho' = [H,\rho] +  \sum\limits_i \frac{1}{T_i} (R_i \rho R_i^{\dagger}  - \frac{1}{2} R_i^{\dagger} R_i \rho - \frac{1}{2} \rho R_i^{\dagger}  R_i)$$
%
% where $R_i$ denotes the jumping operator. If $R_i$ takes on the form of the lowering operator, the Lindblad equation models a dissipative process between the different levels of a subsystem. 
% This loss progresses with a lifetime of $T_i$. 
% If the dissipation levels are not specified, dissipation is simulated between adjacent levels.
%% Example of a qbit coupled to a lightfield.
s = System;
s.addEntity(Nlevel(1),'qbit');
s.addEntity(Qoscillator(3,1),'lightfield');
s.addCoupling('qbit','lightfield',0.05);
s.addDissipation('qbit',40);
s.addExternalField(Gausspulse(0.04,50,15,1),'qbit');
s.setTimestep(0.1);
s.simulate();

%plot the gained data
plot(s.time, s.getEnergy('qbit'));
hold on;
plot(s.time, s.getEnergy('lightfield'));
plot(s.time, s.getOpValue(s.H));
s.plotEfields;
xlabel('Time');
ylabel('Energy');
title('Qbit Coupled to a Lightfield');
thelegend = legend('qbit' ,'lightfield','total','laserpuls','Location','northeast');
set(thelegend,'FontSize',16);