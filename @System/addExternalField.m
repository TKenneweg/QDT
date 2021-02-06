
function addExternalField(this,varargin) %function pointer, name of subsystem, optional efield name
%add an external classical field to the system dynamics.
if this.simulated == true
    this.efieldsChanged = true;
end
if this.exists(varargin{2})
    this.ne = this.ne+1;
    this.Efields{this.ne} = Efield(varargin{1},varargin{2});
    
       
    if isnumeric(varargin{1}) && nargin < 4
        error('Please provide an offset for the datadriven pulse');
    end
        
    if nargin > 3
        if isnumeric(varargin{3})
            this.Efields{this.ne}.offset = varargin{3};
            if nargin > 4 % zero padding provided
                if isnumeric(varargin{4})
                    this.Efields{this.ne}.zeroPadding = varargin{4}; % zeropadding for freq domain
                    if nargin > 5
                        this.Efields{this.ne}.fieldname =varargin{5};
                    end
                else
                    this.Efields{this.ne}.fieldname =varargin{4};
                end
            end
        else
            this.Efields{this.ne}.fieldname = varargin{3};
           if nargin>4 
            if ischar(varargin{4})
                if strcmp(varargin{4},'spec_loaded')
                    this.Efields{this.ne}.datadriven=true; %datadriven external fields are experimental at current release
                end
            end
           end
            
            
        end
    end
else
    error('You are trying to add an Efield to a subsystem that does not exist');
end

end


