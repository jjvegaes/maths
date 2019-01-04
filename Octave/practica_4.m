
x0 = [-1 -2 1]';
tol = 1.e-6;
nmax = 1000;

[zero, res, niter] = newtonsys(@Ffun_p_4, @Jfun_p_4,x0,tol,nmax) 

% Si definimos la funcion en un fichero aparte, deberemos llamarla
% utilizando @.