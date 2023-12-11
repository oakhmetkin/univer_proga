C = [
  1 3 2
  2 1 3
  3 2 1
];

A = C * C';

tau = 1/40;

b = [138; 144; 150];

x = rand(3, 1); # x0

for i=1:100
  x = x - tau*((x' * A)' + A*x - b);
endfor

disp(x);

