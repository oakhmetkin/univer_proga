global alpha;

hold on;
X = linspace(0.1, 1, 200);

for i=2:18
  alpha = i;
  f = @(x) x.^alpha .* log(x);
  plot(X, f(X));
  [xm, ym] = fminbnd(f, 0.1, 1);
  plot(xm, ym, '*');
endfor

ylim([-0.2, 0]);
