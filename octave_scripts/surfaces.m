u = linspace(0, 2*pi, 50);
v = linspace(0, 2*pi, 50);
[uu, vv] = meshgrid(u, v);

# эллиптический параболоид
##u = linspace(0, 3, 50);
##v = linspace(0, 2*pi, 50);
##[uu, vv] = meshgrid(u, v);
##x = uu .* cos(vv);
##y = uu .* sin(vv);
##z = uu.^2;

# Круговой тор
##u = linspace(0, 2*pi, 50);
##v = linspace(0, 2*pi, 50);
##[uu, vv] = meshgrid(u, v);
##a = 5;
##b = 3;
##x = (a + b*cos(vv)) .* cos(uu);
##y = (a + b*cos(vv)) .* sin(uu);
##z = b*sin(vv);

# поверхность деформированной сферы
##u = linspace(-pi/2, pi/2, 50);
##v = linspace(0, 2*pi, 50);
##[uu, vv] = meshgrid(u, v);
##a = 1;
##x = a * cos(uu) .* cos(vv);
##y = a * cos(uu) .* sin(vv);
##z = sin(uu - a);

# поверхность с затухающими окружными волнами
##u = linspace(0, 6, 100);
##v = linspace(0, 2*pi, 50);
##[uu, vv] = meshgrid(u, v);
##a = 1; mu = 0.2; w = 4; phi = pi/2;
##x = a * uu .* cos(vv);
##y = a * uu .* sin(vv);
##z = a * exp(-mu*uu) .* sin(w*uu + phi);

# лента Мебиуса
##u = linspace(0, 2*pi, 50);
##v = linspace(-1, 1, 50);
##[uu, vv] = meshgrid(u, v);
##x = (1 + vv/2 .* cos(uu/2)) .* cos(uu);
##y = (1 + vv/2 .* cos(uu/2)) .* sin(uu);
##z = vv/2 .* sin(uu/2);

# геликоид
##u = linspace(0, 3, 50);
##v = linspace(0, 5*pi, 150);
##[uu, vv] = meshgrid(u, v);
##h = 1/4;
##x = uu .* cos(vv);
##y = uu .* sin(vv);
##z = h * vv;

# поверхность Эннепера
##u = linspace(-pi, pi, 50);
##v = linspace(-pi, pi, 150);
##[uu, vv] = meshgrid(u, v);
##x = uu .* (1 - uu.^2 / 3 + vv.^2) / 3;
##y = -vv .* (1 - vv.^2 / 3 + uu.^2) / 3;
##z = (uu.^2 - vv.^2) / 3;

# бутылка Клейна
##u = linspace(-pi, pi, 50);
##v = linspace(-pi, pi, 150);
##[uu, vv] = meshgrid(u, v);
##r = 2;
##x = (r + cos(uu/2).*sin(vv) - sin(uu/2).*sin(2*vv)) .* cos(uu);
##y = (r + cos(uu/2).*sin(vv) - sin(uu/2).*sin(2*vv)) .* sin(uu);
##z = sin(uu/2).*sin(vv) + cos(uu/2).*sin(2*vv);

# бутылка Клейна 2
u = linspace(0, pi, 120);
v = linspace(0, 2*pi, 100);
[uu, vv] = meshgrid(u, v);
x = -2/15*cos(uu).*(3*cos(vv) - 30*sin(uu) + 90*cos(uu).^4 .* sin(uu) - 60*cos(uu).^6 .* sin(uu) + 5*cos(uu).*cos(vv).*sin(uu));
y = -1/15*sin(uu).*(3*cos(vv) - 3*cos(uu).^2 .* cos(vv) - 48*cos(uu).^4 .* cos(vv) + 48*cos(uu).^6 .* cos(vv) - 60*sin(uu) + 5*cos(uu).*cos(vv).*sin(uu) - 5*cos(uu).^3 .* cos(vv) .* sin(uu) - 80*cos(uu).^5 .* cos(vv) .* sin(uu) + 80*cos(uu).^7 .* cos(vv).*sin(uu));
z = 2/15 * (3 + 5*cos(uu).*sin(uu)) .* sin(vv);



surf(x, y, z);
axis equal;




