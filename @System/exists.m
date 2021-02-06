function out = exists(this,name)
%checks if a subsystem with the same name already exists.
exist = false;
for i = 1:this.n
    if strcmp(this.subsystems{i,1}.name,name)
        exist = true;
    end
end
out = exist;
end