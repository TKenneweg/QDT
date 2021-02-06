
function out = getReducedMatrix(this,name,it)
%returns the reduced density matrix that describes one of the
%subsystems
if this.simulated == true
    tmpmat = this.rho_hist(:,:,it);
else
    tmpmat = this.rho;
end
tmpsubnames = this.subnames;
for j = 1:this.n
    if ~strcmp(name,this.subsystems{j,2})
        csub = this.subsystems{j,1};
        cname = this.subsystems{j,2};
        
        basevecs = {csub.n,1};
        for i = 1:csub.n
            basevec = zeros(csub.n,1);
            basevec(i) =1;
         
            currentdim = 1;
            wasfound = false;
            for k =1:length(tmpsubnames)
                if strcmp(cname,tmpsubnames{k})
                    basevec = kron(eye(currentdim),basevec);
                    wasfound = true;
                else
                    if wasfound
                        basevec = kron(basevec,eye(this.getSubsystem(tmpsubnames{k}).n));
                    end
                end
                currentdim = currentdim * this.getSubsystem(tmpsubnames{k}).n;
            end
            basevecs{i} = basevec;
        end
        
        tracedmat = 0;
        for i = 1:length(basevecs)
            tracedmat = tracedmat + basevecs{i}' * tmpmat * basevecs{i};
        end
        tmpmat = tracedmat;
        
        tmpsubnames2= {};
        for i = 1:length(tmpsubnames) %remove name that has been traced out from naming list
            if ~strcmp(cname,tmpsubnames{1,i});
                tmpsubnames2{1,end+1} = tmpsubnames{1,i};
            end
        end
        tmpsubnames = tmpsubnames2;
    end
end
out = tmpmat;
end