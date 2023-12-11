1;

global m d;
m = 4;
d = [3, 5, 2, -1];

function val = fff (x)
  global m d;
  val = 0;
  for k=1:m
    val += (d(k) - sin(k .* x)).^2;
  endfor
endfunction


[xm, ym] = fminbnd(@fff, 0, 2*pi);
X = linspace(0, 7, 300);
Y = fff(X);

hold on;
plot(X, Y);
plot(xm, ym, '*');

