       function plotRho(this,box)
       %plots the density matrix. To get a decent results define a box of
       %upper left corner and lower right corner.
            if nargin == 1
                box = [1 1 this.dim this.dim];
            end
            tmp = zeros(this.num_it,2);
            resx = box(3) - box(1) + 1;
            resy = box(4) - box(2) +1;
            count = 0;
            
            for i = box(1):box(3)
                for j = box(2):box(4)
                    count = count + 1;
                    subplot(resx,resy,count);
                    for z = 1:this.num_it
                        tmp(z,1) = real(this.rho_hist(i,j,z));
                        tmp(z,2) = imag(this.rho_hist(i,j,z));
                    end
                    plot(this.time, tmp(:,1));
                    hold on;
                    plot(this.time, tmp(:,2));
                    xlabel('Time');
                    str = sprintf('Rho(%d,%d)',i,j);
                    title(str);
                    legend('Real Part','Imaginary Part','Location','northeast');
                end
                
            end
        end
