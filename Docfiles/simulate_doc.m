%% simulate 
% Start the simulation of the previously built system for the specified timeframe.
%% Syntax
% simulate()
%% Description
% simulate() Start the simulation of the previously built system for the specified timeframe.
%% Detailed Description and Examples
% When simulate is called all subsystems operators are expanded unto the full hilbert space and the complete Hamiltonian is built. 
% The main loop is entered where the full density matrix is calculated for every timestep using
% an adaptive mix of the time evolution operator and the runge-kutta-4 integration scheme.