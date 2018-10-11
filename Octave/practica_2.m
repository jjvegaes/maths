clear all
close all
clc
%apartado a)utilizar metodo de punto fijo y el algoritmo aitken 

f = inline('x.^4-1-(x.^2).*exp(-x)','x');

g = inline('x-(x.^4-1-(x.^2).*exp(-x))./(4*x.^3+(x.^2).*exp(-x)-2*exp(-x).*x)','x');


% Para nosotros, phi = g.

ejex = inline('0*x','x'); % Funcion para dibujar el eje X

I = [-1:0.01:1.5];
plot(I,ejex(I),I,f(I))
hold on

tol = 1.e-6;
nmax = 1000;
dg=inline('4*x.^3+(x.^2).*exp(-x)-2*exp(-x).*x','x');
plot(I,dg(I),'g')
pox=find(dg(I)<1 & dg(I)>-1);
contractiva=I(pox);
b=I(pox(1));
x0=b; %x0=-0.35

[zero, niter] = puntofijo2(g,x0,tol,nmax)
res = f(zero)

[zeroait, niterait] = aitken(g,x0,tol,nmax)
resait = f(zeroait)
%veo que el metodo de newton presenta menor errror pero mayor numero de iteracion que aitken 

%apartado b
g1=inline('(1+(x.^2)*exp(-x)).^0.25','x');
[zero_1, niter_1] = puntofijo2(g1,x0,tol,nmax)
res_1 = f(zero_1)
[zeroait_1, niterait_1] = aitken(g1,x0,tol,nmax)
resait_1 = f(zeroait_1)
%en este caso el metodo de aitken tiene menor error con menor numero de iteracion

%apartado c
g2=inline('x+x.^4-1-(x.^2).*exp(-x)','x');
[zero_2, niter_2] = puntofijo2(g2,x0,tol,nmax)
res_2 = f(zero_2)
[zeroait_2, niterait_2] = aitken(g2,x0,tol,nmax)
resait_2 = f(zeroait_2)


%en este caso el numero de iteracion sale muy grande????????????????
