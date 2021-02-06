function scaleOperators(this)
%internally called to size all operators to the correct hilbert
%space.
%resize all operators
for i = 1:this.n
    csub = this.subsystems{i,1};
    cname = this.subnames{i};
    csub.H = this.expand(csub.H,cname);
    csub.low = this.expand(csub.low,cname);
    csub.rai = this.expand(csub.rai,cname);
    if any(strcmp('decoh', properties(csub)))
        for j = 1:size(csub.decoh,3)
            tmp(:,:,j) = this.expand(csub.decoh(:,:,j),cname);
        end
        csub.decoh = tmp;
        clear tmp;
    end

    if any(strcmp('dipole_matrix', properties(csub)))
        csub.dipole_matrix = this.expand(csub.dipole_matrix,cname);
    end
    
end
%set up Lindblad jumping operators
for i = 1:length(this.Lindblads)
    this.Lindblads{i}.jumpOp = this.expand(this.Lindblads{i}.jumpOp,this.Lindblads{i}.name);
end
for i = 1:length(this.Onewaycouplings)
    this.Onewaycouplings{i}.lowl.jumpOp = this.expand(this.Onewaycouplings{i}.lowl.jumpOp,this.Onewaycouplings{i}.lowl.name);
    this.Onewaycouplings{i}.rail.jumpOp = this.expand(this.Onewaycouplings{i}.rail.jumpOp,this.Onewaycouplings{i}.rail.name);
end

end

