* Un técnico de sistemas del laboratorio de cálculo de la
* Escuela de Informática quiere acceder a cinco archivos distintos.
* Hay copia de estos archivos en distintas cintas de backup:

* ficheros        CINTAS
* f1        C1, C2, C3, C4, C5, C9,
* f2        C1, C5, C6, C7,
* f3        C1, C3, C4, C5,
* f4        C1, C2, C5, C8, C9, C10,
* f5        C1, C3, C4, C6, C10,

* Los tamañosos de las cintas de backup C1,...,C10 son:
* (16, 36, 24, 50, 52, 52, 42, 18, 50, 35).

* Para poder recuperar los archivos,
* primero hay que hacer un volcado de las cintas al disco duro.
* Este tiene que ser de la cinta completa,
* no puede copiarse sólo una parte.
* Para determinar el conjunto de cintas a volcar de forma
* que se ocupe el menor espacio de disco posible
* y se puedan recuperar todos los archivos se puede plantear
* un problema de programación lineal utilizando las variables xi ,
* que toman el valor 1 si la cinta i es seleccionada y 0 en otro caso,
* con i=1,…,10.
* Completar adecuadamente el model matemático y resolverlo.
* Nota: para resolver el modelo utilizando GAMS
* es recomendable ajustar la holgura de optimalidad
* (máxima diferencia admitida entre la solución propuesta
* y la mejor cota conocida) que por defecto está en el 5%.
* Para ello, para fijarla, por ejemplo,
* en el 0.1% deberá añadirse antes de la sentencia solve...
* la sentencia option optcr = 0.001


Sets
         i cinta /C1*C10/
         j fichero /f1*f5/
;

Parameters
         tamano(i) /C1  16, C2  36, C3  24, C4  50, C5  52,
                    C6  52, C7  42, C8  18, C9  50, C10 35/
;

Table
         recubrimiento(i,j)
                 f1      f2      f3      f4      f5
         C1      1       1       1       1       1
         C2      1                       1
         C3      1               1               1
         C4      1               1               1
         C5      1       1       1       1
         C6              1                       1
         C7              1
         C8                              1
         C9      1                       1
         C10                             1       1
;

display recubrimiento;

Free Variables
         z    espacio final
;

Binary Variables
         x(i) toman el valor 1 si la cinta i es seleccionada y 0 en otro caso con i=1...10.
;

Equations
         obj menor espacio de disco posible
         r_recubrimiento(j) se puedan recuperar todos los archivos
;
         obj.. z=e=sum(i, x(i)*tamano(i));
         r_recubrimiento(j).. sum(i,recubrimiento(i,j)*x(i))=g=1;


* coding area
option optcr = 0.001
Model  ex1 /All/;
Solve ex1 using MIP minimizing z;
