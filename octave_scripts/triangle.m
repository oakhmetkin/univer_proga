hold on;
axis([-10, 10, -10, 10]);
axis equal;

A = [2, 4];
B = [-6, 8];
C = [5, -6];

line([A(1), B(1)], [A(2), B(2)]);
line([B(1), C(1)], [B(2), C(2)]);
line([C(1), A(1)], [C(2), A(2)]);

k = (B(2) - C(2)) / (B(1) - C(1));

x_min = min([A(1), B(1), C(1)]);
x_max = max([A(1), B(1), C(1)]);
x = linspace(x_min, x_max, 100);
y_norm = -1/k * (x - A(1)) + A(2);
plot(x, y_norm);

a1 = k
b1 = -1
c1 = C(2) - k * C(1)

a2 = -1/k
b2 = -1
c2 = A(2) + 1/k * A(1)

common_det = a1*b2 - b1*a2
cross_x = (b1*c2 - c1*b2) / common_det
cross_y = (c1*a2 - a1*c2) / common_det

plot(A(1), A(2), 'r', 'MarkerSize', 16);
plot(B(1), B(2), 'r', 'MarkerSize', 16);
plot(C(1), C(2), 'r', 'MarkerSize', 16);
plot(cross_x, cross_y, 'r*', 'MarkerSize', 16);

