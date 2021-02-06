%This function defines a pulse sequence for use in multidimensional
%spectroscopy (MDS), but will work for any other simulation as well. Note that
%for MDS no unified convention exists for several details such as the sign in
%front of the i. Depending on the choosen convention the used plotscripts must be
%adjusted. 
%td and ph take vectors of lenght 4, since 4 delays and phases must be
%defined (the first delay defines an offset from time = 0).
function out = Fourpulse(amp,td,tp,we,ph,gamma) %amp = amplitude, td = delay time, tp = pulswidth, we = frequency, ph = phases, gamma: 0 = full rotating frame; 1 = lab frame 
    out = @inner;
    tdsum = zeros(4,1);
    phsum = ph;
    phzero=0;
    for i = 1:4
        for j = 1:i
            tdsum(i) = tdsum(i) + td(j); 
        end
    end
    
   
    tpp=tp/sqrt(2*log(2)); %pre-calculate for speed
    function exF = inner(t) 
        res = exp(-((t-tdsum(1))/(tpp)).^2) .* exp(-1i*(we*(t-gamma*tdsum(1)) + phsum(1)+ phzero)) ...
            + exp(-((t-tdsum(2))/(tpp)).^2) .* exp(-1i*(we*(t-gamma*tdsum(2)) + phsum(2)+ phzero))...
            + exp(-((t-tdsum(3))/(tpp)).^2) .* exp(-1i*(we*(t-gamma*tdsum(3)) + phsum(3)+ phzero))...
            + exp(-((t-tdsum(4))/(tpp)).^2) .* exp(-1i*(we*(t-gamma*tdsum(4)) + phsum(4)+ phzero));
        res=amp*res;   
        exF = real(res);
    end
end

