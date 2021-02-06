function setuptime(this)
%internal, set up time and frequency vector

this.time = 0:this.timestep:this.tmax;

this.num_it = length(this.time);
%set up frequency vector
    if this.dfset == false
        this.df = 1/(2^nextpow2(this.num_it) *this.timestep);
    else
        this.df = 1/(this.nbins *this.timestep);
    end
    this.f = 0:this.df:1/(2*this.timestep);


end

















% function setuptime(this)
% %set up time vector
% %             if this.timestepset == false
% %                 this.setTimestep(this.Tmin/20);
% %             end
% if this.SIinput == true
%     this.SItime = 0:this.SItimestep:this.SItmax;
%     this.timestep = this.SItimestep * this.stoau;
%     this.tmax = this.SItmax * this.stoau;
% end
% %             this.time = 0:this.timestep:this.tmax;
% this.time = 0;
% rk = true;
% %             disp(this.switchtimes);
% this.time = 0:this.hint:this.switchtimes(1);
% for i  = 2:length(this.switchtimes)
%     
%     if rk == true
%         if length(this.time(end)+mod(this.switchtimes(i-1)-this.time(end),this.hint):this.hint:this.switchtimes(i)-this.hint) ~= 1
%             this.time = [this.time  this.time(end)+mod(this.switchtimes(i-1)-this.time(end),this.hint):this.hint:this.switchtimes(i)-this.hint];
%         end
%     else
%         if length(this.switchtimes(i-1):this.hev:this.switchtimes(i)-mod(this.difftimes(i-1),this.hev)) ~= 1
%         this.time = [this.time  this.switchtimes(i-1):this.hev:this.switchtimes(i)-mod(this.difftimes(i-1),this.hev)];
%         end
%     end
%     rk = ~rk;
% end
% %             this.time(end+1) = this.tmax;
% 
% 
% this.num_it = length(this.time);
% %set up frequency vector
% if this.SIinput == false
%     if this.dfset == false
%         this.df = 1/(2^nextpow2(this.num_it) *this.timestep);
%     else
%         this.df = 1/(this.nbins *this.timestep);
%     end
%     this.f = 0:this.df:1/(2*this.timestep);
% else
%     if this.dfset == false
%         this.SIdf = 1/(2^nextpow2(this.num_it) *this.SItimestep);
%     else
%         this.SIdf = 1/(this.nbins *this.SItimestep);
%     end
%     this.SIf = 0:this.SIdf:1/(2*this.SItimestep);
% end
% 
% end