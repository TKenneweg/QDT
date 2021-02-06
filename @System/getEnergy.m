function out = getEnergy(this,name)
%returns the energy of a subsystem (over time)
out = zeros(1,this.num_it);
op = this.getSubsystem(name).H;
for i = 1:this.num_it
    out(i) = real(trace(this.rho_hist(:,:,i) * op));
end
end