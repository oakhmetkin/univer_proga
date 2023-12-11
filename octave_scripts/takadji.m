f = t = 0

function val = T (X) 
  val = 0
  
  f = @(z) 2 * abs(z - fix(z + 1/2));
  t = @(x, n) 2^(-n) .* f(2^(n-1) * pi .* x);
  
  for i = 1:1:16
    val += t(X, i);
  endfor
endfunction


X = linspace(0, 1, 100000);
plot(X, T(X));
axis equal;