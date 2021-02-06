classdef Lindbladterm <handle
    %Contains and manages dissipative and pure dephasing lindbladterms
    properties
        name; %name of the affected subsystem
        tdecay; %Decay time, the smaller the stronger the effect. If a dissipation effect is active, the population of the affected 
                % excited states decay to 1/e-th of their former population after tdecay.
        interval; %optional interval in which the effect is active
        level; %two number vector which if supplied determines the level transition the lindtbladt effect is active on.
        types = {'dissipation', 'decoherence','raising'}; %different types of lindblad terms
        type; %contains the lindbladterm type
        jumpOp; %jumping operator in the lindblad formalism.
        subsystem; %container for the affected subsystem
    end
    
    methods
        function this = Lindbladterm(type,sys,varargin)
             this.type = type;
             this.subsystem = sys;
             if ischar(varargin{1}) %no interval information
                 this.name = varargin{1};
                 this.interval = [0 inf];
                 this.tdecay = varargin{2}; 
                 if nargin ==5                      %specific dissipation
                     this.level = varargin{3};
                 else                               %non specific
                     this.level = [nan, nan];
                 end
             else                   %interval information
                 this.interval = varargin{1};
                 this.name = varargin{2};
                 this.tdecay = varargin{3};
                 if nargin ==6                      %specific 
                     this.level = varargin{4};
                 else                               %non specific
                     this.level = [nan, nan];
                 end
             end
             
             this.level = sort(this.level,'descend');
             this.jumpOp = zeros(sys.n,sys.n);
             if isnan(this.level(1)) %non specific
                 if strcmp(this.type,'dissipation')
                     this.jumpOp = sys.low;
                 else %implements decoherene between all levels
                     if strcmp(this.type,'decoherence')
                     this.jumpOp = sum(sys.decoh,3);
                     else %raising
                         this.jumpOp = sys.rai;
                         error('One way coupling is only implemented for specific couplings');
                     end
                 end
             else                       %specific
                 if strcmp(this.type,'dissipation')
                     if isa(sys,'Qoscillator')
                         warning('Addindg level dependent dissipation or decoherence to photon fields makes no sense');
                     end
                     this.jumpOp(this.level(2)+1,this.level(1)+1) = 1;
                 else
                     if strcmp(this.type,'decoherence')
                         this.jumpOp(this.level(2)+1,this.level(2)+1) = 1;
                         this.jumpOp(this.level(1)+1,this.level(1)+1) = -1;
                     else %raising
                         this.jumpOp(this.level(1)+1,this.level(2)+1) = 1;
                     end
                     
                 end
             end
            
        end
        
    end
    
end

