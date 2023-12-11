function val = super_func (a);
  F = @(x) 1 / (1 + (a*sin(x))^2) - pi/4;
  val = quad(F, 0, pi/2);
  