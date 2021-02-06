function out  = getPolarisation(this,name)
%returns the polarisation of a subsystem
out = zeros(1,this.num_it);
if isa(this.getSubsystem(name),'Nlevel')
    op = (this.getSubsystem(name).dipole_matrix + this.getSubsystem(name).dipole_matrix'); 
else
    op = this.getSubsystem(name).low  + this.getSubsystem(name).rai;
end

for i = 1:this.num_it
    out(i) = real(trace(this.rho_hist(:,:,i) * op));
end

end