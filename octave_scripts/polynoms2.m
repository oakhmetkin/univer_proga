# polynoms dividing
##[q, r] = deconv([2, -3, 4, -5, 6], [1, -3, 1])
##[q, r] = deconv([1, -3, -1, -1], [3, -2, 1])


# Gorner's table
##val = 0;
##
##function val = gorner (p, x)
##  val = zeros(length(x));
##  for i=1:length(p)
##    val .*= x;
##    val += p(i);
##  endfor
##endfunction
##
##p = [1 -2 6 -10 16];
##gorner(p, 4)
##
##p = [1 1+2i 0 -1-3i 0 7];
##gorner(p, -2-i)
##
##p = [1 0 -4 6 -8 10];
##gorner(p, 2)


# Simplest fractions
##N = [1];
##D = [1 0 0 0 4];
##
##function sf (N, D)
##  [r, s, K] = residue(N, D);
##  for i=1:length(r)
##    printf("%f / (x - (%f)) + \n", r(i), s(i));
##  endfor
##  printf("0\n");
##endfunction
##
##sf(N, D)


# Vandermond
f = @(x) cos(x);
x = linspace(-5, 5, 7);
y = f(x);
P = vander(x)^(-1) * y';
X = linspace(-10, 10, 200);
yP = polyval(P, X);
yF = f(X);
hold on;
plot(X, yF);
plot(X, yP);


