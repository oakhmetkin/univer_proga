b = 1;

function val = integ (x, y)
  F = @(t) t.^x .* sin(y.*t);
  val = quadv(F, 0, pi);
endfunction

tx = ty = linspace(-10, 10, 100);
[x, y] = meshgrid(tx, ty);
z = integ(x, y);

surf(x, y, z);
