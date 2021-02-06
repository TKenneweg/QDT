%% setEfieldparameter
% Set the parameters of the electric fields of each pulse that remain
% constant through multiple simulations with multipulse sequences.
%% Syntax
% * setdelayMaxs(amplitude,pulse_duration,central_frequency,gamma_0)
%% Description
% * c.setEfieldparameter(amp,t_pulse,w0,gamma0) _amp_ is the global
% electric field amplitude (in atomic units). _t_pulse_ corresponds to the
% temporal full width at half maximum (FWHM) of each pulse. _w0_ is the
% central frequency of each pulse. The parameter for the rotating frame of each pulse can
% be chosen with _gamma0_.
%% Detailed Description and Examples
% This command sets the amplitude, the temporal pulse duration, and the
% central frequency of each pulse of a multipulse sequence to constant
% values. All inputs must be passed as atomic units.
% Inputs can be given in other units such as femtoseconds if they are directly multiplied with their specific conversion factors from the _System_ class. 
% In addition to these parameters, the rotating frame _gamma_0_ of each
% pulse can also be chosen. Allowed values for _gamma_0_ are $(0 \leq \gamma_0 \leq 1)$, where $\gamma_0 = 0$ corresponds
% to the full rotating frame, $(0 < \gamma_0 < 1)$ to an intermediate
% regime (partially rotating frame), and $\gamma_0 = 1$ is the lab frame.
% Note that the parameter for the rotating frame must be chosen appropriately according the step
% size of the interpulse delays employed in the simulation in order to
% avoid aliasing artifacts. A value for _gamma_0_ close to $1$ will
% necessitate a smaller sampling step size. The quantitative relation
% between rotating frame and sampling step sizes
% is dictated by the Nyquist sampling theorem.

%% Example

s = System;
c = CMDS(s);

amp = 5e-4; %amplitude is given directly in atomic units
E0 = 2.0*s.evtoau; %central energy: 2 eV (and converted into atomic units)
t_pulse = 20*s.fstoau; %temporal FWHM: 20 fs (and converted into atomic units)
gamma0 = 0; %full rotating frame

c.setEfieldparameter(amp,t_pulse,E0,gamma0); % All electric field parameters are now internally stored in atomic units.
