%ejercicio2

f = inline('0.5 + 0.25*x.^2 - x.*sin(x) - 0.5*cos(2*x)','x');
I = [-3: 0.01: 3];

df = inline('0.5*x - sin(x) - x.*cos(x) + sin(2*x)','x');

plot(I,f(I))
tol = 1.e-6;
nmax = 1000;
[zero, res, niter] = newton(f,df,2.5,tol, nmax)

% Tras observar que el metodo va muy lento, nos aventuramos a estudiar
% la grafica de g'(x), donde g(x) = x - f(x)/f'(x), ya que esta nos dira
% si g(x) es contractiva o no, y esto se traduce en la convergencia del
% metodo.
