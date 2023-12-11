f = @(x, y) sin(x) .* cos(y);

x = linspace(-1, 1, 50);
y = linspace(-1, 1, 50);
[xx, yy] = meshgrid(x, y);
zz = f(xx, yy);

##surfc(xx, yy, zz);
##axis equal;

contourf(xx, yy, zz, 50);


colorbar;
