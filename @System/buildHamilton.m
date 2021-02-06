
function buildHamilton(this)
%builds the complete non time-dependent System Hamiltonian
%calculate Hamiltonian
this.H = 0;
for i = 1:this.n
    this.H = this.H + this.subsystems{i,1}.H;
end
%coupling Hamiltonians
for i=1:length(this.Hys)
    tmp = this.Hys{i};
    if tmp.isspecificCoupling
        if isa(this.getSubsystem(tmp.name1),'Nlevel');
            big = max(tmp.level1)+1;
            small = min(tmp.level1)+1;
            low1 = zeros(this.getSubsystem(tmp.name1).n);
            low1(small,big) = 1;
            low1 = this.expand(low1,tmp.name1);
        else
            low1 = this.getSubsystem(tmp.name1).low;
        end
        if isa(this.getSubsystem(tmp.name2),'Nlevel');
            big = max(tmp.level2)+1;
            small = min(tmp.level2)+1;
            low2 = zeros(this.getSubsystem(tmp.name2).n);
            low2(small,big) = 1;
            low2 = this.expand(low2,tmp.name2);
        else
            low2 = this.getSubsystem(tmp.name2).low;
        end
    else
        low1 = this.getSubsystem(tmp.name1).low;
        low2 = this.getSubsystem(tmp.name2).low;
    end
    if this.rwa == true
        tmp.hamilton = tmp.y * (low1' * low2 + low1 * low2');
    else
        tmp.hamilton = tmp.y * (low1' + low1)*(low2' + low2);
    end
    this.H = this.H + tmp.hamilton;
    
end


end

