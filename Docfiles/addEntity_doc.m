%% addEntity
% Adds a subsystem to the overall system
%% Syntax
% addEntity(subsystem,name)
%% Description
% addEntity(subsystem,name) adds _subsystem_ to the overall system and gives it the name _name_.
%% Detailed Description 
% If a subsystem is added to the overall system, the Hilbert space is extended accordingly and the subystem becomes part 
% of the simulation. 
% All operators of the input subystem will be scaled to the Hilbert space when simulate is called. The subsystem is 
% represented in the density matrix and becomes part of the naming scheme.

