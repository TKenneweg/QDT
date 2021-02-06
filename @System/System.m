classdef System < handle
    %System class. This is a container class that holds all entities that
    %take part in the simulation and provides a wealth of analytic
    %functionality to analyse the genereated density matrices. All
    %calculations are performed in atomic units.
    
    properties
        %###############################################################
        ooooooContainerVariablesooooo;
        subsystems; %contains the subsystem objects
        Hys; %couplings
        Onewaycouplings; %onewaycouplings
        Lindblads; %lindblad objects
        Efields; %External field objects
        Custom_spec; %datadriven external fields are experimental at current release
        statenames ={}; %names that provide information which state an element of the density matrix represents. Used in plotocupation
        H; %Hamilton
        rho_hist; %History of density matrices. All density matrices are safed here!
        reduced_rho_hist; %reduced density matrices are safed here.
        reducedsubnames = {};
        subnames = {}; %list of all subsystem names
        initialStates = {}; %list of initial states
        
        %###############################################################
        ooooooTimeVariablesoooooo;
        num_it = 4000; %number of iterations
        timestep = 0.1;
        timestepset = false; %is a timestep provided by the user?
        tmax =400; %time until which the simulation runs
        time = 0; %time vector
        fmax; %determined by timestep, maximum frequency
        nbins; % number of bins for fourier transform
        df;%incremental frequency increase of the fourier transformed signal. Determined by nbins and timestep
        f; %frequency vector
        dfset = false; %is the frequency interval set?
        switchtimes; %the times at which the integration switches between runge-kutta integration and the usage of the time evolution operator
        difftimes; %differences between switchtimes
        nis = []; %used for integration
        hev; %used for integration
        hint; %used for integration
        ct = 0; %current time for integration
        starttime = 0; %time at which the simulation starts relative to the external field function (for a single simulation always zero)
        %###############################################################
        ooooooBooleansooooo;
        reduced = false; %has a subsystem been traced out?
        rwa = true; %is the rotating wave approximation used?
        lso = false; %use Lindblad superoperator form?
        lindbladsocalculated = false; %is the lindblad superoperator calculated?
        simulated = false; %has the simulate commad already be called?
        efieldsChanged = false; %have the external fields changed between simulations?
        firstentity = true; %used for initialization
        Tmin = inf; %used for dynamic timestep generation
        %###############################################################
        ooooooNumbersandMatricesoooooo
        U1; %time evolution operator
        lindSO; %Lindblad superoperator
        rho =0; %density matrix
        nl = 0;  %number of lindbach bathes
        ne = 0; %number of external fields
        dim = 1; %system dimension
        n=0; % number of subsystems
        ny=0; % number of coupling hamiltonians
        %###############################################################
        ooooooConversionfactorsoooooo;
        stoau = 4.1341374e16;
        hztoau = 2.4188843265e-17;
        autohz = 4.1341374e16;
        autos = 2.4188843265e-17
        autofs = 2.4188843265e-2
        autoJs = 1.054571726e-34;
        autoVpm = 5.14220652e11;
        vpmtoau = 1.9446905e-12;
        autoJ =4.35974417e-18;
        Jtoau = 2.2937126e17;
        autoM = 5.291772109e-11;
        mtoau = 1.8897261246e10;
        nmtoau = 1.8897261246e1;
        autoCou = 1.602176565e-19;
        coutoau = 6.2415093e18;
        Ttoau = 1/2.35e5;
        autoT = 2.35e5;
        evtoau = 1/27.2114; 
        autoev = 27.2114;
        fstoau = 1/0.0241; 
    end
    
    
    
    methods
        function this = System %constructor
        end
        
        %calculates the times when the system changes betwween
        %runge kutta integration and time evolution
        function calculateswitchtimes(this)
            this.switchtimes = []; %reset switchtimes
            tmp = zeros(1,this.num_it);
            for i = 1:length(this.Efields)
                tmp = tmp + this.Efields{i}.values; %sum up all external fields
            end
           
            
            overthreshold = true;
            absthres = max(tmp)*1e-8; %threshold above which r-k is used depending on efield values.
            if max(tmp) == 0
                absthres = 1;
            end

            interval = 10; %check if interval many efield values lie below threshold
            for i = 1:floor((this.num_it)/interval-interval)
                [cm, ~]  = max(tmp(interval*(i-1)+1:interval*i).^2);
                if cm < absthres %below threshold change to evolution operator
                    
                    if overthreshold == true
                        this.switchtimes(end+1) = interval*(i-1) * this.timestep;
                        overthreshold =false;
                    end
                    
                else %over threshold
                    if overthreshold == false
                        this.switchtimes(end+1) = interval*(i-1) * this.timestep;
                        
                        overthreshold =true;
                    end
                end
            end
            
            this.switchtimes = [this.switchtimes this.tmax];
            this.difftimes(1) = this.switchtimes(1);
            for i = 2:length(this.switchtimes)
                this.difftimes(i) =  this.switchtimes(i) -  this.switchtimes(i-1);
            end
            for i = 1:length(this.difftimes)
                this.nis(i) = this.difftimes(i)/this.timestep;
            end
        end %end calculateswitchtimes
        
        %series evolution of the exponentiel function
        function out2 = exponen(this,a)
            out2 = eye(size(a,1));
            for i  = 1:100
                out2 = out2 + (a^i) / factorial(i);
            end
        end
        

        
        %create a hard copy of a system object. Useful for parallelization
        function out = copy (this)
            tmp = System;
            
            p = properties(this);
            for i = 1:length(p)
                tmp.(p{i}) = this.(p{i});
            end
            out = tmp;
        end
        
       
        
        function simulate(this)
            this.setuptime; %set up time and frequency vectors todo test
            this.domisc; %calculates field values and set up basic time vector.
            this.calculateswitchtimes; 
            if this.simulated == false %repeated simulating supported for changing fields
                this.scaleOperators; %inflates all operators by kronecker product
                %this.setuptime; %set up time and frequency vectors
                this.buildHamilton; %built the complete Hamiltonian
            end
            
            
            %set up for efficient efield hamiltonian calculation, build a cell array with efields and belonging subsystems
            tmpeAtom = {};
            tmpePhoton = {};
            for j = 1:this.n
                for k = 1:this.ne
                    if strcmp(this.subsystems{j,2}, this.Efields{k}.name)
                        if isa(this.subsystems{j,1},'Nlevel');
                            tmpeAtom{end+1,1}=  (this.subsystems{j,1}.dipole_matrix + this.subsystems{j,1}.dipole_matrix'); %dipolmatrix
                            tmpeAtom{end,2} = this.Efields{k};
                            
                        else
                            tmpePhoton{end+1,1} =this.subsystems{j,1}.dipol* (this.subsystems{j,1}.low + this.subsystems{j,1}.low');
                            tmpePhoton{end,2} = this.Efields{k};
                        end
                    end
                end
            end
            sa = size(tmpeAtom,1); %number of atoms with efields
            sp = size(tmpePhoton,1); %number of light modes with efields
            
            
            
            
            
            %efficient one way coupling
            %set up projection operator for fast main loop
            for i = 1:length(this.Onewaycouplings)
                cl = this.Onewaycouplings{i}.lowl;
                base = zeros(cl.subsystem.n);
                base(cl.level(1)+1,cl.level(1)+1) = 1;  %level is always sorted in descending order
                this.Onewaycouplings{i}.projectionOplow = this.expand(base,cl.name);
                cl = this.Onewaycouplings{i}.rail;
                base = zeros(cl.subsystem.n);
                base(cl.level(2)+1,cl.level(2)+1)= 1;
                this.Onewaycouplings{i}.projectionOprai = this.expand(base,cl.name);
            end
                       
        
            finished = false;
            rk = true;
            count = 1;
            this.rho_hist = zeros(this.dim,this.dim,this.num_it);
            this.rho_hist(:,:,1) = this.rho;
            cit = 1; %current iteration
            this.ct = 0;
            this.U1 = this.exponen(-1i*this.H * this.hev); %time evolution operator
            
            %Pre-calculating Lindblad superoperator
            if this.lso == true && this.lindbladsocalculated == false
            this.lindSO = this.getLindbladSuperOperator;
            this.lindbladsocalculated = true;
            end
            
            
            %mainloop
            if isempty(this.Lindblads)&& isempty(this.Onewaycouplings) %if true use U and rk4
                while (~finished)
                    ni = this.nis(count);
                    
                    if rk == true %do runge kutta integration
                        for j = 1:ni
                            Htmp = getHt(this.ct);
                            k1 = -(1i * (Htmp*this.rho -this.rho*Htmp) - getaddterm(this.rho)) * this.timestep;
                            Htmp = getHt(this.ct+0.5*this.timestep);
                            k2 = -(1i * (Htmp*(this.rho+0.5*k1) -(this.rho+0.5*k1)*Htmp) - getaddterm(this.rho+0.5*k1)) * this.timestep;
                            k3 = -(1i * (Htmp*(this.rho+0.5*k2) -(this.rho+0.5*k2)*Htmp) - getaddterm(this.rho + 0.5*k2)) * this.timestep;
                            Htmp = getHt(this.ct+this.timestep);
                            k4 = -(1i * (Htmp*(this.rho+k3) -(this.rho+k3)*Htmp)  - getaddterm(this.rho+k3)) * this.timestep;
                            this.rho = this.rho + 1/6 * k1 + 1/3*k2 + 1/3 * k3 + 1/6 *k4;
                            %save results
                            this.rho_hist(:,:,cit+1) = this.rho;
                            this.ct = this.ct + this.timestep;
                            cit = cit +1;
                            
                        end
                    else %perform time evolution
                        for j = 1:ni
                            this.rho = this.U1 * this.rho * this.U1';
                            this.rho_hist(:,:,cit+1) = this.rho;
                            this.ct = this.ct + this.hev;
                            cit = cit +1;
                        end
                    end
                    rk = ~rk;
                    
                    count = count +1;
                    if count -1 >= length(this.switchtimes)
                        finished = true;
                    end
                end
            else %normal rk4-integration
                if this.hev ~= this.hint
                    error('No time evolution wiht lindblad formalism possible, please set hev = hint');
                end
                for i = 2:this.num_it
                    Htmp = getHt(this.ct);
                    k1 = -(1i * (Htmp*this.rho -this.rho*Htmp) - getaddterm(this.rho)) * this.timestep;
                    Htmp = getHt(this.ct+0.5*this.timestep);
                    k2 = -(1i * (Htmp*(this.rho+0.5*k1) -(this.rho+0.5*k1)*Htmp) - getaddterm(this.rho+0.5*k1)) * this.timestep;
                    k3 = -(1i * (Htmp*(this.rho+0.5*k2) -(this.rho+0.5*k2)*Htmp) - getaddterm(this.rho + 0.5*k2)) * this.timestep;
                    Htmp = getHt(this.ct+this.timestep);
                    k4 = -(1i * (Htmp*(this.rho+k3) -(this.rho+k3)*Htmp)  - getaddterm(this.rho+k3)) * this.timestep;
                    this.rho = this.rho + 1/6 * k1 + 1/3*k2 + 1/3 * k3 + 1/6 *k4;
                    
                    %save results
                    this.rho_hist(:,:,i) = this.rho;
                    this.ct = this.ct + this.timestep;
                end
            end
            
            this.simulated = true;
            
            
            %calculate time dependent Hamiltonian
            function out = getHt(time)
                time = time + this.starttime; %starttime only non-zero if one system object is used for multiple simulations.             
                if this.lso == true
                    
                  Ht = zeros(this.dim,this.dim); 
                else
                Ht = this.H;
                end
                 %external efield hamiltonians
                %calculate hamiltonians for current timestep;
                for j = 1:sa
                    if tmpeAtom{j,2}.datadriven == true %datadriven external fields are experimental at current release
                        Ht = Ht - tmpeAtom{j,2}.values(getIndex) * tmpeAtom{j,1};
                    else
                        Ht = Ht - tmpeAtom{j,2}.handle(time) * tmpeAtom{j,1};
                    end
                end
                for j = 1:sp
                    if tmpePhoton{j,2}.datadriven == true %datadriven external fields are experimental at current release
                        Ht = Ht - tmpePhoton{j,2}.values(getIndex) * tmpePhoton{j,1};
                    else
                        Ht = Ht - tmpePhoton{j,2}.handle(time) * tmpePhoton{j,1};
                    end
                end
                
                out = Ht;
                
                function out = getIndex
                    tmp = round(time/this.timestep);
                    if tmp == 0
                        tmp = 1;
                    end
                    out = tmp;
                end
            end
            
            %calculate the Lindblad summand
            function out = getaddterm(crho)
                if this.lso == false
                    %calculate Lindblad term
                    tmplind = 0;
                    for j = 1:length(this.Lindblads)
                        if this.ct > this.Lindblads{j}.interval(1) &&  this.ct < this.Lindblads{j}.interval(2)
                            op = this.Lindblads{j}.jumpOp;
                            tmplind = tmplind +  1/this.Lindblads{j}.tdecay*(op*crho*ctranspose(op) - 1/2 * ctranspose(op)*op*crho - 1/2*crho*ctranspose(op)*op) ;
                        end
                    end
                    addTerm = tmplind;
                    
                    %one way couplings
                    tmp = 0;
                    for j = 1:length(this.Onewaycouplings)
                        fa = trace(crho*this.Onewaycouplings{j}.projectionOplow);
                        op = this.Onewaycouplings{j}.lowl.jumpOp;
                        tmp = tmp + 1/this.Onewaycouplings{j}.lowl.tdecay*(op*crho*ctranspose(op) - 1/2 * ctranspose(op)*op*crho - 1/2*crho*ctranspose(op)*op) ;
                        fa = fa * trace(crho*this.Onewaycouplings{j}.projectionOprai);
                        op = this.Onewaycouplings{j}.rail.jumpOp;
                        tmp = tmp + fa* 1/this.Onewaycouplings{j}.rail.tdecay*(op*crho*ctranspose(op) - 1/2 * ctranspose(op)*op*crho - 1/2*crho*ctranspose(op)*op) ;
                    end
                    
                    addTerm =addTerm + tmp;
                    out = addTerm;
                    
                else
                    out = reshape(this.lindSO * crho(:),size(crho));
                end
            end
            this.starttime = this.starttime  + this.time(end);
        end
        
    end %methods
     
    methods (Access = private)
        
    end
    
end

