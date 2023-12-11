x0 = y0 = p = T = K = 0;

function [x, y] = F (x0, y0, T, K)
  x(1) = x0;
  y(1) = y0;
  
  for i = 2:5000
    p = x(i-1) - K*sin(y(i-1))
    x(i) = p*cos(T) - y(i-1)*sin(T);
    y(i) = p*sin(T) + y(i-1)*cos(T);
  endfor
endfunction

# [x, y] = F(16.1, 5.5, 2*pi/4, 1.2);
# [x, y] = F(0.1, 0.5, 2*pi/3, 1.92);
[x, y] = F(0.1, 1.6, 2*pi/4.5, 2.2);
scatter(x, y);

