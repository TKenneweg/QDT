function out = Icellkron( n,cell )
%used internally for the determination of state names.

m = size(cell,2);
for i = 1:n
    for j = 1:m
        out{m*(i-1)+j} = cell{j};
    end
end
end

