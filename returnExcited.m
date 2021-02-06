function out = returnExcited
out = @inner;
    function out2 = inner(s)
        out2 =  sum(squeeze(s.rho_hist(2,2,:)));
    end
end