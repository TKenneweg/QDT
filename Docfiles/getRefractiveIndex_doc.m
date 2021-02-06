%% getRefractiveIndex
% returns the susceptibility of choosen subsystem.
%% Syntax 
% * getRefractiveIndex(name)
% * getRefractiveIndex(name,eps)
%% Description
% getRefractiveIndex(name,eps) works excatly analougus to the getSusceptibility method
% The refractive Index is calculated using the susceptibility by
% 
% $$ N(\omega) = \sqrt{1+ d \cdot \chi(\omega)} $$
%
% where _d_ denots the density of the medium. _d_ is set to an arbitrary low value 
% of _d_ = 0.01, which corresponds to a gas.

