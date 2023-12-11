##f = @(t, y) [1 - y(2); -1 + y(1)];
##
##y0 = [0 1];
##
##[T, Y] = ode45(f, [0, 10], y0);
##
##subplot(1, 2, 1);
##plot(T, Y);
##
##subplot(1, 2, 2);
##plot(Y(:, 1), Y(:, 2), y0(1), y0(2));


##hold on;
##omega = 0.25;
##f = @(t, x) sin(omega*t) .* sin(x);
##[T, Y] = ode45(f, [0 12*pi], [0.1]);
##plot(T, Y);
##omega = 0.5;
##f = @(t, x) sin(omega*t) .* sin(x);
##[T, Y] = ode45(f, [0 12*pi], [0.1]);
##plot(T, Y, '--');

##a = [
##  -0.7 -0.8
##     1  0.9
##];
##f = @(t, y) [a(1, 1)*y(1) + a(1, 2)*y(2);
##             a(2, 1)*y(1) + a(2, 2)*y(2)];
##y0 = [0 1];
##[T, Y] = ode45(f, [0 60], y0);
##
##subplot(1, 2, 1);
##plot(T, Y);
##
##subplot(1, 2, 2);
##plot(Y(:, 1), Y(:, 2), y0(1), y0(2));
##axis equal;


gammas = [0 0.05 0.2];
a = 0.2;
omega = pi;

hold on;
for i=1:length(gammas)
  gm = gammas(i);
  f = @(t, y) [                                y(2)
               -y(1)*(1 + a*sin(omega*t)) - gm*y(2)];
  [T, Y] = ode45(f, [0 16*pi], [0.1 0.1]);
  plot(T(:, 1), Y(:, 1));
endfor





