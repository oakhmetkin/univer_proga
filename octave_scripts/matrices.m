R = rand(6, 3);
A = R(1:3, 1:3);

if (det(A) != 0)
  disp(A^(-1));
  disp("A * A^(-1) = E");
  disp(A * A^(-1));
else
  disp("det(A) = 0");
  disp(A);
endif

