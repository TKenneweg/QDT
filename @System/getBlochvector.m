function out = getBlochvector(this,name,ix) %if ix is given the blochvector for timestep ix is returned
%calculates the bloch vector for an arbitrary qbit. If the qbit is not the
%only subsystem all other subsystes are traced out to perform this
%operation.
csub = this.getSubsystem(name);
if csub.n ~= 2
    error('only supported for qbits');
end
if nargin ==2
    out = zeros(this.num_it,3);
    
    for i = 1:this.num_it
        tracedmat = this.getReducedMatrix(name,i);
        out(i,1) = 2*real(tracedmat(1,2));
        out(i,2) = 2 * imag(tracedmat(2,1));
        out(i,3) = real(tracedmat(1,1)) - real(tracedmat(2,2));
    end
else
    out = zeros(1,3); 
    tracedmat = this.getReducedMatrix(name,ix);
    out(1) = 2*real(tracedmat(1,2));
    out(2) = 2 * imag(tracedmat(2,1));
    out(3) = real(tracedmat(1,1)) - real(tracedmat(2,2));
end

end