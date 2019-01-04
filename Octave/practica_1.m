clear all
close all
clc
%apartado a)aplicar el algoritmo de biseccion
f=inline('-2*x.^3+x.*5+2','x');
I=[-3:0.01:3];
plot(I,f(I))
a=1;
b=2;
tol=1.e-3;
nmax=100;
[zero,res,niter]=bisection(f,a,b,tol,nmax)

%apartado b)aplicar metodo de newton
df=inline('-6*x.^2+5','x');
x0=2;
[zero,res,niter]=newton(f,df,x0,tol,nmax)
