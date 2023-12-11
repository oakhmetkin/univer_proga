global a;

while (1 == 1)
  a = rand(2, 2)*2 - ones(2, 2);
  a(1, 2) = a(2, 1);
  if (det(a) > 0)
    break;
  endif
endwhile

f = @(x, y) a(1, 1).*x.^2 + a(2, 2).*y.^2 + 2*a(1, 2).*x.*y - 1;

boundaries = [-3, 3, -3, 3];
hold on;
grid on;
axis equal;

g = ezplot(f, boundaries);

# касательная и нормаль
global x0 y0
z = ginput(1);

fx = @(x, y) 2*a(1, 1).*x + 2*a(1, 2).*y - 1;
fy = @(x, y) 2*a(2, 2).*y + 2*a(1, 2).*x - 1;

x0 = z(1);
y0 = z(2);
kas = @(x, y) fx(x0, y0).*(x - x0) + fy(x0, y0).*(y - y0);
##normal = @(x, y) (1/fx(x0, y0)).*(x - x0) + (y - y0);

hold on;
g = ezplot(kas, boundaries);
##g = ezplot(normal, boundaries);


