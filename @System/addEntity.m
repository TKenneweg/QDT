
function addEntity(this,subsystem,name)
%add a new subsystem to the overall system.
exists = false;
for i = 1:this.n
    if strcmp(this.subsystems{i,2},name)
        exists = true;
    end
end

if exists == false
    this.subnames{this.n+1} = name;
    %Look for smallest Period in System
    for i=1:size(subsystem.w,2)
        if 2*pi/subsystem.w(i) < this.Tmin
            this.Tmin = 2*pi/subsystem.w(i);
        end
    end
    %naming schema
    for i = 1:subsystem.n
        newstatenames{i} = [name ' = |' num2str(i-1) '> '] ;
    end
    
    if ~this.firstentity
        this.statenames = cellIkron(this.statenames,subsystem.n); %prepare old names
    end
    newstatenames = Icellkron(this.dim,newstatenames); %prepare new names
    
    
    this.n  = this.n + 1;
    this.dim = this.dim * subsystem.n;
    subsystem.name = name;
    this.subsystems{this.n,1} = subsystem;
    this.subsystems{this.n,2} = name;
    
    this.rho = zeros(this.dim);
    this.rho(1,1) = 1;    % ground state
    
    % naming
    if this.firstentity == true
        this.firstentity =false;
        this.statenames = cell(1, subsystem.n);
    end
    for i=1:size(newstatenames,2)
        this.statenames{i} = [this.statenames{i} newstatenames{i}];
    end
    %
else
    error(['Subsystem "' name '" already exists']);
end


end