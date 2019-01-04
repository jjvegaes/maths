* Una empresa de instalaciones dispone de 210 kg de cobre,
* 16 kg de titanio y 22 kg de aluminio.
* Para fabricar 100 metros de cable de tipo A se necesitan 10 kg de cobre, 2 de titanio y 2 de aluminio,
* mientras que para fabricar 100 metros de cable de tipo B
* se necesitan 21 kg de cobre, 1 de titanio y 2 de aluminio.
* El beneficio que se obtiene por 100 metros de tipo A
* es de 1100 euros, y por 100 metros de tipo B, 700 euros.
* Calcular los metros de cable de cada tipo que hay que fabricar
* para maximizar el beneficio de la empresa. Obtener dicho beneficio.
Sets
         i cabre  /A, B/
         j metal /cobre, titanio, alumnio/
;

Parameters
         beneficio(i) recurso necesario para fabricar cabre
                 / A             1100
                   B              700/

         recurso(j) precios de venta de ordenadores
                 / cobre         210
                   titanio       16
                   alumnio       22/
;

Table
         necesita(i,j) recursos necesarios
                         cobre     titanio      alumnio
         A               10        2            2
         B               21        1            2
;

Free Variables
         z   beneficio total obtenido
;

Positive Variables
         x(i) centenas de cabre fabricado
;

Equations
         obj
         r_recurso(j) limite de recurso
;
         obj.. z =e= sum(i, x(i) * beneficio(i));
         r_recurso(j).. sum(i, x(i)*necesita(i,j)) =l= recurso(j);

* coding area
Model  ex1 /All/;
Solve ex1 using LP maximizing z;
