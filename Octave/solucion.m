% Practica I de Octave 

% 1) sea dada la funcion f(x) = -2*x.^3+5*x+2

% a) Aplicar el algoritmo de bisecci on para calcular todas las soluciones 
% de la ecuacion f(x) = 0 trabajando con una tolerancia de 10^−3 y un numero maximo de 100 iteraciones.
f = inline('-2*x.^3+5*x+2', 'x');
x = linspace(-5, 5, 1000);
y = f(x);
plot(x,y);
pause;

bisection(f, -3, -1, 10.^-3, 100)
bisection(f, -1, 0, 10.^-3, 100)
bisection(f, 0, 3, 10.^-3, 100)
pause;

% b) Aplicar el Metodo de Newton para resolver la misma ecuacíon con los
% mismos valores de tolerancia y numero maximo de iteraciones.

f_der = inline('-6*x.^2 + 5');
newton(f, f_der, -3,10.^-3, 100)
newton(f, f_der, -0.7,10.^-3, 100)
newton(f, f_der, 1.2,10.^-3, 100)
pause;

% 2 Sea dada la funcion f(x) = x^4-1-e^(-x)*x^2

% a) Considerando el esquema numerico asociado al Metodo de Newton 
% como un esquema de punto fijo, definir la funcion g_N(x) asociada al metodo
% y utilizar el algoritmo de punto fijo para calcular las soluciones de la
% ecuacion f(x) = 0 trabajando con una tolerancia de 10^−6
% y un ńumero maximo de 1000 iteraciones. 
% Utilizar el algoritmo Aitken para calcular las
% mismas soluciones mediante los mismos parametros de entrada
% (semillas, tolerancia y numero maximo de iteraciones).
% Comparar  los  resultados obtenidos en terminos de velocidad de convergencia.
f = inline('x.^4-1-exp(-x).*(x.^2)', 'x');
x = linspace(-2, 2, 1000);
y = f(x);
plot(x,y);
pause;
x = linspace(0.5, 1.5, 1000);
y = f(x);
plot(x,y);
pause;

f_der = inline('4*x.^3 + exp(-x).*x.^2 - 2*x.*exp(-x)', 'x');

% x = x - f(x)/f_der(x)
g = @(x) (x - (f(x)/f_der(x)));
fprintf('metodo de punto fijo');
puntofijo2(g, 1, 10.^-6, 1000)
fprintf('metodo de Aitken');
aitken(g, 1, 10.^-6, 1000)
pause;

% b) Considerar la funcion g(x) = (1+e^-x*x^2)^(1/4)
% que define el esquema de punto fijo x=g_1(x).
% Utilizar los algoritmos de punto fijo y de Aitken para resolver la ecuacíon
% f(x) = 0.  Utilizar los mismos par ́ametros de entrada 
% (semillas, tolerancia y numero maximo de iteraciones) del apartado anterior. 
g = inline('(1+exp(-x).*x.^2).^(1/4)')
x = linspace(-10, 10, 1000);
y = g(x);
plot(x, y);
pause;
fprintf('metodo de punto fijo\n');
puntofijo2(g, 1, 10.^-6, 1000)
fprintf('metodo de Aitken\n');
aitken(g, 1, 10.^-6, 1000)

% c) considerar la funcion g_2(x) = x+f(x)
% que define el esquema de punto fijo x=g_2(x).
% Utilizar  los  algoritmos de puntofijo y de Aitken 
% para resolver la ecuacion f(x) = 0.  
% Utilizar los mismos paŕametros de entrada (semillas, tolerancia 
% y numero maximo de iteraciones) del apartado anterior.  
% Comparar los resultados
g = @(x) x+f(x);
fprintf('metodo de punto fijo\n');
puntofijo2(g, 1.5, 10.^-6, 1000)
fprintf('metodo de Aitken\n');
aitken(g, 1.5, 10.^-6, 1000)

% 3. Estudiar los ceros de las ecuaciones f(x)=x^2-(cos x/4x)
f1 = @(x) x.^2-(cos(x)/4.*x) - 2;
f2 = @(x) x - exp(-x);
x = linspace(-10, 10, 1000);
plot(x, f1(x));
plot(x, f2(x));
pause;
f= @(x) f1(x) - f2(x);
ejex=inline('0*x','x');
I=[-1:0.2:1];
plot(I,ejex(I),I,f(I))
hold on
g=inline('x-((x.^2-x-cos(x)./(4*x)+exp(-x)-2)./(2*x-1-(-4*x.*sin(x)-4*cos(x))./(16*x.^2)-exp(-x)))','x');
dg=inline('(2*x-1-(-4*x.*sin(x)-4*cos(x))./(16*x.^2)-exp(-x))','x');
plot(I,dg(I),'g');
pause;
tol=1.e-6;
nmax=1000;
pox=find(dg(I)<1 & dg(I)>-1);
contractiva=I(pox);
x0 = I(pox(1));
[zero, niter] = puntofijo2(g,x0,tol,nmax)
res = f(zero)
[zeroait, niterait] = aitken(g,x0,tol,nmax)
resait = f(zeroait)

% 4. Resolver el Sistema de ecuaciones no lineales utilizando el Metodo de Newton 
% y trabajando con una tolerancia de 10^−6.
% Utilizar como semilla x=0 = (−1,−2,1)t.  
% Alternativamente puedes usar el comando fsolve de Octave.
% (Utiliza el comando: help fsolve para conocer
% que argumentos pide la funcíon fsolve).
x0 = [-1 -2 1]';
tol = 1.e-6;
nmax = 1000;

Ffun_p_4 = @(x) [x(1).^3+x(1).^2*x(2)-x(1)*x(3)+6 exp(x(1))+exp(x(2))-x(3) x(2).^2-2*x(1)*x(3)-4]';

Jfun_p_4 = @(x) [3*x(1).^2+2*x(1)*x(2)-x(3) x(1).^2 -x(1); exp(x(1)) exp(x(2)) -1; -2*x(3) 2*x(2) -2*x(1)];

[zero, res, niter] = newtonsys(Ffun_p_4, Jfun_p_4, x0, tol, nmax) 

