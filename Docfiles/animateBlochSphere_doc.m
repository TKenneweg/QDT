%% animateBlochsphere
% creates an animation of of the bloch vector of one or more specified qbit
%% Syntax
% * animateBlochsphere(name1,name2,...,nameN)
% * animateBlochsphere(name1,name2,...,nameN,speed)
%% Description
% animateBlochsphere(name1,name2,...,nameN,speed) creates an animation of of the bloch vectors of all qibts whose name was given 
% to the method. The last parameter is optional and denotes the speed of the animation. 
%% Example
s = System;
a = Nlevel(1);
a.setDipole([1 0],1);
s.addEntity(a,'qbit');
s.addExternalField(CW(0.04,1,00),'qbit','feld');
s.setTmax(400);
s.setTimestep(0.1);
s.simulate;
s.animateBlochsphere('qbit',5);