* Una refinería de petróleo va a producir un nuevo tipo de gasolina
* mezclando las gasolinas que resultan de procesar diferentes tipos de crudo.
* Los crudos de origen son cuatro y tienen distinta composición.
* Para simplificar el problema se supone que cada tipo de gasolina
* tiene un porcentaje distinto de los aditivos A, B y C.
* La tabla siguiente indica estos porcentajes
* y el precio unitario para los cuatro tipos de gasolina:

* tipo de        Aditivos        Precio
* gasolina        A        B        c        (euros)
* 1        80        10        10        1.36
* 2        30        30        40        1.4
* 3        70        10        20        1.4
* 4        40        50        10        1.39

* Las exigencias del mercado imponen que la gasolina
* que se va a producir debe tener al menos el 39% del aditivo A,
* al menos un 21% del B y al menos un 23% del C.
* Además, no puede contener más de un 28% de la gasolina de tipo 1
* ni más de un 33% de la gasolina de tipo 2.
* Plantrar y resolver el problema para determinar la forma menos costosa
* de producir gasolina con estas especificaciones.

Sets
         i gasolina /1*4/
         j tipos de crudo /A*C/
;

Parameters
         porcentaje_minimo_crudo(j) porcentaje minimo que debe tener
                 / A             0.39
                   B             0.21
                   C             0.23/

         porcentaje_maximo_gasolina(i) porcentaje minimo que debe tener
                 / 1             0.28
                   2             0.33
                   3             1
                   4             1/
         precio(i) precio de gasolina i
                 / 1             1.36
                   2             1.4
                   3             1.4
                   4             1.39/
;

Table
         porcentaje(i,j) porcentaje de crudo j que tiene la gasolina i
                         A       B       C
         1               0.8     0.1     0.1
         2               0.3     0.3     0.4
         3               0.7     0.1     0.2
         4               0.4     0.5     0.1
;

Free Variables
         z    coste
;

Positive Variables
         p(i) porcentaje de i gasolina usado
;

Equations
         obj
         r_mezcla la mezcla de todo debe sumar uno
         r_porcentaje_minimo_crudo(j) la porcentaje minimo de cada crudo
;
         obj.. z =e= sum(i, p(i) * precio(i));
         r_mezcla.. sum(i, p(i)) =e= 1;
         r_porcentaje_minimo_crudo(j).. sum(i, p(i) * porcentaje(i, j)) =g= porcentaje_minimo_crudo(j);
         p.up(i) = porcentaje_maximo_gasolina(i);

* coding area
Model  ex1 /All/;
Solve ex1 using LP minimizing z;
