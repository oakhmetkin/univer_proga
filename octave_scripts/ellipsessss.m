##[x, y, z] = ellipsoid(0, 0, 0, 3, 2, 1, 50);
##
##surfl(x, y, z);
##axis equal;

t = linspace(0, 8, 100);
[x, y, z] = cylinder(sin(t), 50);
S = surf(x, y, z);
