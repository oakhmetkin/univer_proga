global mu
f = @(x) e.^(-mu .* x.^2) .* cos(x.^2);
mu = 0.1;

[xm, ym] = fminbnd(f, 0, pi)

X = linspace(0, 7, 300);
Y = f(X);

hold on;
plot(X, Y);
plot(xm, ym, '*');
