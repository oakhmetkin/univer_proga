##f = @(x, y) x(1).^2 + x(1).*x(2) + x(2).^2 - 1;
##x0 = [5, 7];
##[x_min, min_val] = fminsearch(f, x0)


##f = @(a) quad(@(x) (sin(a(1)*x) + cos(a(2)*x)).^2, 0, pi);
##x0 = [0.2, 0.5];
##[x_min, min_val] = fminsearch(f, x0)


##f = @(x, y) [x(1).^4 + x(2).^2 - 16; x(1).^2 + x(2).^4 - 16];
##x0 = [4; 3];
##x_min = fsolve(f, x0)


f = @(x, y) [x(1).^4 + x(2).^2 - 25; sin(x(1)) + cos(x(2))];
x0 = [4; 3];
x_min = fsolve(f, x0)


# не работает
##sol = fsolve('x^4 + y^2 - 16', 'x^2 + y^4 - 16');
##sol.x
##sol.y
