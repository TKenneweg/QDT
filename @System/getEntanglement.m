function out = getEntanglement( this )
%get entanglement according to Woooters
c = this.getConcurrence;
out = weirdf(c);
    function out =  weirdf(c) % monoton function (see wooters) eq. 8
        out = -(1+sqrt(1-c.^2))./2 .* log2((1+sqrt(1-c.^2))./2) - (1-sqrt(1-c.^2))./2 .* log2((1-sqrt(1-c.^2))./2);
    end
end

