function reset(this)
%reset the system
this.rho = zeros(this.dim);
this.rho(1,1) = 1;
this.starttime = 0;
end