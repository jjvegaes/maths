clear all
close all
clc
f=inline('x.^2-cos(x)./(4*x)-2-x+exp(-x)','x');
ejex=inline('0*x','x');
I=[-1:0.2:1];
plot(I,ejex(I),I,f(I))
hold on
g=inline('x-((x.^2-x-cos(x)./(4*x)+exp(-x)-2)./(2*x-1-(-4*x.*sin(x)-4*cos(x))./(16*x.^2)-exp(-x)))','x');
dg=inline('(2*x-1-(-4*x.*sin(x)-4*cos(x))./(16*x.^2)-exp(-x))','x');
plot(I,dg(I),'g')
tol=1.e-6;
nmax=1000;
pox=find(dg(I)<1 & dg(I)>-1);
contractiva=I(pox);
b=I(pox(1));
x0=b;
[zero, niter] = puntofijo2(g,x0,tol,nmax)
res = f(zero)
[zeroait, niterait] = aitken(g,x0,tol,nmax)
resait = f(zeroait)