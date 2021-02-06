function plotoccupation(this,a)
%very popular. Generates plots with labels of all diagonal elements
%of the density matrix.
if nargin < 2
    tmp = ceil(sqrt(this.dim));
    for i = 1:this.dim
        subplot(tmp,tmp,i);
        plot(this.time,this.occupation(i));
        xlabel('Time in a.u.');
        ylabel('Population');
        title(this.statenames{i});
    end
else
    plot(this.time,this.occupation(a));
    
    title(this.statenames{a});
end
end
