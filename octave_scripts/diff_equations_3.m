##global b r sg;
##
##b = 8/3; sg = 10; r = 200;
##x0 = [0 0.01 0.01];
##
##f = @(t, x) [
##  sg* (x(2) - x(1))
##  -x(2) + x(1)*x(3)
##  -b*x(3) + b*r - x(1)*x(2)
##];
##
##[T, Y] = ode23(f, [0, 6*pi], x0);
##
##plot3(Y(:, 1), Y(:, 2), Y(:, 3));
##axis equal;


global a b;

a = 0.2; b = 0.2; r = 100;
x0 = [0 0.01 0.01];

f = @(t, x) [
  -x(2) - x(1)
  x(1) + a*x(2)
  b + (x(1) - r)*x(3)
];

[T, Y] = ode23(f, [0, 31*pi], x0);

plot3(Y(:, 1), Y(:, 2), Y(:, 3));
axis equal;



