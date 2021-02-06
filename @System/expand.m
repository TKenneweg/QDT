function out = expand(this,mat,name) %system, matrix, subsystems name
%expands an arbitrary matrix to the System Hilbert space in a way that is
%consistent with a given subystem.
currentdim = 1;
wasfound = false;
for i =1:length(this.subnames)
    if strcmp(name,this.subnames{i})
        mat = kron(eye(currentdim),mat);
        wasfound = true;
    else
        if wasfound
            mat = kron(mat,eye(this.getSubsystem(this.subnames{i}).n));
        end
    end
    currentdim = currentdim * this.getSubsystem(this.subnames{i}).n;
end
out = mat;
end
