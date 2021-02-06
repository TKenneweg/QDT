%% setPcScheme
% sets the phase-cycling scheme for the simulation of two-dimensional (2D) spectra. 
%% Syntax
% setPcScheme(pcscheme)
%% Description
% setPcScheme(pcscheme) _pcscheme_ denotes an array of numbers that denote the phase-cycling scheme for a given pulse sequence.   
%% Detailed Description and Examples
% This command takes a vector of phase steps that correspond to a specific
% phase-cycling scheme and calculates an internal variable that determines the interpulse phases of the pulse sequences used for the simulation. 
% Note that the size of this array must correspond to the number of pulses employed in the simulation.
% For phase-cycling theory and details about determining an appropriate
% phase-cycling scheme, see Ref. [1].
%
% References
%
% H.-S. Tan, _J. Chem. Phys._ *129*, 124501 (2008).
%% Example of defining a 1x3x3x3 phase-cycling scheme of a four-pulse sequence
%
%   s = System;
%   c = CMDS(s);
%   c.setPcScheme([1 3 3 3]); %This 1x3x3x3 phase-cycling scheme corresponds to a 27-fold cycling of the interpulse phases of a four-pulse train.