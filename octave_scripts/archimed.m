t = linspace(0, 6*pi, 100);

a = b = 1;

x = @(t) a*t.*cos(t);
y = @(t) b*t.*sin(t);

dx = @(t) a*cos(t) - a*t.*sin(t);
dy = @(t) b*sin(t) + b*t.*cos(t);

# plot 1
subplot(2, 1, 1);
hold on;
axis equal;
plot(x(t), y(t));
# tangent and normal lines
t0 = 13*pi/7;
x0 = x(t0); y0 = y(t0);
xd = dx(t0); yd = dy(t0);
k = yd / xd;
X = linspace(-20, 20, 100);
plot(X, y0 + k*(X - x0));
plot(X, y0 - 1/k*(X - x0));
plot(x0, y0, "*");
xlabel('x'); ylabel('y');
xlim([-20, 20]); ylim([-20, 20]);

# plot 2
subplot(2, 1, 2);
hold on;
plot(t, x(t));
plot(t, y(t));
legend('x', 'y');
xlabel('t'); ylabel('x(t), y(t)');
