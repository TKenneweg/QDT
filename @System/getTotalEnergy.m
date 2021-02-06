function out = getTotalEnergy(this)
%returns the energy of the complete system over time
out = zeros(1,this.num_it);
op = this.H;
for i = 1:this.num_it
    out(i) = real(trace(this.rho_hist(:,:,i) * op));
end
end