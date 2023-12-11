phi = linspace(0.01, 2*pi, 200);
r = cos(12*phi);

x = r.*cos(phi);
y = r.*sin(phi);

plot(x, y);

