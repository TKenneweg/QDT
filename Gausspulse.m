function [ out ] = Gausspulse( amp,td,tp,we) %td = delay time, tp = pulsewidth, we = frequency
%Gaussian pulse (external electric field)
    out = @inner;
    function exF = inner(t) 
        exF = amp*exp(-2*log(2)*((t-td)/(tp)).^2) .* cos(we*(t-td)); %external field
    end
end

