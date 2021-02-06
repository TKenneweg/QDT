classdef Efield <handle
%Container class for external electric fields.
    properties
        name; %name of the affected subsystem
        fieldname; %optional field name, needed to remove field later
        handle; %function handle
        values; %electric field values
        customspectral; %user-supplied spectral field
        offset; %offset supplied by user in case a custom spectrum is provided
        zeroPadding; %user supplied zero padding for time domain field calculation
        datadriven; %boolean (datadriven external fields are experimental at current release)
    end
    
    methods
        function this = Efield(varargin)

           this.datadriven = false;
           this.handle = varargin{1};

           this.name = varargin{2};
        end
    end
    
end

