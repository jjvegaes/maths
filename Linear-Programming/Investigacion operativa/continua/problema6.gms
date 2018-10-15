* En una zona industrial hay tres factorías, F1, F2 y F3.
* Los residuos de su producción contienen dos tipos de contaminantes: C1 y C2.
* El impacto contaminante de las factorías se puede reducir procesando los residuos.
* Los costes de procesar una tonelada de residuos
* y la reducción de emisión de contaminantes
* obtenida para cada una de las tres plantas son los siguientes:

* Planta        Coste        Reducción (ton)
* (euros)        C1        C2
* F1        14        0.44        0.28
* F2        18        0.42        0.49
* F3        12        0.29        0.54
* Por ejemplo, procesar una tonelada de residuos en la factoría F1 cuesta 14 euros,
* pero reduce en 0.44 y 0.28 toneladas la emisión de los contaminantes C1 y C2,
* respectivamente. Las autoridades locales desean reducir los vertidos de C1 y de C2 en
* al menos 52 y 59 toneladas, respectivamente.
* Nota: la tolerancia admitida en las respuestas es 1.

Sets
         i factoria              /F1, F2, F3/
         j contaminante          /C1, C2/
;

Parameters
         coste(i) coste de la reduccion de emision de contaminante en factoria i
                 / F1     14
                   F2     18
                   F3     12/

         demanda(j) minimos reducidos de contaminantes en tonelada
                 / C1     52
                   C2     59/
;

Table
         reduccion(i, j) porcentaje de la reduccion
                  C1      C2
         F1       0.44    0.28
         F2       0.42    0.49
         F3       0.29    0.54
;

Free Variables
         z        cantidad de coste
;

Positive Variables
         x(i)     toneladas de residuos procesados en factoria i
;

Equations
         obj
         r_demanda(j)
;
         obj.. z=e=sum(i, coste(i) * x(i));
         r_demanda(j).. sum(i, x(i) * reduccion(i, j))=g=demanda(j);

* coding area
Model  ex1 /All/;
Solve ex1 using LP minimizing z;
