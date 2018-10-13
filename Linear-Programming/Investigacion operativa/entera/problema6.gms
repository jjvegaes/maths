Sets
         i variable /1*2/
         j restriccion /1*4/
;

Parameters
         c(i) /1 -5, 2 2/
         B(j) /1 79, 2 62, 3 -10, 4 6141/
;

Table
         A(j,i)
                 1       2
         1       1       1
         2       3       -62
         3       -1      -1
         4       69      89
;

Free Variables
         z  valor objetivo
;

Positive Variables
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
Solve ex1 using LP maximizing z;