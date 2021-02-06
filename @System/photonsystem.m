classdef photonsystem <handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        n;
        low;
        rai;
        decoh;
        hbar = 1;
        w = 1;
        H;
        name;
        dipol = 1;
        dipoleSet = false; 
    end
    
    methods
         function this = photonsystem(n,w)
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
                this.H(i,i) = this.hbar * this.w * (i-1);% Hamilton mit Vakuum energy this.H(i,i) = this.hbar * this.w * (i-0.5);
             end
             
                   %calculate dissipation operators, ALL operators
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
         
         
        function setdipol(this, value)
            this.dipoleSet = true;
            this.dipol = value;            
        end
    end
    
end

