%% setDipole
% sets the dipole transition moment between two level in an Nlevel subsystem
%% Syntax
% setDipole(levels,u)
%% Description
% setDipole(levels,u) _levels_ contains excactly analogous to the syntax as used in the coupling and lindblad 
% commands the numbers of the levels between which the dipole moment is set (starting at zero). _u_ denotes the 
% dipole moment. By default all dipols between levels are set to one.
%% Detailed Description and Examples
% The dipole set via this method only effects the interaction with external fields. The time dependent Hamiltonian for Nlevel subsystems generated
% by the external field is given by 
% 
% $$H_e(t) = E(t)\cdot(\mu + \mu^{\dagger})$$
%
% where $\mu$ denotes the dipole matrix. The entries in this matrix are automatically set at the correct place, depending on which
% _levels_ vector is given.