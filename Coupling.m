classdef Coupling <handle
    %Container class that contains couplings between subsystems
    properties
        hamilton;
        y; %coupling strenght
        name1; %name of the first subsystem
        name2; %name of the second subsystem
        level1; %level transitition of subsystem name1 (only applicable of specific level transitions are coupled)
        level2;%level transitition of subsystem name2
        isspecificCoupling; %true if the coupling is only active between specific level transitions.
    end
    
    methods
        function this = Coupling(name1,level1,name2,level2,y,sc)
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

