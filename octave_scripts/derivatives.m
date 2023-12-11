hold on;
axis equal;

X = linspace(0, 2, 100);

mu = -1.5;
x0 = 0.7;

f = @(x) exp(mu * x);
df = @(x) mu * exp(mu * x);

# function
plot(X, f(X));

# tangent
plot(X, df(x0)*(X - x0) + f(x0));

# normal
plot(X, f(x0) - 1/df(x0)*(X - x0));

# x0 dot
plot(x0, f(x0), "*");

ylim([0, 2]);
