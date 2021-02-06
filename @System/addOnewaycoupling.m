%this is an experimental feature
function addOnewaycoupling(this,varargin)
%add a one way noncoherent coupling between levels of two different subsystem
nyx = length(this.Onewaycouplings);
name1 = varargin{1};
if nargin > 4
    if isa(this.getSubsystem(name1),'Nlevel') %s1 = at
        level1 = varargin{2};
        name2 = varargin{3};
        if isa(this.getSubsystem(name2),'Nlevel') %s1 = at s2 = at
            level2 = varargin{4};
            y = varargin{5};
        else                                          %s1 = at s2 = ph
            level2 = [NaN NaN];
            y = varargin{4};
        end
    else                                            %s1 = ph s2 must be at or nargin = 4
        level1 = [NaN NaN];
        name2 = varargin{2};
        level2 = varargin{3};
        y = varargin{4};
    end
    this.Onewaycouplings{nyx+1} = OneWayCoupling(name1,level1,name2,level2,y,true);
else
    name2 = varargin{2};
    y = varargin{3};
    level1 = [NaN NaN];
    level2 = [NaN NaN];
    this.Onewaycouplings{nyx+1} = OneWayCoupling(name1,level1,name2,level2,y,false);
end

this.Onewaycouplings{end}.lowl = Lindbladterm('dissipation',this.getSubsystem(name1),name1,100/y,level1);
this.Onewaycouplings{end}.rail = Lindbladterm('raising',this.getSubsystem(name2),name2,100/y,level2);




end