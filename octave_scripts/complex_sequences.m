A = 9;
B = 0.2;
phi = 0.6;

z(1) = 2.4 + 2i;

for k = 2:1000
  z(k) = A + B*z(k-1)*exp(i*abs(z(k-1))^2 + i*phi);
endfor

X = real(z);
Y = imag(z);

scatter(X, Y);