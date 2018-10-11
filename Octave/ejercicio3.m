% EJERCICIO 3

f = inline('exp(x) - 3*x.^2','x');

g = inline('x - (exp(x)-3*x.^2)./(exp(x)-6*x)','x');

% Para nosotros, phi = g.

ejex = inline('0*x','x'); % Funcion para dibujar el eje X

I = [-3:0.01:3];
plot(I,ejex(I),I,f(I))

tol = 1.e-6;
nmax = 1000;
x0 = -1;

[zero, niter] = puntofijo2(g,x0,tol, nmax)
res = f(zero)

[zeroait, niterait] = aitken(g,x0,tol,nmax)
resait = f(zeroait)

% Conclusion, NO acelerar Newton con Aitken. Es contraproducente
% querer correr tanto.