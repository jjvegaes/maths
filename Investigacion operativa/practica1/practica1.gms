* Una empresa petroqu´ýmica produce gasolina, gasoil y queroseno
* para venderlo en cuatro mercados diferentes: Espana, Portugal, Francia y norte de Africa.

* La materia prima, petr´oleo, se la compra cinco suministradores,
* con un precio de 57, 59, 63, 60 y 61 euros por barril (un barril=159 litros),
* mas unos costes de transporte a la refineria.

* La empresa tiene tres refiner´ýas desde las que puede atender
* los cuatro mercados y en las que puede recibir petroleo de los cuatro suministradores

* De un barril de petróleo crudo de cada suministrador es posible
* obtener los siguientes productos (en litros):

*        Suministrador   Gasolina        Gas-oil         Queroseno
*        A               72              37              12
*        B               82              35              14
*        C               69              50              8
*        D               79              40              10
*        E               80              20              15

* Los contratos que ha firmado con cada suministrador,
* obligan a la empresa a comprar un m´ýnimo de 100000 barriles
* y un maximo de 400.000 barriles diarios a cada uno de los suministradores
* (que pueden ser destinados a todas las refiner´ýas).

* Los costes de transporte del petroleo a cada refineria
* que cada suministrador anade al precio del barril
* se muestran en las siguiente tabla

* COSTES (euros)         refineria1      refineria2      refineria3
* Suministrador A        0,4             0.3             0.3
* Suministrador B        0.4             0.4             0.4
* Suministrador C        0.3             0.4             0.3
* Suministrador D        0.3             0.5             0.5
* Suministrador E        0.4             0.3             0.2

* Las siguientes tablas muestran la demanda (en millones de litros)
* de estos productos que podria atender la empresa
* y los ingresos netos (en euros)
* obtenido por cada litro de producto vendido (precio de venta menos impuestos,
* costes de producci´on y transporte desde una refineria hasta el punto de venta).

* DEMANDA        Espana          Portugal        Francia         Africa
* Gasolina       20              10              10              25
* Gas-oil        15              6               8               10
* Queroseno      10              3               4               12

* Ingresos netos Espana          Portugal        Francia         Africa
* Gasolina       0.7             0.65            0.80            0.75
* Gas-oil        0.65            0.75            0.65            0.55
* Queroseno      0.25            0.20            0.15            0.22

* Cada refineria tiene un coste de manipulacion de su produccion (por litro de producto manipulado)
* que se reflejan en la siguiente tabla:

* Costes         refineria 1     refineria 2     refineria 3
* Gasolina       0.023           0.021           0.031
* Gas-oil        0.015           0.062           0.062
* Queroseno      0.010           0.033           0.041

* El beneficio obtenido se obtiene restando a los ingresos netos los costes de compra, de transporte del
* petr´oleo hasta cada una de las refiner´ýas y de manipulaci´on en las refinerias.

Sets
         s suministrador /A, B, C, D, E/
         p producto /Gasolina, Gas_oil, Queroseno/
         m mercado   /Espana, Portugal, Francia, Africa/
         r refineria /R1, R2, R3/
;

Scalar
         min_compra limite inferior compra en barriles /100000/
         max_compra limite superior compra en barriles /400000/
         millon /1000000/
;

Parameters
         coste(s) coste de petroleo de cada suministrador
                 / A             57
                   B             59
                   C             63
                   D             60
                   E             61/
;

Table
         produccion(s, p) productos en litros obtenido por cada barril de petroleo de suministrador s
                         Gasolina       Gas_oil       Queroseno
         A               72             37            12
         B               82             35            14
         C               69             50            8
         D               79             40            10
         E               80             20            15
;

Table
         coste_transporte(s, r) costes de transporte a la refineria
                         R1      R2      R3
         A               0.4     0.3     0.3
         B               0.4     0.4     0.4
         C               0.3     0.4     0.3
         D               0.3     0.5     0.5
         E               0.4     0.3     0.2
;

Table
         demanda(p, m) demanda en millones de litros
                         Espana        Portugal        Francia        Africa
         Gasolina        20            10              10             25
         Gas_oil         15            6               8              10
         Queroseno       10            3               4              12
;

Table
         ingreso(p, m) ingreso neto obtenido por cada litro de producto vendido
                         Espana        Portugal        Francia        Africa
         Gasolina        0.7           0.65            0.80           0.75
         Gas_oil         0.65          0.75            0.65           0.55
         Queroseno       0.25          0.2             0.15           0.22
;

Table
         coste_manipulacion(p, r) coste de manipulacion de su produccion
                         R1              R2              R3
         Gasolina        0.023           0.021           0.031
         Gas_oil         0.015           0.062           0.062
         Queroseno       0.010           0.033           0.041
;

Free Variables
         z    beneficio obtenido
;

*Binary Variables
*          s_elegido(s) si selecciona suministrador s tiene valor 1 otro caso 0
*;

Positive Variables
         transportado(s, r) cantidad en barriles de crudo transportado desde suministrador s a refineria r
         venta(r, m, p) cantidad venda refineria mercado producto
;

Equations
         obj
         r_min_compra(s) obligan a comprar un minimo de barriles
         r_max_compra(s) un maximo de barriles
         r_demanda(p, m) la demanda (en millones de litros)
         b_venta(p, r) balance entre la suma de los vendidos en cada refineria con los producidos tratatodos
;

*        El benecio es la suma de todas los producots vendidos en cada mercado por su precio
         obj.. z =e= sum((p, m, r), ingreso(p, m)*venta(r, m, p))
*                    menos el coste materia prima
                     - sum((s, r), transportado(s, r) * coste(s))
*                    menos los costes de transporte
                     - sum((s, r), transportado(s, r) * coste_transporte(s, r))
*                    menos el coste de manipulacion
                     - sum((p, r), sum(s, transportado(s, r)*produccion(s, p))*coste_manipulacion(p, r));
*        limite inferior de la compra
         r_min_compra(s).. sum(r,transportado(s, r)) =g= min_compra;
*        limite superior de la compra
         r_max_compra(s).. sum(r,transportado(s, r)) =l= max_compra;
*        demanda maxima
         r_demanda(p, m).. sum(r, venta(r, m, p)) =l= demanda(p, m)*millon;
*        la suma de los vendidos en cada mercado
*        para cada producto de cada refineria
*        debe ser igual que  los producidos
         b_venta(p, r).. sum(m, venta(r, m, p)) =e= sum(s, transportado(s, r) *  produccion(s, p));

* coding area
option optcr = 0.0001;
Model  fase1 /All/;
Solve fase1 using LP maximizing z;

* Rediseño de la cadena de suministro
* compania ha decidido redisenar su cadena de suministro,
* simplificando su red de suministro y cerrando parte de sus instalaciones.
Scalar
         num_max_refineria /2/
         num_min_mercado /2/
         num_max_mercado /3/
         num_max_suministraor /4/
         num_min_suministrador_por_refineria /2/
         num_max_suministrador_por_refineria /3/
         min_porcentaje_suministrado /0.25/
         max_porcentaje_suministrado /0.75/
         penalizacion /100000/
         max_porcentaje_ocupacion_mercado_producto /0.75/
;

Parameters
         coste_fijo(r) /R1 0.6, R2 0.8, R3 0.75/
;

Binary Variables
*        Debe cerrarse una de las refinerias y operar desde 2 refinerias.
         d_refineria(r) decide si elije la refineria r
*        Desde cada refinería debe atender a un mínimo de dos
*        y un máximo de tres mercados diferentes
         d_r_atiende_mercado(r,m) decide si la refineria r atiende al mercado m
*        La companía solo puede comprar producto a un máximo de cuatro suministradores y,
*        además, cada refinería debe comprar a un mínimo de dos
*        y un máximo de tres suministradores.
         d_suministrador(s) decide si elije el suministrador s
         d_refineria_suministrador(s,r) decide si la refineria r compra a suministrador s
*        Cada refineria, en caso de ser utilizada,
*        debe pagar una penalizacion de 100.000 euros
*        por cada pais al que le sirve tres productos diferentes
*        (si solo le sirve uno o dos productos no paga esta penalizacion).
         d_penalizacion_refineria_pais(r,m) si en este pais tenemos que pagar multa por refineria r
         d_venta_producto_mercado(r,m,p) si vende productos p desde r a mercado m
;

Free Variables
         z2 variable objetivo de fase 2
;

Equations
*        Debe cerrarse una de las refiner´ýas y operar desde 2 refinerias
         r_max_refineria Debe cerrarse una de las refinerías y operar desde 2 refinerias
         i_transportado(s,r) nueva restriccion para la balance de refineria
*        Desde cada refinería debe atender a un mínimo de dos
*        y un máximo de tres mercados diferentes
         r_min_mercado(r) numero minimo de mercados que debe atender cada refineria
         r_max_mercado(r) numero maximo de mercados que debe atender cada refineria
         i_refineria_mercado(r,m,p) seleccion de mercado para cada refineria
*        La companía solo puede comprar producto a un máximo de cuatro suministradores y,
*        además, cada refinería debe comprar a un mínimo de dos
*        y un máximo de tres suministradores.
         r_max_suministrador maximo de cuatro suministrador
         r_min_refineria_suministrador(r) minimo suministrador para cada refineria
         r_max_refineria_suministrador(r) maximo suministrador para cada refineria
         r_refineria_suministrador(s, r) cada refineria solo puede comprar a suministrador abierto
         r_transporte_refineria_suministrador(s,r) solo lo envia producto al r si ha realizado comprar en el suministrador s
*        hay que redefinir el minimo compra y el maximo compra
         r_min_compra2(s) obligan a comprar un minimo de barriles
         r_max_compra2(s) un maximo de barriles
*        ningun suministrador de los seleccionados debe suponer menos del 25%
*        ni mas del 75% de las compras totales realizadas por todas las refinerias
         r_compra_min_porcentaje(s) o bien sea superior a un minimo porcentaje de compra
         r_compra_max_porcentaje(s) maximo de porcentaje comprado
*        Cada refineria, en caso de ser utilizada,
*        debe pagar una penalizacion de 100.000 euros
*        por cada pais al que le sirve tres productos diferentes
*        (si solo le sirve uno o dos productos no paga esta penalizacion)
         b_refineria_penalizada(r,m) si en este pais hay que pagar la penalizacion
         b_venta_producto_mercado(r,m,p) si vende producto a mercado
*        Por cuestiones de diversificaci ´on, cada mercado no puede recibir
*        mas del 75% de cada producto de la misma refineria
         r_max_porcentaje_refineria(r,m,p) no puede recibir mas de 75% de cada producto de la misma refineria
*        funcion objectivo de fase 2
         f_objectivo_nueva function objectivo de fase 2
;

* coding here
*        la suma de refinerias activas sea menor igual que dos
         r_max_refineria.. sum(r, d_refineria(r)) =l= num_max_refineria;
*        la refineria cerrada no recibe nada de petroleo
         i_transportado(s,r).. transportado(s, r)=l=d_refineria(r)*max_compra;
*        el numero minimo de mercados atendidos
         r_min_mercado(r).. sum(m,d_r_atiende_mercado(r,m))=g=num_min_mercado;
*        el numero maximo de mercados atendidos
         r_max_mercado(r).. sum(m,d_r_atiende_mercado(r,m))=l=num_max_mercado;
*        si la refineria r no atiende al mercado m, no vende
         i_refineria_mercado(r,m,p).. venta(r, m, p)=l=d_r_atiende_mercado(r,m)*demanda(p, m)*millon;
*        solo puede comprar producto a un maixmo de cuatro suministradores
         r_max_suministrador.. sum(s,d_suministrador(s))=l=num_max_suministraor;
*        cada refineria debe comprar a un minimo de dos suministradores
         r_min_refineria_suministrador(r).. sum(s,d_refineria_suministrador(s,r))=g=num_min_suministrador_por_refineria*d_refineria(r);
*        cada refineria debe comprar a un minimo de tres suministradores
         r_max_refineria_suministrador(r).. sum(s,d_refineria_suministrador(s,r))=l=num_max_suministrador_por_refineria*d_refineria(r);
*        solo envia materiales a refineria r si ha realizado compra al suministrador s
         r_transporte_refineria_suministrador(s, r).. transportado(s,r)=l=d_refineria_suministrador(s,r)*max_compra;
*        cada refineria solo puede comprar a un suministrador abierto
         r_refineria_suministrador(s, r).. d_refineria_suministrador(s,r) =l= d_suministrador(s);
*        En esta nueva situación, los límites de cantidad de
*        compra mínima y máxima a cada suministrador
*        sólo se aplican a los suministradores seleccionados
*        para servir a alguna refinería.
         r_min_compra2(s).. sum(r,transportado(s, r)) =g= d_suministrador(s)*min_compra;
         r_max_compra2(s).. sum(r,transportado(s, r)) =l= d_suministrador(s)*max_compra;
*        Ningun suministrador de los seleccionados
*        debe suponer menos del 25%
*        ni mas del 75% de las compras totales
*        realizadas por todas las refinerias.
         alias(s, ss);
*        implicacion: si ha sido seleccionado debe ser superior a 0.25 porcentaje
         r_compra_min_porcentaje(s).. sum(r,transportado(s, r)) =g=
                 min_porcentaje_suministrado*sum((ss, r), transportado(ss, r))
               - max_compra*num_max_suministraor*(1-d_suministrador(s));
         r_compra_max_porcentaje(s).. sum(r,transportado(s, r)) =l=
                 max_porcentaje_suministrado*sum((ss, r), transportado(ss, r))
               + max_compra*num_max_suministraor*(1-d_suministrador(s));
*        para cada refineria por cada pais al que le sirve tres productos recibirá la penalizacion
         b_refineria_penalizada(r,m).. sum(p, d_venta_producto_mercado(r,m,p))=l=d_penalizacion_refineria_pais(r,m)+2;
*        si vende o no el producto p en el mercado m desde refineria r
         b_venta_producto_mercado(r,m,p).. venta(r,m,p) =l= d_venta_producto_mercado(r,m,p)*demanda(p,m)*millon;
*        no puede recibir mas de 75% de cada producto de la misma refineria
         alias(r,rr);
         r_max_porcentaje_refineria(r,m,p).. venta(r,m,p)=l=max_porcentaje_ocupacion_mercado_producto*sum(rr,(venta(rr,m,p)));
*        z nueva, menos los costes fijos y penalizacion
         f_objectivo_nueva.. z2 =e= z
*        Las refiner ´ias 1, 2 y 3 tienen un coste fijo de funcionamiento
*        de 0.6, 0.80 y 0.75 millones deeuros, respectivamente.
*        Este coste es independiente de la cantidad producida/vendida
                                 - sum(r,d_refineria(r)*coste_fijo(r)*millon)
                                 - sum((r, m), d_penalizacion_refineria_pais(r,m)*penalizacion);

Model  fase2 /obj, r_demanda, b_venta,
              r_max_refineria, i_transportado,
              r_min_mercado, r_max_mercado, i_refineria_mercado,
              r_max_suministrador, r_min_refineria_suministrador, r_max_refineria_suministrador, r_refineria_suministrador, r_transporte_refineria_suministrador,
              r_min_compra2, r_max_compra2,
              r_compra_min_porcentaje, r_compra_max_porcentaje,
              b_refineria_penalizada, b_venta_producto_mercado,
              r_max_porcentaje_refineria,
              f_objectivo_nueva/;
Solve fase2 using MIP maximizing z2;
