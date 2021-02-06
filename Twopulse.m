%This function defines a pulse sequence for use in multidimensional
%spectroscopy (MDS), but will work for any other simulation as well. Note that
%for MDS no unified convention exists for several details such as the sign in
%front of the i. Depending on the choosen convention the used plotscripts must be
%adjusted. 
%td and ph take vectors of length 2, since 2 delays and phases must be
%defined (the first delay defines an offset from time = 0).
function out = Twopulse(amp,td,tp,we,ph,gamma) %amp = amplitude, td = delay time, tp = pulswidth, we = frequency, ph = phases, gamma: 0 = full rotating frame; 1 = lab frame 
    out = @inner;
    tdsum = zeros(2,1);
    phsum = ph;
    for i = 1:2
        for j = 1:i
            tdsum(i) = tdsum(i) + td(j); 
        end
    end
    
    function exF = inner(t) 
        exF = amp*exp(-2*log(2)*((t-tdsum(1))/(tp)).^2) .* exp(-1i*(we*(t-gamma*tdsum(1)) + phsum(1)))...
            + amp*exp(-2*log(2)*((t-tdsum(2))/(tp)).^2) .* exp(-1i*(we*(t-gamma*tdsum(2)) + phsum(2)));
        exF = real(exF);
    end
end

