function out =  getRefractiveIndex(this,name,eps)
%returns the refractive index of a subsystem
if nargin == 3
    xi = this.getSusceptibility(name,eps);
else
    xi = this.getSusceptibility(name);
end
N=1/100;
out = sqrt(1+xi*N);
end
