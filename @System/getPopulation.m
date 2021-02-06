function out = getPopulation(this,name,a,it) %a is level, leveling starts at 0
%returns the population of a level of a subsystem
a = a+1;

op = zeros(this.getSubsystem(name).n);
op(a,a) = 1;
op = this.expand(op,name);
if nargin < 4
    out = zeros(1,this.num_it);
    for i = 1:this.num_it
        out(i) = real(trace(this.rho_hist(:,:,i) * op));
    end
else
    out = real(trace(this.rho_hist(:,:,it) * op));
end

end