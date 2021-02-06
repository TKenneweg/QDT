%% getEnergy
% Returns the energy of a specified subsystem
%% Syntax
% getEnergy(name)
%% Description
% getEnergy() Returns a vector containing the expectation value for the energy
% of the subsytem _name_ for every point in time that has been simulated.
%% Detailed Description and Examples
% The function returns: 
%
% $$ <E> = Tr(\rho H_s)$$
%
% where $H_s$ denotes the Hamiltonian of the subsystem _name_.