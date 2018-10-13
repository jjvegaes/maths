* La empresa de productos lácteos produce leche en polvo,
* postres lácteos y quesos.
* La fabricación de cada producto requiere leche y
* dos tipos de procesos: esterilización y preparación.
* La cantidad de cada recurso necesaria para producir un kilogramo
* de cada producto aparece en la tabla siguiente:

* Recurso                        Leche en polvo        Postre lácteo        Queso
* Leche                          8 litros              6 litros             6 litros
* Horas de esterilización        4                     2                    1.5
* Horas de preparación           3                     1.5                  0.5
* En la actualidad se dispone de 57 litros de leche,
* 21 horas de esterilización y 16 horas de preparación.
* El beneficio obtenido por la venta de un kilo de leche en polvo es 61 euros,
* por un kilo de postre lácteo 32 euros y por un kilo de queso 17 euros.
* La empresa cree que puede vender toda la producción.
* Formular y resolver el problema al que se enfrenta la dirección de la empresa
* si su objetivo es maximizar beneficios. La solución óptima del problema es

Sets
         i producto /leche_polvo, postre, queso/
         j recurso  /leche, esterilizacion, preparacion/
;

Parameters
         precios(i) beneficio obtenido por la venta
                 / leche_polvo      61
                   postre           32
                   queso            17/

         recursos(j) recursos disponibles
                 / leche            57
                   esterilizacion   21
                   preparacion      16/
;

Table
         necesita(i,j) recursos necesarios
                         leche     esterilizacion      preparacion
         leche_polvo     8         4                   3
         postre          6         2                   1.5
         queso           6         1.5                 0.5
;

Free Variables
         z
;

Positive Variables
         produccion(i) kilos de producto
;

Equations
         obj
         r_recurso(j) restriccion de limite de recurso
;
         obj.. z=e=sum(i, precios(i)*produccion(i));
         r_recurso(j).. sum(i, necesita(i, j)*produccion(i))=l=recursos(j)
* coding area
Model  ex1 /All/;
Solve ex1 using LP maximizing z;
