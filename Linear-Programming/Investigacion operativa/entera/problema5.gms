* El organismo de promoción de la ciencia en España
* debe seleccionar los proyectos de I+D a los que va a subvencionar
* en los próximos 2 años.

* La siguiente tabla muestra las solucitudes recibidas.
* Para cada solicitud se indica la valoración obtenida
* por el panel de expertos, el área de investigación,
* el presupuesto solicitado para cada una de las dos anualidades
* (en miles de euros) y la región geográfica
* en la que se desarrollaría el proyecto (numeradas de 1 a 3).

* Proyectos              1     2     3     4     5     6     7     8
* Valoración expertos    65    80    75    100   95    70    90    60
* Área                   inf   inf   inf   mat   mat   mat   fis   fis
* Presupuesto año 1      190   170   160   120   110   200   130   150
* Presupuesto año 2      140   110   170   100   120   200   160   180
* Región                 1     2     3     3     2     1     2     1

* Construir un modelo de optimización lineal que maximice
* la suma de la puntuación total obtenida por los proyectos seleccionados,
* teniendo en cuenta que no se pueden seleccionar más de 6 proyectos,
* debe haber al menos uno por región y área de investigación,
* y el presupuesto máximo financiable es de 590000 euros cada año
* y 1446000 en total, además de las condiciones que se indican a continuación.
* Para ello, utilice las variables binarias X_j que toma el valor 1
* si el proyecto j es seleccionado y 0 en otro caso.

* Si NO se seleccionan el proyecto 8, deben seleccionarse los proyectos 1 y 2:

* Los proyectos de la región 1 son incompatibles entre sí:

* No se pueden financiar proyectos con un presupuesto total superior a 330 euros:


Sets
         a area de investigacion /inf, mat, fis/
         j proyecto de I+D /1*8/
         r region geografica /1*3/
         t 2 anio /1*2/

         pr(j,r) proyecto_region /1.1, 2.2, 3.3, 4.3, 5.2, 6.1, 7.2, 8.1/
         pa(j,a) proyecto_area /1.inf, 2.inf, 3.inf,
                                4.mat, 5.mat, 6.mat,
                                7.fis, 8.fis/
;

Scalars
         max /6/
         presupuesto_anio  /590000/
         presupuesto_total /1446000/
;

Parameters
         valoracion(j)    /1 65,  2 80,  3 75,  4 100,
                           5 95,  6 70,  7 90,  8 60/
         region(j,r)
         area(j,a)
;

region(j,r)=pr(j,r);
area(j,a)=pa(j,a);
display region;
display area;

Table
         presupuesto(j,t) porcentaje de crudo j que tiene la gasolina i
                         1       2
         1               190     140
         2               170     110
         3               160     170
         4               120     100
         5               110     120
         6               200     200
         7               130     160
         8               150     180
;

Free Variables
         z    coste total
;

Binary Variables
         x(j)  toma el valor 1 si el proyecto j es seleccionado y 0 en otro caso.
;

Equations
         obj maximice la suma de la puntuacion total
         r_proyecto no se pueden seleccionar más de 6 proyectos,
         r_presupuesto_anio(t) presupuesto cada año
         r_presupuesto_total presupuesto total
         r_region(r) al menos uno por region
         r_area(a) al menos uno por area
         r1 Si NO se seleccionan el proyecto 8 deben seleccionarse los proyectos 1 y 2:
         r2 Los proyectos de la región 1 son incompatibles entre sí:
         r3(j) No se pueden financiar proyectos con un presupuesto total superior a 330 euros:
;
         obj.. z =e= sum(j,x(j)*valoracion(j));
         r_proyecto.. sum(j,x(j))=l=6;
         r_region(r).. sum(j, region(j,r)*x(j))=g=1;
         r_area(a).. sum(j,area(j,a)*x(j))=g=1;
         r_presupuesto_anio(t).. sum(j,x(j)*presupuesto(j,t)*1000)=l=presupuesto_anio;
         r_presupuesto_total.. sum(j, sum(t,x(j)*presupuesto(j,t)*1000))=l=presupuesto_total;
         r1.. -1*x('1')-1*x('2')-2*x('8')=l=-2;
         r2.. sum(pr(j,'1'), x(j))=l=1;
         r3(j).. sum(t,x(j)*presupuesto(j,t))=l=330;



* coding area
option optcr = 0.001
Model  ex1 /All/;
Solve ex1 using MIP maximizing z;
