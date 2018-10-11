% EJERCICIO 4

x0 = [0 0]';
tol = 1.e-6;
nmax = 1000;

[zero, res, niter] = newtonsys(@Ffun, @Jfun,x0,tol,nmax) 

% Si definimos la funcion en un fichero aparte, deberemos llamarla
% utilizando @.