global a;

while (1 == 1)
  a = rand(2, 2)*2 - ones(2, 2);
  a(1, 2) = a(2, 1);
  if (1 == 1)
    break;
  endif
endwhile

eigs(a)
f = @(x, y) a(1, 1).*x.^2 + a(2, 2).*y.^2 + 2*a(1, 2).*x.*y - 1;

boundaries = [-3, 3, -3, 3];
hold on;
grid on;
axis equal;

g = ezplot(f, boundaries);



