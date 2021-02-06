%set the initial system density matrix
function setState(this,varargin)
if ischar(varargin{1})
    tmp =false;
    if length(varargin) > 2
        warning('setState has too many arguments')
    end
   %check if state was set beforehand
   for i = 1:size(this.initialStates,1)
       if strcmp(varargin{1},this.initialStates{i,1})
           this.initialStates{i,2} = varargin{2};
           tmp = true;
       end
   end
   if tmp == false
       this.initialStates{end+1,1} = varargin{1};
       this.initialStates{end,2} = varargin{2};
   end
else
    for i = 1: length(varargin)
        varargin{i} = varargin{i}' * varargin{i};
    end
    tmp = varargin{1};
    for i = 2: length(varargin)
        tmp = kron(tmp,varargin{i});
    end
    this.rho = tmp;
end
end