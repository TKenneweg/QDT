%% setReturnFunction
% Set the function that returns the specific quantity of interest for every pulse sequence of a simulation of multidimensional spectroscopy.
%% Syntax
% setReturnFunction(name)
%% Description
% setReturnFunction(name) _name_ is the name of the .m-file that
% contains the function which calculates the quantity that shall be returned after each finished simulation run. 
%% Detailed Description and Examples
% Return functions can be fully customized according to the quantity of
% interest. For population-based two-dimensional (2D) spectroscopies,
% specific diagonal density matrix elements correspond to the 
% observables that are measured in a real experiment, while in coherently-detected 2D spectroscopies, the
% off-diagonal elements contain the desired information.

%% Example of a Return Function
%   function out = returnExcited
%   out = @inner;
%       function out2 = inner(s)
%           out2 =  sum(squeeze(s.rho_hist(2,2,:)));
%       end
%   end
%
% In this example, the function returns a time-integrated population density
% matrix element.
% Note that the first two arguments of _s.rho_hist(2,2,:)_ denote the *indices*
% of the density matrix element. Hence, in a simple two-level system, this function would 
% return the time-integrated population of the excited state. The ground-state population can be accessed by 
% _s.rho_hist(1,1,:)_. This is in contrast to the level number notation
% that is used by the _setDipole_, _addDissipation_, and
% _addDecoherence_ commands of the _System_ class, where 0 denotes the ground state and 1 
% the excited state of the two-level system.
%
% 