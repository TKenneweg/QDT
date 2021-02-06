        function out = getConcurrence(this) 
        %get Concurrence of two qbit according to Wooters
            if this.dim ~= 4 || this.n ~=2
                  if this.reduced ==false
                      error('You need to trace out all but two qubits first');
                  end
            end
            sigmus = [0 -1i; 1i 0];
            sigmus = kron(sigmus, sigmus);
            out = zeros(this.num_it,1);
            rohflip = zeros(4,4,this.num_it);
            for i = 1:this.num_it
                if this.reduced ==false
                    rohflip(:,:,i) = sigmus * conj(this.rho_hist(:,:,i)) * sigmus;
                    rohflip(:,:,i) = this.rho_hist(:,:,i) * rohflip(:,:,i); %get rho * rhoflip
                else
                    rohflip(:,:,i) = sigmus * conj(this.reduced_rho_hist(:,:,i)) * sigmus;
                    rohflip(:,:,i) = this.reduced_rho_hist(:,:,i) * rohflip(:,:,i); %get rho * rhoflip
                end
                eigens  = sqrt(abs(eigs(rohflip(:,:,i),4)));
                if eigens(2) < eigens(1) %necessary for different matlab versions
                    eigens = flipud(eigens);
                end
                tmp = eigens(4) - eigens(3) - eigens(2)- eigens(1);
                c = max(0,tmp);
                out(i) = c; %this for concurrence

            end
            

            
        end
        
     
      