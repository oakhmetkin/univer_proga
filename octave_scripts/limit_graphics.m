b = 1;

function val = limit_graphics (b)
  s = 0;
  for j = 1:100
    s = b + sqrt(s);
  endfor

  val = sqrt(b - sqrt(s));
endfunction

X = linspace(0, 2, 100);
Y = limit_graphics(X);

plot(X, Y);


