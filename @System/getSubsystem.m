        function out = getSubsystem(this,name)
        %returns the subsystem name
            found = false;
            for i = 1:this.n
                if strcmp(name, this.subsystems{i,2})
                    out = this.subsystems{i,1};
                    found = true;
                    break;
                end
               
            end
            if found == false
                error(['subsystem ' name ' does not exist']);
            end
        end
        
     