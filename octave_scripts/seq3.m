clear all;

n = 1000;

# parabola
a = 1.4;
b = 0.3;

X(1) = 0.6;
Y(1) = 0.2;

for i=2:n
  X(i) = Y(i-1) + 1 - a*X(i-1)^2;
  Y(i) = b*X(i-1);
endfor

scatter(X, Y);
