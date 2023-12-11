global edit_enter text_result;

f = figure;

edit_enter = uicontrol (f,
  "style", "edit",
  "position", [50 350 200 40],
  "string", "exp(sin(x) + (1/2)*log(x+1))"
  );

text_result = uicontrol (f,
  "style", "text",
  "position", [50 300 150 40],
  "string", "..."
  );

function mf (p1, p2)
  global edit_enter text_result;
  cmd = get(edit_enter, "string");

  figure 2;
  hold off;
  x = linspace(0, 4*pi, 100);
  y = eval(cmd);
  plot(x, y);
  m = min(y); M = max(y); a = max(abs(y));
  ylim([m - 0.1*a, M + 0.1*a]);
  axis equal;
  hold on;

  [x0 y0] = ginput(1);
  x = x0;
  f_x0 = eval(cmd);
  delta = 0.01;
  x = x + delta;
  f_x0_delta = eval(cmd);
  deriv = (f_x0_delta - f_x0) / delta;
  set(text_result, "string", num2str(deriv));

  X = linspace(0, 4*pi, 100);
  Y = f_x0 + deriv .* (X - x0);
  plot(X, Y);
  plot(x0, f_x0, 'o');
  ylim(m - 0.1*a, M + 0.1*a);
  axis equal;
endfunction

b2 = uicontrol (f,
  "position", [50 250 200 40],
  "string", "Построить график функции",
  "callback", {@mf}
  );



