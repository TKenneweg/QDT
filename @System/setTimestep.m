function setTimestep(this,a,b)
%set the timestep
this.timestepset = true;
this.timestep = a;
this.hev = a;
this.hint = a;
if nargin > 2
    this.hint = a;
    this.timestep = a;
    this.hev = b;
    if mod(this.hev,this.hint) ~=0
        error('mod(hev,hint) must equal 0');
    end
    error('different timesteps not supported at the moment');
end
end
