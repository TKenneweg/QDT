function settogroundstate(this)
%set the system to the ground state
this.rho = zeros(this.dim);
this.rho(1,1) = 1;
end
