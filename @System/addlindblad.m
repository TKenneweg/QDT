
function addlindblad(this,type,varargin)
%used internally to add lindblad terms
if ischar(varargin{1})
    this.Lindblads{end+1} = Lindbladterm(type,this.getSubsystem(varargin{1}),varargin{:});
else
    this.Lindblads{end+1} = Lindbladterm(type,this.getSubsystem(varargin{2}),varargin{:});
end
this.lindbladsocalculated = false;
end