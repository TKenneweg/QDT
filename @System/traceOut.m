function traceOut(this,name)
%trace out a subsystem, the reduced density matrices are safed in
%reduced_rho_hist
if this.reduced == false
    this.reduced =true;
    this.reducedsubnames = this.subnames;
    this.reduced_rho_hist = this.rho_hist;
end
sn = size(this.reduced_rho_hist,1);
csub = this.getSubsystem(name);
tmpreducedhist = zeros(floor(sn/csub.n),floor(sn/csub.n),this.num_it);
basevecs = {csub.n,1};
for i = 1:csub.n
    basevec = zeros(csub.n,1);
    basevec(i) =1;
    
    
    %situational expand
    currentdim = 1;
    wasfound = false;
    for k =1:length(this.reducedsubnames)
        if strcmp(name,this.reducedsubnames{k})
            basevec = kron(eye(currentdim),basevec);
            wasfound = true;
        else
            if wasfound
                basevec = kron(basevec,eye(this.getSubsystem(this.reducedsubnames{k}).n));
            end
        end
        currentdim = currentdim * this.getSubsystem(this.reducedsubnames{k}).n;
    end
    basevecs{i} = basevec;
end

for j = 1:this.num_it
    tracedmat = 0;
    for i = 1:length(basevecs)
        tracedmat = tracedmat + basevecs{i}' *  this.reduced_rho_hist(:,:,j) * basevecs{i};
    end
    tmpreducedhist(:,:,j) = tracedmat;
end
this.reduced_rho_hist = tmpreducedhist;

tmpsubnames= {};  %remove name that has been traced out from naming list
for i = 1:length(this.reducedsubnames)
    if ~strcmp(name,this.reducedsubnames{1,i});
        tmpsubnames{1,end+1} = this.reducedsubnames{1,i};
    end
end
this.reducedsubnames = tmpsubnames;
end