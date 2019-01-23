* La empresa PECE vende ordenadores y debe hacer
* una planificación de la producción de la próxima semana.

* La compañía produce tres tipos de ordenadores:
* de mesa (A), portátil normal (B) y portátil de lujo (C).
Sets
         i tipos de ordenadores /A, B, C/
;

* El beneficio neto por la venta de un ordenador
* es 350, 470 y 610 euros, respectivamente.
Parameters
         precios(i) precios de venta de ordenadores
                 / A     350
                   B     470
                   C     610/
;

* Cada semana se venden todos los equipos que se montan.

* Los ordenadores pasan un control de calidad de una hora
* y la empresa dispone de 120 horas para realizar
* los controles de los ordenadores A y B y 48 para los C.
Sets
         j operaciones /CC1, CC2, MNT/
;

Parameters

         recursos(j) recursos disponibles
                 / CC1   120
                   CC2   48
                   MNT   2000/
;

* El resto de las operaciones de montaje requieren 10, 15 y 20 horas,
* respectivamente y la empresa dispone de 2000 horas a la semana.
* El objetivo era maximizar el beneficio obtenido.
Table mtecn(i,j) matriz tecnologica
                 CC1     CC2     MNT
         A        1       0       10
         B        1       0       15
         C        0       1       20
;

* Tras observar el plan óptimo de producción,
* según el cual la empresa tiene que producir 120 ordenadores de tipo A,
* ningún ordenador de tipo B, y 40 ordenadores de tipo C,
* los responsables de la empresa dudan que sea viable e inteligente.
* Por un lado, ponen en duda que podrían vender los 120 ordenadores
* de tipo A a lo largo de la semana.
* Por otro lado, les preocupa que no se produzca ningún ordenador de tipo B,
* porque, aunque el beneficio sea menor,
* la compañía considera que no puede estar fuera de este mercado.

* Entonces, deciden elaborar una estrategia de producción y ventas
* para cuatro semanas siguientes.
* La idea detrás de esta decisión es que PECE
* puede elegir vender menos de lo que el mercado absorbería
* de un determinado producto en una cierta semana
* para utilizar sus instalaciones de producción de manera
* más rentable en la producción de otros productos.
Sets
         k semanas incluido mes inicial /S0, S1, S2, S3, S4/
         m(k) semanas que transcurre /S1, S2, S3, S4/
;

* En la Tabla están recogidas las previsiones
* de ventas máximas (es decir,
* lo máximo que absorberá el mercado) para las próximas 4 semanas.
Table demanda_prevista(i,m) Las previsiones de ventas máximas para las próximas 4 semanas
                 S1      S2      S3      S4
         A       60      80      120     140
         B       40      40      40      40
         C       50      40      30      70
;

* A su vez, se decide que venderán,
* como mínimo, 20 ordenadores de cada tipo semanalmente.
Scalar venta_min /20/;

* La empresa almacenará los ordenadores que produce
* y no vende para poder venderlos después.
* El almacenamiento tiene un coste de 9, 10 y 19 euros por semana
* para los ordenadores de tipos A, B y C, respectivamente.
Parameters
         costes(i)  coste de almacenamiento de cada tipo de ordcenador en el stock
                 / A      9
                   B      10
                   C      19/
;

* Inicialmente, las existencias de cada tipo de ordenador son 22, 48 y 36, respectivamente.
Parameters
         cantidadInicial(i) cantida de todos los tipos de ordenador que queda en el stock
                 / A     22
                   B     48
                   C     36/
;

* Para asegurar una transición más suave después de que hayan transcurrido las 4 semanas,
* se decide que el inventario final de cada producto en la semana 4 debe no ser inferior a 10.
Scalar inventario_final /10/;

* Los ordenadores sobrantes se venden a unos precios de 332, 450 y 574 euros,
* para los ordenadores de los tipos A, B y C, respectivamente.
Parameters
         precioRebajado(i) precio de todos los tipos de ordenador que queda en el stock al acabar la semana 4
                 / A   332
                   B   450
                   C   574/
;

* Las decisiones que debe tomar la empresa son: cuántos ordenadores montar
* de cada tipo cada semana, cuántos vender y cuántos almacenar.
Free Variables
         z beneficio total
;

Positive Variables
         b(m) beneficio semanal de venta de ordenadores
         c(m) coste de almacenamiento en la semana k
         bs beneficio de venta de ordenador sobrantes
;

Integer Variables
         p(i,m) cantidades de ordenadores i producidos en la semana k
         v(i,m) venta de ordenadores i en la semana k
         s(i,k) cantidad de ordenadores i que queda en el stock en la semana k

Equations
         beneficio beneficio total resultante incluyendo el coste de almacenamiento
         limites_recursos(j,m) restricciones de recursos
         beneficio_venta_semanal(m) beneficio semanal de venta de ordenadores
         costes_almacenamiento(m) coste de almacenamiento semanal
         stock_balance(i,m) restricciones de balance de stock
         beneficio_venta_sobrantes venta de los ordenadores sobrantes
;

* coding area
         v.lo(i,m) = venta_min;
         v.up(i,m) = demanda_prevista(i,m);
         s.lo(i,'S4') = inventario_final;
         beneficio..      z =e= sum(m, b(m)-c(m))+bs;
         limites_recursos(j,m)..    sum(i, mtecn(i,j)*p(i,m)) =l= recursos(j);
         beneficio_venta_semanal(m)..    b(m) =e= sum(i, precios(i)*v(i,m));
         costes_almacenamiento(m)..      c(m) =e= sum(i, s(i,m)*costes(i));
         s.fx(i, 'S0') = cantidadInicial(i);
         stock_balance(i,m(k)).. s(i,m) =e= s(i,k-1)+p(i,m)-v(i,m);
         beneficio_venta_sobrantes.. bs =e= sum(i, (s(i,'S4')-10)*precioRebajado(i));

Model practica2 /ALL/;
Solve practica2 using MIP maximizing z;


