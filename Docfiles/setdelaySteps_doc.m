%% setdelaySteps
% Set the number of steps in sampling delays between mulitple pulses for the simulation of two-dimensional (2D) spectra. 
%% Syntax
% setdelaySteps(steps)
%% Description
% setdelaySteps(steps) _steps_ denotes an array of numbers that correspond to the amount of delay steps of the delays between the pulses.   
%% Detailed Description and Examples
% This command takes a vector of delay steps. If two delay steps are supplied, the first value denotes the number of delay steps between the first two pulses whereas the second value corresponds to the number of delay steps between the second and third pulses. 
%% Example of a three-pulse train.
%
%   c.setdelaySteps([31 31]); %This choice of delay steps corresponds to a three-pulse sequence in which both delays are sampled in 31 steps.
%