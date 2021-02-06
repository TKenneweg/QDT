function [Fy] = fft(this,y)
%internal fft function that sidestep a lot of the hassle that is usually
%occuring when dealing with numerical fourier transformations.
if this.dfset == false
    nbi = 2^nextpow2(this.num_it); % Next power of 2 from length of y
else
    nbi = this.nbins;
end
Fy = 2*fft(y,nbi)/this.num_it; %fft with n bins. Scale with length of signal to compensate for stupid fft
Fy = Fy(1:floor(nbi/2+1));
end

