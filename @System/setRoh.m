function setRoh(this,rho)
%set density matrix
if size(rho) ~= size(this.rho)
    error('wrong rho size');
end
this.rho = rho;
end
