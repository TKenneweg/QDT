function [phases weights] = calculatePcWeights(this,contribution,phase_cycling_scheme)
phases=[];
phase_cycling_vector=[];
if (length(contribution)==2 && length (phase_cycling_scheme)==2)
    alpha=contribution(1);
    beta=contribution(2);
    for ii=1:phase_cycling_scheme(1)
        for jj=1:phase_cycling_scheme(2)           
                phase_cycling_vector=[phase_cycling_vector
                    [exp(-1i*alpha*2*pi*(ii-1)/phase_cycling_scheme(1)) exp(-1i*beta*2*pi*(jj-1)/phase_cycling_scheme(2))]];
                phases=[phases
                    [2*pi*(ii-1)/phase_cycling_scheme(1) 2*pi*(jj-1)/phase_cycling_scheme(2)]];
        end
    end

elseif (length(contribution)==3 && length (phase_cycling_scheme)==3)
     alpha=contribution(1);
     beta=contribution(2);
     gamma=contribution(3);
     for ii=1:phase_cycling_scheme(1)
        for jj=1:phase_cycling_scheme(2)
            for kk=1:phase_cycling_scheme(3)
                phase_cycling_vector=[phase_cycling_vector
                    [exp(-1i*alpha*2*pi*(ii-1)/phase_cycling_scheme(1)) exp(-1i*beta*2*pi*(jj-1)/phase_cycling_scheme(2)) exp(-1i*gamma*2*pi*(kk-1)/phase_cycling_scheme(3))]];
                 phases=[phases
                    [2*pi*(ii-1)/phase_cycling_scheme(1) 2*pi*(jj-1)/phase_cycling_scheme(2) 2*pi*(kk-1)/phase_cycling_scheme(3)]];
            end
        end
     end
     
elseif (length(contribution)==4 && length (phase_cycling_scheme)==4)
    alpha=contribution(1);
    beta=contribution(2);
    gamma=contribution(3);
    delta=contribution(4);
    for ii=1:phase_cycling_scheme(1)
        for jj=1:phase_cycling_scheme(2)
            for kk=1:phase_cycling_scheme(3)
                for ll=1:phase_cycling_scheme(4)
                phase_cycling_vector=[phase_cycling_vector
                    [exp(-1i*alpha*2*pi*(ii-1)/phase_cycling_scheme(1)) exp(-1i*beta*2*pi*(jj-1)/phase_cycling_scheme(2)) exp(-1i*gamma*2*pi*(kk-1)/phase_cycling_scheme(3)) exp(-1i*delta*2*pi*(ll-1)/phase_cycling_scheme(4))]];
                phases=[phases
                    [2*pi*(ii-1)/phase_cycling_scheme(1) 2*pi*(jj-1)/phase_cycling_scheme(2) 2*pi*(kk-1)/phase_cycling_scheme(3) 2*pi*(ll-1)/phase_cycling_scheme(4)]];
                end
            end
        end
    end
    
else
     error('Check your input parameters!') 
end
    
weights=1/prod(phase_cycling_scheme)*prod(phase_cycling_vector,2);
end