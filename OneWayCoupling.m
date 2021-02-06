classdef OneWayCoupling <handle
%Experimental one way coupling, which when implemented between two subsystems causes non-coherent one way energy transfer 
%between two level-transitions in two different subsystems.
    properties
        hamilton;
        y; %coupling strength
        name1; %name of the first subsystem
        name2; %name of the second subsystem
        level1;%level transitition of subsystem name1
        level2;%level transitition of subsystem name2
        isspecificCoupling; %non specific one way coupling not supported
        lowl; %lowering Lindbladterm
        rail; %raising Lindbladterm
        projectionOplow; %projection operator to determine the population in the low energy state in subsystem name2.
        projectionOprai; %projection operator to determine the population in the high energy state in subsystem name1.
    end
    
    methods
        function this = OneWayCoupling(name1,level1,name2,level2,y,sc)
            if length(level1) ~= 2 || length(level2) ~= 2
                error('level needs to be two values large');
            end
            this.y = y;
            this.name1= name1;
            this.level1 = level1;
            this.name2=name2;
            this.level2 = level2;
            this.isspecificCoupling = sc;
        end
    end
    
end

