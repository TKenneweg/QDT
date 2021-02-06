function blochsphere(this,varargin)
%displays the trace of one or more bloch vectors of arbitrary two level systems.
vectors = {};
if length(varargin) > 7
    error('a maximum of 7 subsystems is supported');
end
for i = 1:length(varargin)
    if ischar(varargin{i})
        vectors{i} = this.getBlochvector(varargin{i});
    else
        error('names need to be strings');
    end
end
h = this.getSphereHandle();
for j = 1:length(vectors)
    h2 = plot3(vectors{j}(:,1),vectors{j}(:,2),vectors{j}(:,3));
    h2.LineWidth =2;
    if j == 1
        h2.Color = [1 0 0];
    elseif j == 2
        h2.Color = [0 0 1];
    elseif j == 3
        h2.Color = [1 0 1];
    elseif j == 4
        h2.Color = [0.5 1 1];
    elseif j == 5
        h2.Color = [0.2 0.2 0.2];
    elseif j == 6
        h2.Color = [1 0.5 1];
    elseif j == 7
        h2.Color = [1 1 0];
    end
    [x,y,z] =sphere;
    f= 0.03;
    surf(f*x+vectors{j}(end,1),f*y+vectors{j}(end,2),f*z+vectors{j}(end,3),'EdgeColor',h2.Color,'FaceColor',h2.Color);
end
end