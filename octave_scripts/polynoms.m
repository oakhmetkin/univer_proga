hold on;

p = [1, -3.55, 5.1, -3.1];

R = roots(p);
rr = max(R);

X = linspace(1, 2, 100);
Y = polyval(p, X);
plot(X, Y);

plot(rr, polyval(p, rr), 'o');
