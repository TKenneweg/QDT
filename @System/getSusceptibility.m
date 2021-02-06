
function out = getSusceptibility(this,name,eps)
%returns the suscepbtibility of a subsystem todo epsilon in au
if this.simulated == false
    error('simulate first please');
end
tmp = 0;
for i = 1:length(this.Efields)
    tmp = tmp + this.Efields{i}.values;
end
Fef = this.fft(tmp);
Fpf = this.fft(this.getPolarisation(name));

eO =1;
G = Fpf ./ (Fef*eO);
if nargin > 2
    epsilon = eps;
else
    epsilon = 1e-5;
end
for i = 1:length(Fef)
    if abs(Fef(i)) < epsilon %filter numerical issues
        G(i) = 0;
    end
end
out = G;
end


