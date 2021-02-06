function plotEfields(this)
%generates a plot of all external fields.

for i = 1:this.ne
    
    plot(this.time,this.Efields{i}.values);
    
    hold on;
end

xlabel('Time in au');
ylabel('Field strength in au');
title('Electric fields');
end

