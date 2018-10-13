Sets
         i variable /1*2/
         j restriccion /1*5/
;

Parameters
         c(i) /1 6, 2 -5/
         B(j) /1 21, 2 21, 3 -30, 4 651, 5 84/
;

Table
         A(j,i)
                 1       2
         1       0       1
         2       3       -21
         3       -1      -3
         4       31      21
         5       6       -5
;

Free Variables
         z  valor objetivo
;

Integer Variables
         x(i) variable de decision
;

Equations
         obj
         restriccion(j)
;
         obj.. z =e= sum(i, c(i)*x(i));
         restriccion(j).. sum(i, A(j,i)*x(i))=l=B(j);


* coding area
Model  ex1 /All/;
Solve ex1 using MIP maximizing z;
