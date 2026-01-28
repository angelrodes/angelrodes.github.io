Introducción a Matlab y Octave
=======================================

Programación orientada a matrices
------------------------------------------

### Programación orientada a matrices

- MATLAB y Octave se presentan como “MATrix LABoratories” (laboratorios de matrices), usados
habitualmente para representar funciones y datos, implementar
algoritmos, crear interfaces de usuario e interaccionar con
programas escritos en otros lenguajes.
- MATLAB es un lenguaje de programación propietario desarrollado por
MathWorks, Inc. GNU Octave es software libre bajo los términos de la
Licencia Pública General de GNU.
- MATLAB y Octave usan lenguajes que son mayormente compatibles (lenguaje M). En
este curso utilizaremos sintaxis compatibles con ambos programas, a
menos que se indique lo contrario.

¿Por qué MATLAB/Octave?
--------------------------------

### MATLAB y/o Octave te permitirán:

- Gestionar grandes conjuntos de datos (datos brutos, resultados
sintéticos, mapas, etc.).
- Realizar cálculos iterativos.
- Escribir cálculos autoexplicativos y compartirlos con la comunidad
científica (es decir, adecuados para ser incluidos en publicaciones
científicas).
- Representar exactamente lo que quieras.
- Aprender un lenguaje de programación que es sencillo.
- Aprender a programar en MATLAB/Octave hace que otros lenguajes sean
mucho más fáciles de aprender: Matlab/Octave son similares a R,
Python, C++, etc.
- Resolver tus propios problemas usando tus propios programas,
adaptándolos exactamente a tus necesidades.

La interfaz
--------------------

### La interfaz

Matlab y Octave tienen interfaces muy similares que contienen, al
menos, los siguientes elementos:

- Barra de direcciones
- Navegador
- Ventana de comandos
- Workspace
- Editor

![Interfaz de MATLAB.](https://user-images.githubusercontent.com/53089531/131697223-d3c2c5a2-9d82-4615-aa81-8b651960de51.png)

![GUI de Octave.](https://user-images.githubusercontent.com/53089531/131697391-891bde25-1e05-429f-9ff7-d25f78631ba8.png)

**La ventana de comandos** es el **cerebro** del programa. Puedes
usarla como una simple calculadora o para llamar funciones o scripts.
En última instancia, ¡este es el único elemento que necesitas para
usar Matlab u Octave!

Prueba a escribir los siguientes comandos y pulsa intro:

- `97+6`
- `23-36`
- `23-6*6`
- `(23-6)*6`
- `12742*pi`
- `3^2`
- `sqrt(2)`
- `log(100)`
- `log10(100)`

*Para limpiar la ventana de comandos, usa el comando `clc`. \
Como en la mayoría de interfaces de consola, la ventana de comandos
tiene memoria: prueba a usar la tecla de flecha hacia arriba.*

### Directorio actual y navegador

Cuando quieras interactuar con archivos (por ejemplo, llamar tus
propios scripts o crear archivos con tus resultados o gráficas),
necesitas saber **dónde** estás trabajando. Por tanto, asegúrate de que
la dirección que ves en la parte superior de la pantalla es la carpeta
en la que quieres trabajar. Puedes ver, crear, borrar o abrir tus
archivos usando el navegador de tu sistema (explorer, finder, nautilus,
etc.) o el navegador integrado en Matlab u Octave.

*Crea un nuevo archivo llamado* **mi_primer_script.m**.

Evita usar espacios, la mayoría de símbolos o empezar con números
cuando pongas nombres a tus archivos. **En lugar de espacios, usa el
guion bajo (_).**

*Además, ten en cuenta que los archivos de Matlab siempre terminan en*
`.m`

### El editor

Este es simplemente un editor de texto básico. Los archivos que puedes
editar no contienen ninguna información de formato. Puedes abrir estos
archivos con cualquier editor de texto (por ejemplo, el bloc de notas).
Sin embargo, el editor integrado formatea el texto para resaltar el
significado del texto en el lenguaje de Matlab.

Abre `mi_primer_script.m` y escribe:

```Matlab
% Este es mi primer script.
disp(’Hola mundo’)
```

luego ejecútalo usando el comando `mi_primer_script` (sin `.m`) en la
ventana de comandos, o seleccionando **run** en el menú.

### Workspace

Esta es la *memoria* de Matlab/Octave. La última respuesta dada en la
ventana de comandos suele almacenarse como `ans`.

*Escribe `x=3+2` en la ventana de comandos.*

*El parámetro `x` aparecerá en el Workspace.*

Usa el comando `who` o `whos` para mostrar un resumen del workspace en
la ventana de comandos, y el comando `clear` para eliminar todos los
parámetros del workspace.

¿Qué podemos poner en el Workspace?
-------------------------------------------

### Parámetros con un solo número

- `mass=12`
- `C14halflife=5730;`
- `avogadro=6.022*10^23`

*Al igual que para los nombres de archivo, evita usar espacios, la
mayoría de símbolos o empezar los nombres de parámetros con números.
Terminar con punto y coma (`;`) evita que la salida se muestre en la
ventana de comandos, aunque el parámetro se almacena en memoria. Puedes
comprobar que el valor de C14halflife está en memoria escribiendo
`C14halflife` en la ventana de comandos.*

Otros valores “especiales” aceptados:

- `maxtime=Inf`
- `mintime=-Inf`
- `unknownvalue=NaN`

*`Inf` significa “Infinito” y `NaN` significa “Not a Number” (no es un número). También
puedes generarlos calculando `1/0` o `0/0` en la ventana de comandos.*

### Array de números

- `data=[254,782,65,5]`
- `moredata=[23;36;47]`
- `a=1:20`
- `a=1:0.25:10`
- `odds=1:2:100`
- `pairs=2:2:100`
- `emptyarray=[]`

Usa `length(data)` para comprobar el tamaño de tu array.

*Prueba también `linspace(0,3,20)` y `logspace(0,2,5)` para obtener
números igualmente espaciados en el espacio lineal o logarítmico.
Usa `odds'` si lo quieres como columna.
Accede a un único valor (`data(3)` o `data(end)`) o a varios valores de
un array (`a(7:10)`).*

### Matrices

- `A=[1,2,3 ; 4,5,6 ; 7,8,9]`
- `B=[99,88,77 ; 66,55,44 ; 33,22,11]`
- `C=ones(4,3) % número de líneas,columnas`
- `D=zeros(4,3)`

*Ten en cuenta que cualquier cosa que escribas después del símbolo `%`
se ignora. **`%` se usa para comentarios.***

También puedes crear una matriz repitiendo un array usando `repmat`:

`repmat(data,3,1)`

Usa `help repmat` para saber más sobre esto.

Estas matrices son 2-D (filas y columnas). Sin embargo, MATLAB y Octave
también pueden manejar matrices en múltiples dimensiones. Por ejemplo,
`ones(3,2,5)` es una matriz 3-D.

Usa `size(B)` para comprobar el tamaño de tu matriz (filas y columnas),
o `numel(B)` para obtener el número de elementos en `B`.

### Cadenas (strings)

Las cadenas son parámetros que contienen texto:

- `name='John'`
- `students={'Gerry','Trish','Pablo'}`

Las cadenas son útiles cuando se trabaja con nombres de muestras o de
localizaciones. MATLAB y Octave pueden manejar cadenas y proporcionan
potentes herramientas para manipular y operar con texto, como
[expresiones regulares](https://es.mathworks.com/help/matlab/matlab_prog/regular-expressions.html) ([lenguaje Regex](https://es.wikipedia.org/wiki/Expresi%C3%B3n_regular)). Sin embargo, MATLAB y Octave no
fueron diseñados principalmente para trabajar con texto, y la
manipulación de cadenas puede ser muy frustrante al principio. Por lo
tanto, restringiremos el uso de texto a nombres de muestras o etiquetas
sencillas.

*A veces será útil encontrar una muestra en una lista. Por ejemplo, usa
`strcmp` para encontrar la posición de la estudiante llamada Trish*:
`strcmp('Trish',students)`

### Funciones pequeñas

Las fórmulas simples se pueden definir usando parámetros con
@(parámetros):

- `temp_fahrenheit = @(temp_celsius)1.8 * temp_celsius + 32`
- `meters=@(ft)ft/3.2808`
- `decay=@(halflife,time)exp(-log(2)/halflife*time)`

*Prueba `temp_fahrenheit(15)` y `decay(C14halflife,20000)`*

### Datos booleanos

Los datos booleanos son un tipo de datos que solo pueden tomar dos
valores posibles: verdadero (1) o falso (0). En MATLAB, los valores
lógicos suelen generarse usando igualdades o desigualdades:

- `avogadro>1E23`
- `mass==12`
- `odds<10`
- `odds(odds<10)`
- `A>5`
- `isinf(maxtime)`
- `isnan(B)`
- `isprime(7537)`

*Ten en cuenta que `==` y `~=` se usan en MATLAB para determinar
igualdad o desigualdad, y `=` para definir un parámetro.*

Podemos combinar datos booleanos usando operadores booleanos: `&` (y) y
`|` (o). 

Por ejemplo, `( A<5 | B<30 )`. 

Los datos booleanos también pueden usarse como índices si el array o
matriz booleana tiene el mismo tamaño que el array o matriz objetivo.

Por ejemplo, `A(A>5)` o `B(A<3)` pero no `data(A<10)`.

Esta propiedad es útil para crear fácilmente filtros para nuestros
datos:

`data(data>50 & data<500)`

*`clc` para limpiar la ventana de comandos*

### Cálculos básicos

Con números: `mass*avogadro`

Con arrays y matrices: `odds+pairs` pero `odds.*pairs`

Observa la diferencia entre `B/A` y `B./A`:

"`.*`", "`./`" y "`.^`" son operadores usados para realizar cálculos
elemento a elemento (operaciones de array). Evita usar "`*`", "`/`" y
"`^`" sobre matrices a menos que realmente quieras hacer operaciones
matriciales siguiendo las reglas del álgebra lineal.

Llamar a partes de otra variable: puedes acceder al número en la segunda
fila y tercera columna con `A(2,3)`, a la segunda fila con `B(2,:)` o a
la primera columna con `A(:,1)`. MATLAB y Octave siguen siempre el orden
(**fila,columna**) en matrices 2D.

### Números aleatorios

- `rand` % número aleatorio entre 0 y 1
- `rand(1,10)` % una fila de 10 números aleatorios
- `rand(10,1)` % una columna de 10 números aleatorios
- `rand(3,3)` % una matriz de 3x3 con números aleatorios entre 0 y 1
- `A.*rand(3,3)` % una matriz de 3x3 con números aleatorios entre 0 y los valores de la matriz A
- `normrnd(11000,2000)` % número aleatorio de una distribución de probabilidad gaussiana de 11000±2000
- `normrnd(11000,2000,1,5000)` % una fila de 5000 números aleatorios de una distribución de probabilidad gaussiana de 11000±2000

*Prueba `hist(normrnd(11000,2000,1,5000))` y `hist(rand(1,5000))` para
representar los histogramas correspondientes a estas distribuciones
aleatorias.*

Gráficas
-----------------

### Presión atmosférica

Definamos una función que calcula la presión a una cierta altitud:

```Matlab
    pressure = @(altitude)1013.25*...
     exp(-0.03417/0.0065*(log(288.15)-...
     (log(288.15-0.0065*altitude))))
     % standard atmosphere pressure (Lide, 1999)
```

*Ten en cuenta que podemos usar tres puntos (`...`) para evitar líneas
largas.*

Después define valores `x` entre 0 (nivel del mar) y 8848 m (Everest)
cada 100 m:

`x=0:100:8848`

Y calcula sus presiones correspondientes:

`y=pressure(x)`

### Gráficas simples

Prueba las siguientes gráficas:

- `plot(x,y)`
- `plot(x,y,'r-')`
- `plot(x,y,'ob')`
- `plot(x,y,'-k')`
- `plot(x,y,'-g','LineWidth',2)`
- `bar(x,y)`
- `stairs(x,y)`

### Figura

Crea una figura y representa varias cosas en ella:

```Matlab
    figure % abre una nueva figura
    hold on % no borrar nada mientras añadimos elementos
    plot(x,y,'-b')
    plot(243,pressure(243),'hr')
    text(243,pressure(243),'Zaragoza')
    xlabel('Altitud')
    ylabel('Presión')
    title('Mi primer gráfico con etiquetas')
```

Haz el eje y logarítmico: `set(gca, 'YScale', 'log')` (`gca` significa
“Get current axes”). 

*Puedes exportar tus gráficas usando el menú
**File > Save As** en la ventana de la figura. Exportar tus gráficas
como .eps o .pdf te permitirá editarlas con editores de gráficos
vectoriales como Adobe Illustrator o Inkscape.*

Scripts
----------------

### Scripts

Un script es un archivo de texto con una lista de órdenes. En tu
directorio actual, crea `radiocarbondating.m`. Ábrelo con el editor y
escribe las siguientes órdenes:

```Matlab
    %% Este es un script que calcula edades de radiocarbono y sus errores
    %% Por mí, 2019

    %% Empezar limpiando un poco
    clear % esto elimina cualquier parámetro previo del espacio de trabajo
    clc % esto limpia la ventana de comandos

    %% Definir la fórmula que calcula la edad a partir de las concentraciones    
    C14age=@(modernconcentration,measuredconcentration)-...
    8033*log(measuredconcentration./modernconcentration);

    %% Estos son los datos que tenemos
    modernc=1232;
    errormodernc=13;
    oldc=[567 1100 20 1252];
    erroroldc=[6 20 5 50];

    %% Seleccionar el dato con el que queremos trabajar
    n=1

    %% Crear 1000 datos aleatorios basados en las distribuciones normales
    randommodern=normrnd(modernc,errormodernc,1,1000);
    randomold=normrnd(oldc(n),erroroldc(n),1,1000);

    %% Calcular las edades de las distribuciones
    ages=C14age(randommodern,randomold);

    %% Representar la distribución de edades
    figure
    hold on
    hist(ages)
    title(['Muestra' num2str(n)])
    xlabel('Edad')
    ylabel('Probabilidad')

    %% Calcular la media y la desviación estándar
    age=mean(ages)
    errorage=std(ages)
```

Ahora puedes cambiar el valor de `n` para obtener los resultados de
otros datos.

*Ten en cuenta que podemos crear cadenas compuestas usando corchetes `[]`
y la función `num2str(n)` para convertir números en cadenas.*

*También ten en cuenta que podemos usar `...` para evitar líneas muy
largas.*

Bucles
---------------

### Bucles

A menudo necesitamos ejecutar un bloque de código varias veces. Por
ejemplo, en nuestro programa `radiocarbondating.m` podríamos copiar y
pegar el script 4 veces cambiando `n=1` por `n=2`, `n=3` y `n=4` para
obtener todas nuestras edades calculadas. Sin embargo, evitamos repetir
código escribiendo una sentencia de bucle que ejecute el código varias
veces.

En `radiocarbondating.m`, podemos sustituir “`n=1`” por
“`for n=[1,2,3,4]`” y escribir “`end`” al final del script para realizar
los cálculos y las representaciones de las cuatro muestras.

*La forma básica de un bucle en Matlab es*:

```Matlab
for Parameter=List
% El código que se repite
end
```


### Barras de error

Crea un nuevo script llamado **plot-with-error-bars.m** que use un
bucle para representar barras de error de las concentraciones
individuales:

```Matlab
    %% Este es un script que representa datos con barras de error
    %% Por mí, 2019

    %% Empezar limpiando un poco
    clear % esto elimina cualquier parámetro previo del espacio de trabajo
    clc % esto limpia la ventana de comandos
    close all hidden % cerrar cualquier figura previa

    %% Estos son los datos que tenemos
    data=[567 1100 20 1252 326 625];
    errors=[6 20 5 50 32 100];

    %% Figura
    figure
    hold on
    for n=1:length(data) % iniciar un bucle
      plot(n,data(n),'*b')  % representar los datos
      x=[n,n]; % posiciones x de los extremos de la barra de error
      y=[data(n)-errors(n),data(n)+errors(n)]; % posiciones y
      plot(x,y,'-b') % representar la barra de error
    end % fin del bucle
    xlabel('Muestra')
    ylabel('Concentración')
```

Otra forma de crear un bucle es usar la sentencia *`while`*:

```Matlab
n=0;
while n<10
    n=n+1 % añade 1 al valor de n
end
```

Sentencias condicionales
---------------------------------

### if - end

Las sentencias condicionales nos permiten seleccionar en tiempo de
ejecución qué bloque de código ejecutar. La sentencia condicional más
simple es `if`, cerrada con `end`:

```Matlab
    n=round(rand*100); % aleatorio entre 0 y 100 redondeado al entero más próximo
    if n/2==round(n/2)
      string=[num2str(n) ' es par']
    end
```


### if - elseif - else - end

Podemos definir alternativas usando `if`, `elseif`, `else` y `end`:

```Matlab
    n=round(rand*100);
    if n/2==round(n/2)
      string=[num2str(n) ' is par'];
    elseif isprime(n)
      string=[num2str(n) ' is impar y primo'];
    else
      string=[num2str(n) ' is impar, pero no primo'];
    end
    disp(string) % disp muestra la cadena en la ventana de comandos
```

*También puedes definir sentencias condicionales usando `switch`
(`switch`, `case`, `otherwise` y `end`). \
¡Descubre tú mismo cómo usar
la sentencia `switch` escribiendo `help switch` en la ventana de
comandos!*

Funciones
------------------

### Funciones

Una función es un script que funciona como una “caja negra”. Solo ves
la salida final en el workspace, y no todos los parámetros definidos en la
función. Al escribir una función, o convertir un script en una función,
tenemos que empezar el archivo con

`function OUTPUTS = function_name(INPUTS)`

y escribir

`end`

al final del archivo.

### Función de edad 14C

Crea un archivo llamado **C14agefunction.m** y copia:

```Matlab
    function [age,errorage]=C14agefunction(oldc,erroroldc,modernc,errormodernc)
      C14age=@(modernconcentration,measuredconcentration)-...
        8033.*log(measuredconcentration./modernconcentration);
      randomold=normrnd(oldc,erroroldc,1,10000);
      randommodern=normrnd(modernc,errormodernc,1,10000);
      ages=C14age(randommodern,randomold);
      age=mean(ages);
      errorage=std(ages);
    end
```

*Ten en cuenta que el nombre de la función tiene que ser el mismo que el
nombre del archivo. De lo contrario obtendrás un error al ejecutarla.*

Guarda el archivo y luego ejecuta lo siguiente en la ventana de
comandos:

`C14agefunction(50,10,1254,20)`

`[age,error]=C14agefunction(50,10,1254,20)`

Funciones integradas
-----------------------------

### Funciones integradas

MATLAB y Octave incluyen un gran número de funciones integradas (por
ejemplo, `factorial`, `sin`, `sum`, `diff`, `max`, `magic`, `pi`,
`median`, `chi2pdf`, `interp1`, `contour`, y muchas más).

Puedes aprender cómo usar estas funciones usando `help` (por ejemplo,
`help interp1`), seleccionando el nombre de la función y pulsando F1 en
MATLAB.

Además, puedes descubrir más funciones en internet. Simplemente busca la
operación que quieras hacer, incluyendo “Matlab” u “Octave” en tu
búsqueda o en tu chat de inteligencia artificial generativa favorito.

*Incluso podemos ver cómo están hechas algunas de estas funciones
integradas con `edit`. ¡Prueba `edit magic` para ver el código de la
función que genera cuadrados mágicos!*

### Toolboxes y paquetes

Hay algunas funciones avanzadas, como las usadas para trabajar con
mapas, que no están incluidas en el paquete básico de MATLAB y Octave.
Estos “paquetes especiales” se llaman “toolboxes” en MATLAB y “packages” en Octave.

Las toolboxes se instalan usando el instalador de MATLAB y se cargan
automáticamente cuando inicias MATLAB.

Los paquetes de Octave pueden instalarse usando `pkg install` y el
nombre del archivo donde está el paquete o buscándolas en tu repositorio de linux. Antes de empezar a usar un
paquete de Octave, tenemos que cargarlo con `pkg load package_name`.

Como uno de los objetivos de este curso es aprender a escribir código
que podamos compartir, la mayoría de las funciones integradas que
usartemos en este curso están incluidas en las versiones básicas de
MATLAB y Octave. Si se necesita una toolbox o paquete, se indicará
claramente.

Ejercicio
-------------------

Un glaciar es una masa de hielo denso, persistente, que se mueve
constantemente bajo su propio peso. *(Wikipedia: Glacier)*

![[antarcticglaciers.org](http://www.antarcticglaciers.org)](https://user-images.githubusercontent.com/53089531/132316982-3404632a-455e-4be4-a7e3-c80467a09835.png)

Vamos a estudiar el comportamiento de la nieve y el hielo en Escocia.

Considera las siguientes simplificaciones climáticas:

- Temperatura media mensual (&deg;C) a nivel del mar en Escocia:

| Ene | Feb | Mar | Abr | May | Jun | Jul | Ago | Sep | Oct | Nov | Dic |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     4   | 5   | 7   | 8   | 12  | 14  | 16  | 16  | 13  | 10  | 7   | 5|

- Gradiente térmico vertical: 8 &deg;C/km
- Precipitación mensual (mm) en Escocia:

| Ene | Feb | Mar | Abr | May | Jun | Jul | Ago | Sep | Oct | Nov | Dic |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 175 | 125 | 150 | 100 | 75  | 100 | 100 | 125 | 125 | 175 | 175 | 175 |


Considera el siguiente comportamiento de la nieve/hielo (muy simplificado):

- Toda la precipitación es nieve **cuando la temperatura está por debajo de 5 &deg;C**.
- Toda la precipitación es lluvia por encima de 5 &deg;C.
- El rango diario de temperatura es 5 &deg;C, así que **la temperatura diurna es 2.5 &deg;C por encima de la media**.
- Considerando una conductividad térmica del manto de nieve de ~5
W/K/m², un calor latente de fusión de la nieve de 350 kJ/kg y una
densidad media de la nieve de ~0.3 kg/l, **se derretirán una media de 5 cm de nieve al mes por cada grado de temperatura diurna por encima de 0 &deg;C**.
- Si la nieve sobrevive más de un año (balance de masa anual > 0), la nieve fluirá cuesta abajo a una **velocidad horizontal de 11 pulgadas/día**.
- La **pendiente media del lecho glaciar es de 15&deg;**.

### Balance de masa:

1. Escribe una función que calcule el balance de masa mensual de nieve
(acumulación de nieve – fusión de nieve). *Recuerda que la función de fusión no debe crear nieve.*
2. Escribe una función que calcule la nieve acumulada mensualmente.
*Recuerda que (1) podemos tener nieve heredada del mes anterior, y (2) el espesor del manto de nieve no puede ser negativo.*
3. Escribe un fragmento de código que calcule el balance de masa anual a una altitud dada.
4. Introduce la posibilidad de emular condiciones climáticas pasadas y
futuras cambiando la temperatura y la precipitación de forma
uniforme (ΔT y ΔP).

*La salida de las funciones mensuales debería ser un array de 12 números
cuando la entrada sea una altitud, o una matriz cuando la entrada sea
una “columna” de valores de altitud.*



Acumulación de nieve:

1. Colocando una estación de esquí: ¿cuál es la altitud más baja con 3
o más meses de nieve?
2. Según estos datos, ¿dónde podríamos encontrar un glaciar en Escocia
hoy en día? *Nota: la cumbre más alta de Escocia es Ben Nevis, a
1345 m sobre el nivel del mar.*
3. La zona de esquí de Glenshee se encuentra entre 650 y 1050 m de
altitud. ¿Qué impacto tendrían estos escenarios en el negocio para
2100?

![earthobservatory.nasa.gov](https://user-images.githubusercontent.com/53089531/131722504-35d9efe1-d93d-4188-a911-96baa2ba7bb7.png)

### Ejercicio de modelización glaciar:

Vamos a crear un modelo glaciar de una dimensión, simulando el comportamiento de la nieve y hielo a lo largo de una línea desde el nivel del mar hasta una altura aproximada de 1345 m (Ben Nevis).

1. Escribe un fragmento de código que emule el flujo anual de masa
nieve/hielo. *Pista: calcula cuánto se mueve verticalmente la
nieve/hielo en un año y discretiza la referencia de altitud en
consecuencia, de forma que la nieve acumulada durante el año
anterior se desplace una posición por año.*
2. Escribe un script que ejecute el código anterior hasta que el
espesor de nieve/hielo sea estable.
3. Según este modelo, ¿dónde deberían haber estado los frentes
glaciares durante el Younger Dryas (ΔT=-4 &deg;C)? ¿Y durante el último máximo glaciar (ΔT=-6 &deg;C)?


Puedes generar un gráfico como este:

![untitled](https://github.com/user-attachments/assets/3507bff7-4c55-437a-87ee-500b8f5966ef)

*Ejercicio resuelto [aquí](https://raw.githubusercontent.com/angelrodes/angelrodes.github.io/refs/heads/main/Matlab_UAB/Ejercicio_1_resuelto.m)*


