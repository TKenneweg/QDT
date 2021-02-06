function  animateBlochsphere( this,varargin )
%creates an animation of a bloch vector of a qbit, the last argument
%defines the animation speed.
vectors = {};
speed = 1;
for i = 1:length(varargin)
    if ischar(varargin{i})
        vectors{i} = this.getBlochvector(varargin{i});
    else
        speed = varargin{i};
    end
end
h = this.getSphereHandle();
lines = cell(length(vectors),1);
for i = 1:length(vectors)
    lines{i} = animatedline([0 0],[0 0],[0 1]);
    lines{i}.LineWidth =3;
    %                 lines{i}.Color
end

t = text(-0.4,0.4,1.3,['Time: ' num2str(0)]);
i = 1;
delay = 0.04/speed;
while i <= this.num_it && ishandle(h)
    delete(t);
    t = text(-0.3,0.3,1.2,['Time: ' num2str(i * this.timestep)]);
    for j = 1:length(vectors)
        a = vectors{j};
        lines{j}.clearpoints;
        lines{j}.addpoints([0 a(i,1)],[0 a(i,2)],[0 a(i,3)]);
        drawnow;
    end
    pause(delay);
    i = i+1;
    
end
end



