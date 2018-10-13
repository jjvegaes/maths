* Nota: la tolerancia admitida en las respuestas es 4.

* Una empresa tiene una fábrica en la que produce piensos para animales.
* Ya se conocen los pedidos de los meses de febrero, marzo y abril: 3100, 3900 y 3800, respectivamente.
* La compañía no está obligada a satisfacer toda la demanda,
* aunque en la medida de lo posible lo hará.
* El més de febrero tiene 20 días de producción,
* el mes de marzo 23 y el mes de abril 22
* y la planta tiene una capacidad de producir 190 toneladas cada día.
* Al final del mes de enero tendrá un inventario de 150 toneladas
* que puede utilizar para servir la demanda del mes de febrero.
* Además, tiene suficiente capacidad de inventario para 1200 toneladas,
* de forma que todo lo que produce y no dedica a atender la demanda de ese mes,
* se almacena para utilizarlo el mes siguiente.
* Por motivos de seguridad, al final del mes de abril debe mantener un stock de 180.
* El coste de mantener el inventario de esta manera es de 6 euros por tonelada y mes.
* El coste de producción depende de cada mes (ya que debe comprar la matertia prima)
* y la estimación es que será de 64, 71 y 69 euros por tonelada en febrero, marzo y abril, respectivamente.
* El ingreso neto por ventas (precio de venta menos costes de envío normal)
* que recibe la compañía por cada tonelada es de 76.
* La compañía debe determinar cuánto fabricar cada mes y cuánto debe vender cada mes.
* El objetivo es determinar la política que maximice la ganancia total
* (ingresos netos por la venta menos la suma de los costes de producción y de inventario).
* Formular un modelo completo de programación lineal y resolverlo.
* La política óptima es:

Sets
         i meses /enero, febrero, marzo, abril/
         t(i) meses que habilita para la venta /febrero, marzo, abril/
;

Scalar
         inventario_inicial inventario de mes enero /150/
         inventario_final inventario de mes final de abril /180/
         capacidad capacidad maxima de inventario /1200/
         coste_almacenamiento coste de mantener el inventario por tonelada y mes /6/
         ingreso_neto ingreso neto por venta /76/
         produccion produccion por dia /190/
;

Parameters
         demanda(t) los pedidos de los siguientes meses
                 / febrero       3100
                   marzo         3900
                   abril         3800/

         dias(t) dias de produccion
                 / febrero       20
                   marzo         23
                   abril         22/

         coste(t) coste de produccion depende de cada mes
                 / febrero       64
                   marzo         71
                   abril         69/
;

Free Variables
         z    ganancia total
;

Positive Variables
         p(t) produccion de mes i
         v(t) venta de mes i
         s(i) stock final de cada mes
;

Equations
         obj
         r_stock_balance(t) la cantidad de stock que queda al final de mes
         r_maxima_produccion(t) maxima produccion de mes i
         r_capacidad_stock(t) capacidad de almacenamiento
         r_demanda(t) maxima demanda de i mes
;
         obj.. z =e= sum(t, v(t)*ingreso_neto - p(t)*coste(t) - s(t)*coste_almacenamiento);
         r_stock_balance(t(i)).. s(t) =e= s(i-1)+p(t)-v(t);
         s.fx('enero') = inventario_inicial;
         s.lo('abril') = inventario_final;
         r_maxima_produccion(t).. p(t) =l= produccion * dias(t);
         r_capacidad_stock(t).. s(t) =l= capacidad;
         r_demanda(t).. p(t) =l= demanda(t);

* coding area
Model  ex1 /All/;
Solve ex1 using LP maximizing z;
