b = [-4*pi, 4*pi, -2, 2];
hold on

g = ezplot('y^2 + exp(-0.1 * x) * sin(x)', b);
g = ezplot('y - sqrt(exp(-0.1 * x))', b);

grid on
#axis equal


g = ezplot('x*sin(4*x) + y*cos(4*y)^2 - 1', b);
