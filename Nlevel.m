classdef Nlevel <handle
%Used to model n-level systems. A vector containing the energy gaps is
%passed as contructor input.
    properties
        n; %number of level
        low; %lowering operator
        rai; %raising operator
        decoh; %decoherence operators
        dipole_matrix; %dipol matrix
        w; %level gap vector
        H; %hamiltonian
        dipoleSet = false; %is a dipol set by the user?
        name; %the name the subsystem has in the context of the System class
    end
    
    methods
        function this = Nlevel(w)
            this.w = w;
            this.n = length(w) + 1;
            this.low = zeros(this.n,this.n);
            this.rai = zeros(this.n,this.n);
            for i = 2:this.n
                this.low(i-1,i) =1;
            end
             for i = 1:this.n-1
                this.rai(i+1,i) =1;
             end
            
             this.H = zeros(this.n,this.n);
             this.H(1,1) = 0;
             for i = 2 : this.n
                this.H(i,i) = this.w(i-1) + this.H(i-1,i-1); %w-vector gives gaps from lowest to highest level
             end
             
             
             %calculate decoherence operators, ALL operators
            this.decoh = zeros(this.n,this.n);
            tmp = 0;
            for i = 1:this.n-1
                for j= i+1:this.n
                    tmp = tmp +1;
                    this.decoh(:,:,tmp) = zeros(this.n,this.n);
                    this.decoh(i,i,tmp) = 1;
                    this.decoh(j,j,tmp) = -1;
                end
            end
            
            %set up dipole_matrix between levels as upper triangle matrix
            this.dipole_matrix = zeros(this.n);
            for i = 1:this.n
                for j = 1:this.n
                    if j>i
                        this.dipole_matrix(i,j) = 1;
%                         this.uppertri(i,j) =1;
                    end
                end
            end
            
        end
        
        function setDipole(this,level, value) %if this is used once all other dipole_matrix are set to zero
            if this.dipoleSet == false
                this.dipole_matrix = zeros(this.n);
            end
            this.dipoleSet = true;
            if length(level) == 2
                big = max(level)+1;
                small = min(level)+1;
                this.dipole_matrix(small,big) = value;
            else
                error('level must contain two numbers');
            end
            
        end
         
        
    end
    
end

