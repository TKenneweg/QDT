function out = cellIkron( cell,n )
%used internally for the determination of state names.
m = size(cell,2);
for i = 1:m
    for j = 1:n
        out{n*(i-1)+j} = cell{i};
    end
end

end

