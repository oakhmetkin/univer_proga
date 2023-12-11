b = 1;

function val = integ (x)
#  F = @(t) 1 ./ (1 - x.*sin(t));
#  val = quadv(F, 0, pi);
  F = @(t) t.^(x-1) .* e.^(-t);
  val = quadv(F, 0.001, 1000);
endfunction

X = linspace(0, 5, 100);
Y = integ(X);

plot(X, Y);
ylim([0, 4]);
axis equal;