clear all

hold off

tx = ty = tz = linspace (-2, 2, 40);
[x, y, z] = meshgrid (tx, ty, tz);

F = x.^2 + y.^2 + z.^2 - 1;
isosurface(F, 0);

