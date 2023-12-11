phi = linspace(0, 2*pi, 200);
l = 5;

a = 1;
b = 5;

x = a + l*cos(phi);
y = a*tan(phi) + l*sin(phi);


plot(x, y)

axis([-5, 7, -15, 15])


