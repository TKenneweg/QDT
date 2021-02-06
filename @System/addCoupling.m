
function addCoupling(this,varargin)
%add a dipole-dipole coupling between two subsystem, either general or level specific.
nyx = size(this.Hys,2);
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
    this.Hys{nyx+1} = Coupling(name1,level1,name2,level2,y,true);
else
    name2 = varargin{2};
    y = varargin{3};
    level1 = [NaN NaN];
    level2 = [NaN NaN];
    this.Hys{nyx+1} = Coupling(name1,level1,name2,level2,y,false);
end
end

