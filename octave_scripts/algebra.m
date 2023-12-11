D1 = [
  1 2 3
  5 1 4
  3 2 5
];

D2 = [
  -1 5 3
  3 -2 0
  -1 3 1
];

A = [
  -1 5 3
  3 -2 0
  -1 3 1
];

C = inv(D1) * D2

C_inv = inv(C)

A_result = C_inv * A * C
