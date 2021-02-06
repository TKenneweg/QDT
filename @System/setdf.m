function setdf(this,a)
%set the frequency vector increment
this.dfset = true;
this.nbins = round(1/(a*this.timestep));
this.df = 1/(this.nbins * this.timestep);
this.f = 0:this.df:1/(2*this.timestep);


end

