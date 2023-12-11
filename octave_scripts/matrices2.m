A = rand(5, 3);
B = rand(2, 3);
Z = zeros(5, 2);
E = eye(2, 2);

C = [
  A Z
  B E
];

disp(C);
