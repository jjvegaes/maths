* Se considera el siguiente problema de programación lineal
* (se muestra el formato obtenido con la librería lpSolveAPI de R):
*        max        1 x + -1 y
* sujerto a
*       1 x + 1 y = 6
*       0 x + 1 y = 4
*       -3 x -1 y = -3
*       5 x + 7 y = 35
*       x,y=0

Free Variables
         z
;

Positive Variables
         x1
         x2
;

Equations
         obj
         r1
         r2
         r3
         r4
;
         obj.. z=e=x1-x2;
         r1.. x1+x2=l=6;
         r2.. x2=l=4;
         r3.. -3*x1-1*x2=l=4;
         r4.. 5*x1+7*x2=l=35;
* coding area
Model  ex1 /All/;
Solve ex1 using LP maximizing z;