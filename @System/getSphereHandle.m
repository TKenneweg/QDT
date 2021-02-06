
function  out= getSphereHandle(this)
%creats a blochsphere and returns the handle
h = figure;
[x, y, z] = sphere(128);
h2 = surfl(x, y, z);
colormap([0  0  0]);
set(h2, 'FaceAlpha', 0.1)
shading interp
view([0.7 0.7 0.4]);
axis([-1 1 -1 1 -1 1]);
axis equal;

axis off;
hz1 = text(0,-0.2,1.2,'$$\hat{\textbf{z}}=|{0}\rangle$$','Interpreter','Latex');
hz1.FontWeight = 'bold';
hz1.FontSize = 15;
hz2 = text(0.25,-0.1,-1.2,'$$-\hat{\textbf{z}}=|{1}\rangle$$','Interpreter','Latex');
hz2.FontWeight = 'bold';
hz2.FontSize = 15;
hx1 = text(1.4,-0.2,0,'$$\frac{|{0}\rangle+ |{1}\rangle}{\sqrt2}$$','Interpreter','Latex');
hx1.FontWeight = 'bold';
hx1.FontSize = 10;
hx2 = text(-1.1,0,0,'$$\frac{|{0}\rangle- |{1}\rangle}{\sqrt2}$$','Interpreter','Latex');
hx2.FontWeight = 'bold';
hx2.FontSize = 10;
%hy = text(0,1.2,0,'$$\hat{\textbf{y}}$$','Interpreter','Latex');
hy = text(0.1,1.2,0,'$$\frac{|{0}\rangle+ i|{1}\rangle}{\sqrt2}$$','Interpreter','Latex');
hy.FontWeight = 'bold';
hy.FontSize = 10;
hy2 = text(0,-1.3,0,'$$\frac{|{0}\rangle- i|{1}\rangle}{\sqrt2}$$','Interpreter','Latex');
hy2.FontWeight = 'bold';
hy2.FontSize = 10;

r=1;
teta=-pi:0.01:pi;
x=r*cos(teta);
y=r*sin(teta);
hold on;
px=plot3(x,y,zeros(1,numel(x)));
p=plot3(x,zeros(1,numel(x)),y);
p.Color = px.Color;

x1 = [0 0]; %Erste x-Komponente geht von y(1)=0 mit Länge y(2)-y(1)=1-0=1
y1 = [0 1];
z1 = [0 0]; %Y-Pfeil

x2 = [0 1];
y2 = [0 0]; %X-Pfeil
z2 = [0 0];

x3 = [0 0];
y3 = [0 0]; %Z-Pfeil
z3 = [0 1];
drawArrow = @(x,y,z,varargin) quiver3( x(1),y(1),z(1),x(2)-x(1),y(2)-y(1),z(2)-z(1),0, varargin{:} );
drawArrow(x1,y1,z1,'linewidth',2,'color','black');
drawArrow(x2,y2,z2,'linewidth',2,'color','black');
drawArrow(x3,y3,z3,'linewidth',2,'color','black');

out = h;
end