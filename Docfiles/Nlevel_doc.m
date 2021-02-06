%% Nlevel
% One of two available subsystems. Can be used to model an atom or a molecule.
%% Syntax
% Nlevel(gaps)
%% Description
% Nlevel(gaps) The _gaps_ vector contains the energy gaps between different levels. If [1] is passed to the 
% constructor that will result in a qbit with an energy gap of $E_{01} = \hbar \cdot 1$ in atomic units (hbar = 1 in au). If an 
% arbitraty vector [a b] is passed this results in a three-level system with energy gaps $E_{01} = \hbar \cdot b$ 
% and $E_{01} = \hbar \cdot b$. The input vector can be arbitrarily long and must contain positive numbers.
% If a level structure is needed where certain level transition are not allowed this can be realized via the 
% setDipole(levels, value) command.
