# Boss-Q

boss-q es un lenguaje imperativo sencillo con tipado estático que acepta variables de tipo string y float. Los programas escritos en boss-q se dividen en una sección de declaración de variables y un bloque de sentencias delimitado por los símbolos { }.
Es adecuado para aprender estructuras básicas de programación imperativa, integrando manipulación de cadenas y cálculos numéricos de manera clara y expresiva.

## Uso básico:

  ### Escribir el programa

  - Guardar el código en un archivo con extensión .bqs, por ejemplo “miPrograma.bqs”.
  - Estructura mínima:

  ```
      program miPrograma;
     {};
  ```

  ### Compilar/interpretar

  - Desde la línea de comandos:

  ```
  .\bossQ miPrograma.bqs
  ```

  - El intérprete mostrará prompts para cada read y mostrará salida por cada write.

  ### Ejemplos

  - Se pueden encontrar dentro de la carpeta programa.

## Secciones del programa

  ### Declaración de variables

  - Solo dos tipos: Float y String.
  - Todas las variables deben aparecer en esta sección para definir su tipo..
  - Las cadenas (String) pueden tener hasta 1000 caracteres.
  - Las constantes de cadena se toman encerrando su valor entre comilla doble (“). Por ejemplo, “hola mundo”.

  ### Cuerpo de sentencias

  - Encerrado entre llaves { … }
  - Contiene una secuencia de sentencias, separadas por punto y coma ;

  ### Tipos de sentencias

    #### Asignación

    __id := <expresión>;__

    - El lado derecho puede ser:
    - Expresión aritmética sobre Float (soporta +, -, *, /, ^ (potencia), con precedencias y asociatividad izquierda definidas).

    #### Operación de cadenas:

    Concatenación: s1 + s2
    
     - Subcadena: __substr(s, inicio, final)__
     - Búsqueda: __find(s1, s2)__ → devuelve posición si se encontró o -1
     - Longitud: __long(s)__

    #### Lectura

    __read("Mensaje: ", id);__
    
    - Muestra la cadena literal al usuario y asigna a id el valor ingresado (sea Float o String).
    
    #### Escritura
    
    __write(expr1, expr2, ...);__
    
    - Imprime en consola cadenas, valores numéricos o variables de tipo cadena.
    
    #### Condicional

    __if <condición> {__
    __} else {__
    __};__
    
    _ Si la sentencia del else no se usa se puede eliminar y agregar el ; al final del cuerpo del “if”.
    
    #### Ciclo “Mientras”
    
    __while <condición> {__
    __};__
    
    - Evalúa la condición antes de cada iteración.

    #### Ciclo “Para”

  ## Operadores relacionales disponibles

  - Todos son aplicables a variables de tipo float o string.

  - [x] =
  - [x] !=
  - [x] <
  - [x] <=
  - [x] >= 

 ## Operadores lógicos

 - Aplicables para resultados de los operadores relacionales.

 - [x] & (and)
 - [x] | (or)
 - [x] ! (not)

## Errores comunes

- Uso de variable no declarada.
- Incompatibilidad de tipos en asignaciones o expresiones.
- Inconsistencia con la sintaxis, por ejemplo, la falta de un “;”

