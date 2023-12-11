A = [
  0 1 -3
  2 3 1
  2 0 3
];

eigs = eig(A);
hold on;

for i=1:3
  R = sum(abs(A(i, :)));

  phi = linspace(0, 2*pi, 100);
  r = sqrt(R - abs(A(i, i)))

  x = A(i, i) + r * cos(phi);
  y = r * sin(phi);
  plot(x, y);
endfor

plot(eigs, '*');




