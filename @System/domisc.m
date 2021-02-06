function domisc(this)
%sets up a basic time vector and calculates Efield values.

%set up time vector
if this.timestepset == false
    this.setTimestep(this.Tmin/20);
end
this.time = 0:this.timestep:this.tmax;
this.num_it = length(this.time);
%calculate external Fields
for i = 1:this.ne
    
    if this.Efields{i}.datadriven == false %datadriven external fields are experimental at current release
        this.Efields{i}.values = this.Efields{i}.handle(this.time+this.starttime);
    else 
        this.Efields{i}.values = this.Efields{i}.handle();         
     end
     
    
end

%set up initial density matrix
if size(this.initialStates,1) ~= 0
    for i = 1 : size(this.subsystems,1)
        set = false;
        % is the state if a subsystem set? if yes take the user defined
        % state
        for j = 1: size(this.initialStates,1)
            if strcmp(this.subsystems{i,2},this.initialStates{j,1})
                set = true;
                tmp2 = this.initialStates{j,2}' * this.initialStates{j,2}; %state in density matrix form
                if i == 1
                    tmprho = tmp2;
                else
                    tmprho = kron(tmprho,tmp2);
                end
            end
        end
        
        %if no take the ground state
        if set == false
            vec = zeros(1,this.subsystems{i}.n);
            vec(1) = 1 ;
            vec = vec' * vec;
            if i == 1
                tmprho = vec;
            else
                tmprho = kron(tmprho, vec);
            end
        end
    end
    this.rho = tmprho;
end

end
