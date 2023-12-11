global n
n = 3;


F1 = @(x) x.*sin(x);
quad(F1, 0, pi)

F2 = @(x) (x.^n)*sin(3*x);
quad(F2, 0, pi)

F3 = @(x) x.^n;
quad(F3, -1, 1)

F4 = @(x) 1 / (sin(x) + cos(x)).^2;
quad(F4, 0, pi/2)

F5 = @(x) 1 / (1 + sin(x).^2);
quad(F5, 0, pi/2)

function val = F6 (x)
  if x < pi / 2
    val = sin(x);
  else
    val = 1 + 2*(pi/2 - x);
  end
endfunction
quad(@F6, 0, pi)
  
