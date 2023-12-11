hold on;
axis equal;

N = 100;

A = [1, 1];
B = [5, 3];
aaa = linspace(-2, 2, N);

for i = 1:N
  a = aaa(i);
  x = linspace(-2, 7, 200);
  y = a*(x - A(1)).*(x - B(1)) + A(2).*(x - B(1))./(A(1) - B(1)) + B(2).*(x - A(1))./(B(1) - A(1));

  plot(x, y);
  plot(A(1), A(2), 'r', 'MarkerSize', 16);
  plot(B(1), B(2), 'r', 'MarkerSize', 16);
endfor

ylim([0, 8]);

