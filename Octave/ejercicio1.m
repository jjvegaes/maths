clear all
close all
clc
format long

%EJERCICIO 1

f = inline('sin(x)-exp(-x)','x');

I = [0: 0.01 : 7];

plot(I,f(I));

tol = 1.e-5;  %10^-5, en general 1.eX es 10^X
nmax = 100; 
x=[0 1.5;2 4.5;5 7];
for i=1:3
     fprintf('cuando a=%d y b=%d da lo siguiente:',x(i,1),x(i,2));
     [zerobis, resbis, niterbis] = bisection(f,x(i,1),x(i,2),tol, nmax)
end
     

 %Calcular las dos raices restantes (habrá que cambiar el intervalo).

df = inline('cos(x)+exp(-x)','x');

[zeronew, resnew, niternew] = newton(f, df, 6, tol, nmax)

%Calcular las dos raices restantes (habrá que cambiar x0).
