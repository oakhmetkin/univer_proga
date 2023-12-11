A = [
  1 3 2 2
  2 1 1 3
  32 2 1 8
  5 4 3 2
];

z = rand(4, 1);
z = z / norm(z);

for i=1:100
  y = A * z;
  z = y ./ y(1);
endfor

disp(y(1));
