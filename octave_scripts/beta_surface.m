b = 1;

function val = beta (x, y)
  if x == 0 and y == 0
    val = 0
  else
    F = @(t) real(t.^(x-1) .* (1-t).^(y-1));
    val = quadv(F, 0, 1);
  end
endfunction

tx = ty = linspace(-10, 10, 40);
[x, y] = meshgrid(tx, ty);
z = beta(x, y);

surf(x, y, z);
