%% lso
% Choose between utilizing Lindblad superoperators or not.
%% Syntax
% lso = boolean
%% Description
% If _boolean_ is set to _true_, the Lindblad superoperator is calculated and used in solving the Lindblad master equation.
% If _boolean_ is set to _false_, calculations proceed via the Lindblad
% master equation in its conventional form.
%% Detailed Description and Example
% The Lindblad master equation,
%
% $$\frac{\partial}{\partial t} \rho(t) = -\frac{i}{\hbar}[H(t),\rho(t)] +  \sum\limits_i \frac{1}{T_i} \left[ R_i \rho(t) R_i^{\dagger}
% - \frac{1}{2} R_i^{\dagger} R_i \rho(t) - \frac{1}{2} \rho(t) R_i^{\dagger}  R_i \right]$,
%
% can be expressed in a superoperator form,
%
% $$\frac{\partial}{\partial t} \rho(t) = -i \mathcal{L}_0 \rho(t) - \mathcal{L}_{\rm SO} \rho(t)$
%
% with
%
% $$\mathcal{L}_0 \rho(t) = \frac{1}{\hbar}\left[H(t),\rho(t)\right]$
%
% and
%
% $$\mathcal{L}_{\rm SO} \rho(t) = \sum\limits_i \frac{1}{T_i} \left[ R_i \rho(t) R_i^{\dagger}
% - \frac{1}{2} R_i^{\dagger} R_i \rho(t) - \frac{1}{2} \rho(t) R_i^{\dagger}
% R_i \right].$
%
% In order to employ Lindblad superoperators, use:
%%
%
%   s = System;
%   s.lso = true;
%
% With _s.lso. = true_, the Lindblad superoperator is 
% precalculated at the beginning of a simulation and then reused for
% every external light field in the course of the simulation.
% This avoids calculating the Lindblad operators for every new external
% light field and thus increases computational speed. 
%
% *Note:* employing Lindblad superoperators significantly enhances the
% speed of a simulation with a large amount of external fields as
% they are present in simulating two-dimensional (2D) spectroscopy. However, there
% are cases in which precalculating Linblad superoperators even increases computational cost such as in simulations
% with a single external light field. In these cases, _s.lso_ should be set to _false_.