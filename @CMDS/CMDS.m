classdef CMDS < handle
    
    properties
        %##############User Supplied############
        np =0; % number of pulses
        delayMaxs; % Array holding maximum delay times
        delaySteps; % Array holding the sampling rates of the different delays
        contributions; %contributions for phase cycling
        pcScheme; %phase cycling scheme;
        amp;
        tp;
        we;
        gamma0 = 1; %0 = rotating frame; 1 = lab frame
        returnFunction; % function to define output
        parallel = false; % Boolean for parallelization
        load_spec_path=[];
        %#####################################
        delayAxes = {}; %Axes for the delays
        freqAxes = {};
        weights; %for pc_weights_calculator, weighting factors for signal contributions
        phases; %for pc_weights_calculator, phase cycling steps
        CMDSdata;
        extSystem;
        tau_delay;
        t_delay;
        T_delay;
    end
    
    
    methods
        function this = CMDS(s) %constructor
            this.extSystem = s;
        end
        
        function buildAxes(this)
            %check if step number greater than zero
            tmp = true;
            for i = 1:length(this.delaySteps)
                if this.delaySteps(i) <= 0
                    tmp = false;
                end
            end
            if tmp == true
                %build axes
                for i = 1:length(this.delaySteps)
                    this.delayAxes{i} = 0:this.delayMaxs(i+1)/(this.delaySteps(i)-1):this.delayMaxs(i+1);
                    if this.delaySteps(i) == 1
                        this.delayAxes{i}= this.delayMaxs(i+1);
                    end
                    this.freqAxes{i} = -pi/(this.delayAxes{i}(2)-this.delayAxes{i}(1)):2*pi/this.delayMaxs(i+1):pi/(this.delayAxes{i}(2)-this.delayAxes{i}(1));                    
                end
            else
                error('Number of time steps must be larger than 1 for each pulse delay!');
            end
        end
        
        
        
        
        function generate_CMDS(this, name) %
            this.buildAxes;
            [this.phases,this.weights] = this.calculatePcWeights(this.contributions, this.pcScheme);
            % this.getdatadrivenenvelope;
            if this.parallel == true
                SimBot = gcp();
                %data = zeros(size(this.phases,1),length(this.delayAxes{1}),length(this.delayAxes{2}),length(this.delayAxes{3}));
            else
                h = waitbar(0);
            end
            
            switch this.np
                case 2
                        disp('two pulses!');
                       
                    for mm  = 1:1:size(this.phases,1)
                        for kk = 1:1:length(this.delayAxes{1})
                                if this.parallel == false
                                    %add field for ss systems
                                    for ss=1:1:size(name,1)
                                        if isempty(this.load_spec_path)
                                        this.extSystem.addExternalField(Twopulse(this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk)], this.tp,this.we, [this.phases(mm,1),this.phases(mm,2)], this.gamma0), name(ss,:), 'ExternalField');
                                        else %experimental datadriven external field 
                                        this.extSystem.addExternalField(Twopulse_from_loaded_spectrum(this.extSystem,this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk)],this.we, [this.phases(mm,1),this.phases(mm,2)], this.gamma0,this.load_spec_path), name(ss,:), 'ExternalField','spec_loaded');
                                        end
                                    end
                                    this.extSystem.simulate();
                                    this.CMDSdata(mm,kk) = this.returnFunction(this.extSystem);
                                    this.extSystem.reset();
                                    this.extSystem.removeEfield('ExternalField');
                                else
                                    data(mm,kk) = parfeval(SimBot,@this.SimulationTask2,1,name,mm,kk);
                                    clc;
                                    disp('Distribute Simulation Tasks...');
                                    %disp([mm,kk]);
                                end
                            if this.parallel == false
                                waitbar((mm*length(this.delayAxes{1})+kk)/(length(this.phases)*length(this.delayAxes{1})),h,'Simulating...');
                            end
                        end
                        dispstep = sprintf('Phase cycling step %d',mm);
                        disp(dispstep);
                    end
                    
                    if this.parallel == true    
                    this.collectResults2(data);
                    %delete(gcp);
                    end 
                    
                    
                    
                case 3
                    disp('three pulses!');
                   
                    for mm  = 1:1:size(this.phases,1)
                        for kk = 1:1:length(this.delayAxes{1})
                            for ii = 1:1:length(this.delayAxes{2})
                                if this.parallel == false
                                    %add field for ss systems
                                    for ss=1:1:size(name,1)
                                        if isempty(this.load_spec_path)
                                        this.extSystem.addExternalField(Threepulse(this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk) ,this.delayAxes{2}(ii)], this.tp,this.we, [this.phases(mm,1),this.phases(mm,2),this.phases(mm,3)], this.gamma0), name(ss,:), 'ExternalField');
                                        else %experimental datadriven external field 
                                        this.extSystem.addExternalField(Threepulse_from_loaded_spectrum(this.extSystem,this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk) ,this.delayAxes{2}(ii)],this.we, [this.phases(mm,1),this.phases(mm,2),this.phases(mm,3)], this.gamma0,this.load_spec_path), name(ss,:), 'ExternalField','spec_loaded');
                                        end
                                    end
                                    this.extSystem.simulate();
                                    this.CMDSdata(mm,kk,ii) = this.returnFunction(this.extSystem);
                                    this.extSystem.reset();
                                    this.extSystem.removeEfield('ExternalField');
                                else
                                    data(mm,kk,ii) = parfeval(SimBot,@this.SimulationTask3,1,name,mm,kk,ii);
                                    clc;
                                    disp('Distribute Simulation Tasks...');
                                    %disp([mm,kk,ii]);
                                end
                            end
                            if this.parallel == false
                                waitbar((mm*length(this.delayAxes{1})+kk)/(length(this.phases)*length(this.delayAxes{1})),h,'Simulating...');
                            end
                        end
                        dispstep = sprintf('Phase cycling step %d',mm);
                        disp(dispstep);
                    end
                    
                    if this.parallel == true    
                    this.collectResults3(data);
                    %delete(gcp);
                    end


                case 4
                    disp('four pulses!');
                    
                    for mm  = 1:1:size(this.phases,1)
                        for kk = 1:1:length(this.delayAxes{1})
                            for ii = 1:1:length(this.delayAxes{2})
                                for jj = 1:1:length(this.delayAxes{3})
                                    if this.parallel == false
                                      % add field for ss systems
                                       for ss=1:1:size(name,1)
                                            if isempty(this.load_spec_path)
                                            this.extSystem.addExternalField(Fourpulse(this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk) ,this.delayAxes{2}(ii),this.delayAxes{3}(jj)], this.tp,this.we, [this.phases(mm,1),this.phases(mm,2),this.phases(mm,3),this.phases(mm,4)], this.gamma0), name(ss,:), 'ExternalField');
                                            else %experimental datadriven external field 
                                            this.extSystem.addExternalField(Fourpulse_from_loaded_spectrum(this.extSystem,this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk) ,this.delayAxes{2}(ii),this.delayAxes{3}(jj)],this.we, [this.phases(mm,1),this.phases(mm,2),this.phases(mm,3),this.phases(mm,4)], this.gamma0,this.load_spec_path), name(ss,:), 'ExternalField','spec_loaded');
                                            end
                                       end
                                        this.extSystem.simulate();
                                        this.CMDSdata(mm,kk,ii,jj) = this.returnFunction(this.extSystem);
                                        this.extSystem.reset();
                                        this.extSystem.removeEfield('ExternalField');
                                    else

                                        data(mm,kk,ii,jj) = parfeval(SimBot,@this.SimulationTask4,1,name,mm,kk,ii,jj);
                                        %disp([mm,kk,ii,jj]);

                                    end
                                end
                                if this.parallel == false
                                    waitbar((mm*length(this.delayAxes{1})+kk)/(length(this.phases)*length(this.delayAxes{1})),h,'Simulating...');
                                end
                            end
                        end
                        dispstep = sprintf('Phase cycling step %d',mm);
                        disp(dispstep);
                    end
                if this.parallel == true    
                this.collectResults4(data);
                %delete(gcp);
                end
            end
            if this.parallel == false
                close(h);
            else
                delete(gcp);
            end
        disp('Simulation finished!');  
        end
        
        
          function collectResults2(this,data)
               disp('Retrieve Simulation Results...');
            for mm  = 1:1:size(this.phases,1)
                for kk = 1:1:length(this.delayAxes{1})
                        this.CMDSdata(mm,kk) = fetchOutputs(data(mm,kk));
                        clc;
                       
                        %disp([mm,kk]);
                end
            end
        end
        
        
        
        function collectResults3(this,data)
            disp('Retrieve Simulation Results...');
            for mm  = 1:1:size(this.phases,1)
                for kk = 1:1:length(this.delayAxes{1})
                    for ii = 1:1:length(this.delayAxes{2})
                        this.CMDSdata(mm,kk,ii) = fetchOutputs(data(mm,kk,ii));
                        clc;
                        
                        %disp([mm,kk,ii]);
                    end
                end
            end
        end
        
        function collectResults4(this,data)
            disp('Retrieve Simulation Results...');
            for mm  = 1:1:size(this.phases,1)
                for kk = 1:1:length(this.delayAxes{1})
                    for ii = 1:1:length(this.delayAxes{2})
                        for jj = 1:1:length(this.delayAxes{3})
                            this.CMDSdata(mm,kk,ii,jj) = fetchOutputs(data(mm,kk,ii,jj));
                           
                            %disp([mm,kk,ii,jj]);
                        end
                    end
                end
            end
        end
        
        
        
        
        function out = SimulationTask2(this,name,mm,kk)
            % add fields for every system
             for ss=1:1:size(name,1)
                if isempty(this.load_spec_path)
                    this.extSystem.addExternalField(Twopulse(this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk)], this.tp,this.we, [this.phases(mm,1),this.phases(mm,2)], this.gamma0), name(ss,:), 'ExternalField');
                else %experimental datadriven external field 
                    this.extSystem.addExternalField(Twopulse_from_loaded_spectrum(this.extSystem,this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk)],this.we, [this.phases(mm,1),this.phases(mm,2)], this.gamma0,this.load_spec_path), name(ss,:), 'ExternalField','spec_loaded');
                end 
             end
            this.extSystem.simulate();
            out = this.returnFunction(this.extSystem);
            this.extSystem.removeEfield('ExternalField');
            this.extSystem.reset();
        end
          function out = SimulationTask3(this,name,mm,kk,ii)
            % add fields for every system
             for ss=1:1:size(name,1)
                if isempty(this.load_spec_path)
                    this.extSystem.addExternalField(Threepulse(this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk) ,this.delayAxes{2}(ii)], this.tp,this.we, [this.phases(mm,1),this.phases(mm,2),this.phases(mm,3)], this.gamma0), name(ss,:), 'ExternalField');
                else %experimental datadriven external field 
                    this.extSystem.addExternalField(Threepulse_from_loaded_spectrum(this.extSystem,this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk) ,this.delayAxes{2}(ii)],this.we, [this.phases(mm,1),this.phases(mm,2),this.phases(mm,3)], this.gamma0,this.load_spec_path), name(ss,:), 'ExternalField','spec_loaded');
                end 
             end
            this.extSystem.simulate();
            out = this.returnFunction(this.extSystem);
            this.extSystem.removeEfield('ExternalField');
            this.extSystem.reset();
        end
        function out = SimulationTask4(this,name,mm,kk,ii,jj)
            if isempty(this.load_spec_path)
                this.extSystem.addExternalField(Fourpulse(this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk) ,this.delayAxes{2}(ii),this.delayAxes{3}(jj)], this.tp,this.we, [this.phases(mm,1),this.phases(mm,2),this.phases(mm,3),this.phases(mm,4)], this.gamma0), name, 'ExternalField');
            else %experimental datadriven external field 
                this.extSystem.addExternalField(Fourpulse_from_loaded_spectrum(this.extSystem,this.amp, [this.delayMaxs(1), this.delayAxes{1}(kk) ,this.delayAxes{2}(ii),this.delayAxes{3}(jj)],this.we, [this.phases(mm,1),this.phases(mm,2),this.phases(mm,3),this.phases(mm,4)], this.gamma0,this.load_spec_path), name, 'ExternalField','spec_loaded');
            end  
            
            this.extSystem.simulate();
            out = this.returnFunction(this.extSystem);
            this.extSystem.removeEfield('ExternalField');
            this.extSystem.reset();
        end
      
        
        
        
        
        
        function setReturnFunction(this,func)
            this.returnFunction = func;
        end
        
        
        function setdelayMaxs(this, d)
            this.delayMaxs = d;
            if this.np ~= 0 && length(d) ~= this.np
                error('Delay Vector must be the same size as number of pulses');
            else
                this.np = length(d);
            end
        end
        
        function setdelaySteps(this,d)
            this.delaySteps = d;
            if this.np ~= 0 && length(d) ~= this.np - 1
                error('Sampling Vector must be one smaller than number of pulses');
            else
                this.np = length(d)+1;
            end
        end
        
        function setContributions(this,d)
            this.contributions = d;
            if this.np ~= 0 && length(d) ~= this.np
                error('Vector with phase cycling contributions must be the same size as number of pulses');
            else
                this.np = length(d);
            end
        end
        
        function setPcScheme(this,d)
            this.pcScheme = d;
            if this.np ~= 0 && length(d) ~= this.np
                error('Vector with phase cycling scheme must be the same size as number of pulses');
            else
                this.np = length(d);
            end
        end
        
        function setEfieldparameter(this,amp,tp,we,gamma0)
            this.amp = amp;
            this.tp = tp;
            this.we = we;
            if nargin > 4
                this.gamma0 = gamma0;
            end
        end
        function calcEfieldfromspec(this,path_to_spec,amp,we,gamma0)
            this.amp=amp;
            this.we=we;
            this.load_spec_path=path_to_spec;
            if nargin > 3
                this.gamma0 = gamma0;
            end
        end
        
    end
end
