%% generate_CMDS
% Executes multiple simulation runs systematically in order to calculate two-dimensional
% (2D) spectra.
%% Syntax
% generate_CMDS(name)
%% Description
% generate_CMDS(name) calculates 2D spectra for a given entity 'name'.

%% Detailed Description and Examples
% _generateCMDS_ executes multiple simulation runs for various delay and
% phase combinations of a given pulse sequence. Parameters for the 2D simulation must be defined in advance by the commands _setdelayMaxs_, _setdelaySteps_, 
% _setPcScheme_, _setContributions_, and _setReturnFunction_ of the CMDS class (see separate documentation of these commands). Calculations can be
% parallelized (one sequence per core) on a multicore computer system if _parallel_ is set to _true_
% (MATLAB® Parallel Computing Toolbox required). 
%
% For detailed information on how to use CMDS class see:
% <https://qd-toolbox.org/tutorials/#chapter7>.
%% Example input code for a three-pulse 2D simulation.
%
%   s = System;
%   s.lso = true; %allow calculation via Lindblad Superoperators
%   c = CMDS(s);
%   c.parallel = true; %use the parallel computing toolbox
%
%   s.setTmax(400*s.fstoau);    %length of the simulation time axis: 400 fs 
%   s.setTimestep(0.1*s.fstoau);%stepsize of the simulation time axis: 0.1 fs
%
%   %Parameters of the external light fields
%   gamma0 = 0; %full rotating frame
%   E0 = 2.0*s.evtoau; %center energy of the external field: 2.0 eV
%   amp = 5e-4; %external field amplitude
%   t_pulse = 20*fstoau; %pulse duration
%
%   %Parameters of the 2D simulation
%   c.setdelayMaxs([100 90 90]*s.fstoau); %define offset and maximum delays in femtoseconds.
%   c.setdelaySteps([31 31]); %define number of delay steps
%   c.setPcScheme([1 5 2]); %define the phase cycling scheme
%   c.setContributions([-1 2 -1]); %define a default contribution of the utilized phase cycling scheme
%   c.setReturnFunction(returnExcited); %sets the return function (here: time-integrated population density matrix element of the first excited state)
%   %Note: the return function can be customized by the user
%                                   
%   %Parameters of the system
%   gaps = [2.0*s.evtoau]; %define energy gap between the lowest two levels. Here: 2 eV energy separation between ground and excited state of the qbit
%   a = Nlevel(gaps);
%   a.setDipole([1 0], 1);
%   s.addEntity(a, 'qbit');
%   a.addDissipation('qbit', 200*s.fstoau, [1 0]);
%   s.addDecoherence('qbit', 50*s,fstoau, [1 0]);
%
%   % run the simulation
%   c.generate_CMDS('qbit');

