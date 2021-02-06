%% setdelayMaxs
% Set the offset delay and maximum delays between mulitple pulses for the simulation of two-dimensional (2D) spectra. 
%% Syntax
% setdelayMaxs(delays)
%% Description
% setdelayMaxs(delays) _delays_ denotes an array of numbers where the first entry corresponds to the temporal offset of the overall pulse sequence, 
% whereas the following numbers of the array denote the maximum interpulse delays.   
%% Detailed Description and Examples
% This command takes a vector of delays. The number of delays supplied determines the number of pulses used in the spectra generation. 
% If three delays are supplied, the first value always denotes the offset of the first pulse from time =0. 
% The next two values determine the maximum delays between consecutive pulses.
%% Example of a three-pulse train.
%
%   s = System;
%   c = CMDS(s);
%   c.setdelayMaxs([100 120 120]*s.fstoau); %three-pulse train with an offset of 100 fs and two interpulse delays of 120 fs.
%