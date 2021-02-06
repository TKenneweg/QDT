function out  = getOpValue(this,op,it)
%returns the expactation value of an arbitrary operator
if nargin < 3
    out = zeros(1,this.num_it);
    for i = 1:this.num_it
        out(i) = real(trace(this.rho_hist(:,:,i) * op));
    end
else
    out = real(trace(this.rho_hist(:,:,it) * op));
end
end
