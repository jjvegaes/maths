% SEMINARIO 1

clear all
close all
clc
format long

%EJERCICIO 1

%f = inline('sin(x)-exp(-x)','x');

%I = [0: 0.01 : 7];

%plot(I,f(I))

%tol = 1.e-5;  %10^-5, en general 1.eX es 10^X
%nmax = 100; 
%[zerobis, resbis, niterbis] = bisection(f,5,7,tol, nmax)

% Calcular las dos raices restantes (habrá que cambiar el intervalo).

%df = inline('cos(x)+exp(-x)','x');

%[zeronew, resnew, niternew] = newton(f, df, 6, tol, nmax)

% Calcular las dos raices restantes (habrá que cambiar x0).

% EJERCICIO 2

%f = inline('0.5 + 0.25*x.^2 - x.*sin(x) - 0.5*cos(2*x)','x');
%I = [-3: 0.01: 3];

%df = inline('0.5*x - sin(x) - x.*cos(x) + sin(2*x)','x');

%plot(I,f(I))
%tol = 1.e-6;
%nmax = 1000;
%[zero, res, niter] = newton(f,df,0.5,tol, nmax)

% Tras observar que el metodo va muy lento, nos aventuramos a estudiar
% la grafica de g'(x), donde g(x) = x - f(x)/f'(x), ya que esta nos dira
% si g(x) es contractiva o no, y esto se traduce en la convergencia del
% metodo.


% EJERCICIO 3

%f = inline('exp(x) - 3*x.^2','x');

%g = inline('x - (exp(x)-3*x.^2)./(exp(x)-6*x)','x');

% Para nosotros, phi = g.

%ejex = inline('0*x','x'); % Funcion para dibujar el eje X

%I = [-3:0.01:3];
%plot(I,ejex(I),I,f(I))

%tol = 1.e-6;
%nmax = 1000;
%x0 = -1;

%[zero, niter] = puntofijo2(g,x0,tol, nmax)
%res = f(zero)

%[zeroait, niterait] = aitken(g,x0,tol,nmax)
%resait = f(zeroait)

% Conclusion, NO acelerar Newton con Aitken. Es contraproducente
% querer correr tanto.


% EJERCICIO 4

%x0 = [0 0]';
%tol = 1.e-6;
%nmax = 1000;

%[zero, res, niter] = newtonsys(@Ffun, @Jfun,x0,tol,nmax) 

% Si definimos la funcion en un fichero aparte, deberemos llamarla
% utilizando @.






