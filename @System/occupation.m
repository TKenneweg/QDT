
function out = occupation(this,a)
%returns the i-ths element of the diagonal of the density matrix
if a > this.dim
    error('Argument exeeds state dimension');
end
out = squeeze(real(this.rho_hist(a,a,:)));
end