global a

L = 200;
alphas = linspace(0, 4*pi, L);
v1 = zeros(1, L);
v2 = zeros(1, L);

for i=1:L
  a = alphas(i);
  A = [
    cos(a) -sin(a)
    sin(a)  cos(a)
  ];
  eigs = eig(A);
  v1(i) = eigs(1);
  v2(i) = eigs(2);
endfor

plot(alphas, v2);


