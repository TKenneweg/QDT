classdef Qoscillator <handle
    %Models a quantum harmonic oscialltor. Most often used to model the light field or plasmons in cavities.
    
    properties
        n; %number of level
        low; %lowering operator
        rai; %raising operator
        decoh; %decoherence operator
        w = 1; %level structure
        H; %Hamiltonian
        name; %subsystem name
        dipol = 1; %dipol
        dipoleSet = false;
    end
    
    methods
        function this = Qoscillator(n,w)
            this.w = w;
            this.n = n;
            this.low = zeros(this.n,this.n);
            this.rai = zeros(this.n,this.n);
            for i = 2:this.n
                this.low(i-1,i) =sqrt(i-1);
            end
            for i = 1:this.n-1
                this.rai(i+1,i) =sqrt(i);
            end
            
            this.H = zeros(n,n);
            for i = 1 : n
                this.H(i,i) =  this.w * (i-1); % hamilton with vacuum energy: this.H(i,i) =  this.w * (i-0.5);
            end
            
            %calculate all decoherence operators
            this.decoh = zeros(n,n);
            tmp = 0;
            for i = 1:n-1
                for j= i+1:n
                    tmp = tmp +1;
                    this.decoh(:,:,tmp) = zeros(n,n);
                    this.decoh(i,i,tmp) = 1;
                    this.decoh(j,j,tmp) = -1;
                end
            end
        end
        
        
        function setDipole(this, value)
            this.dipoleSet = true;
            this.dipol = value;
        end
    end
    
end

