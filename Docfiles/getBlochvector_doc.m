%% getBlochvector
% returns the bloch vector for an arbitrary qbit. If the qbit is not the
% only subsystem all other subsystes are traced out to perform this
% operation.
%% Syntax
% getBlochvector(name,ix)
%% Description
% getBlochvector(name,ix) Returns a  $R^{n x 3}$ matrix which contains the bloch vector of subsystem _name_ for every time point that was simulated.
% If the optional _ix_ is provided the method returns the bloch vector of the iteration number _ix_.
