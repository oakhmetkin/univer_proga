global s1 s2;

f = figure;

function mf (p1, p2)
  global s1 s2;

  figure 2;
  hold off;

  # Круговой тор
  u = linspace(0, 2*pi, 50);
  v = linspace(0, 2*pi, 50);
  [uu, vv] = meshgrid(u, v);

  a = get(s1, "value");
  b = get(s2, "value");
  disp(a);
  disp(b);

  x = (a + b*cos(vv)) .* cos(uu);
  y = (a + b*cos(vv)) .* sin(uu);
  z = b*sin(vv);

  surf(x, y, z);
  axis equal;
endfunction


s1 = uicontrol (f,
  "style", "slider",
  "position", [50 350 200 40],
  "string", "a",
  "sliderstep", [0.010000 0.100000],
  "min", 0,
  "max", 10,
  "value", 3,
  "callback", {@mf}
  );

s2 = uicontrol (f,
  "style", "slider",
  "position", [50 300 200 40],
  "string", "b",
  "sliderstep", [0.010000 0.100000],
  "min", 0,
  "max", 10,
  "value", 5,
  "callback", {@mf}
  );

text = uicontrol (f,
  "style", "text",
  "position", [50 200 200 40],
  "string", "Тор с параметрами a, b"
  );

b2 = uicontrol (f,
  "position", [50 200 200 40],
  "string", "Построить тор",
  "callback", {@mf}
  );

