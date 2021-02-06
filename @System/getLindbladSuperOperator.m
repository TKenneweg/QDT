%sets Lindblad SO, newly including also the system coherent
%evolution
function out = getLindbladSuperOperator(this)
lbSO=zeros(this.dim^2,this.dim^2);
for i = 1:this.dim
    for j = 1:this.dim
        for k = 1:this.dim
            for l = 1:this.dim
                al=(i-1)*(this.dim)+j;
                be=(k-1)*(this.dim)+l;
                for kappa=1:length(this.Lindblads)
                    op = this.Lindblads{kappa}.jumpOp;
                    opop = op' * op;
                    tmp=op(i,k)*conj(op(j,l))-0.5*(this.kDelta(i,k)*opop(l,j)+this.kDelta(l,j)*opop(i,k));
                    lbSO(al,be)=lbSO(al,be)+1/this.Lindblads{kappa}.tdecay*tmp;                    
                end
                %and the coherent evolution
                lbSO(al,be)=lbSO(al,be)+1i*(this.H(i,k)*this.kDelta(l,j)-this.H(l,j)*this.kDelta(i,k));
            end
        end
    end
end
% if this.truerwa == true
%     for j = 1:length(this.etransitions)
%         al=this.etransitions{j}(1)*this.dim+this.etransitions{j}(2)+1;
%         be=this.etransitions{j}(2)*this.dim+this.etransitions{j}(1)+1;
%         lbSO(al,al)=lbSO(al,al)-1i*this.rwafreq;
%         lbSO(be,be)=lbSO(be,be)+1i*this.rwafreq;
%     end
%     for j = 1:length(this.ftransitions)
%         al=this.ftransitions{j}(1)*this.dim+this.ftransitions{j}(2)+1;
%         be=this.ftransitions{j}(2)*this.dim+this.ftransitions{j}(1)+1;
%         lbSO(al,al)=lbSO(al,al)-1i*2*this.rwafreq;
%         lbSO(be,be)=lbSO(be,be)+1i*2*this.rwafreq;
%     end
% end
    
out = lbSO;
end
