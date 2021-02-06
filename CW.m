function [ out ] = CW( amp,w,td ) %amplitude, resonance, phase delay
%continous wave
    out = @inner;
    function exF = inner(t)   
        exF = amp* sin(w*(t-td));
    end

end

