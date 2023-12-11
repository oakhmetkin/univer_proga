function [x; y] = F (x0, y0, p, T)
  x = y = 0;
  x(1) = x0;
  y(1) = y0;
  
  for i = 2:1000
    x(i) = p*cos(T) - y(i-1)*sin(T)
    y(i) = p*sin(T) + y(i-1)*cos(T)
  endfor
endfunction

[x, y] = F(5, 1, 2, 3/2);
plot(x, y);
