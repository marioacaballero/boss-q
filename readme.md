# Boss-Q

<p align="center">
  <img src="logo.png" img src="img/logo.png" width="50%">
</p>

Boss-Q es un lenguaje imperativo sencillo con tipado estático que acepta variables de tipo string y float. 

Los programas escritos en __boss-q__ se dividen en una sección de declaración de variables y un bloque de sentencias delimitado por { }.

Es un lenguaje adecuado para aprender estructuras básicas de programación imperativa, integrando manipulación de cadenas y cálculos numéricos de manera clara y expresiva.

## Uso básico:

  ### Escribir el programa

  - Guardar el código en un archivo con extensión .bqs, por ejemplo “miPrograma.bqs”.
  - Estructura mínima:

  ```
      program miPrograma;
       {};
  ```

  ### Compilar/interpretar

  Desde la línea de comandos:

  ```
  .\bossQ miPrograma.bqs
  ```

  El intérprete mostrará prompts para cada read y mostrará salida por cada write.

  ### Ejemplos

  Se pueden encontrar dentro de la carpeta [programa](https://github.com/marioacaballero/boss-q/tree/master/programa).

## Secciones del programa

  ### Declaración de variables

  - Solo dos tipos: float y string.
  - Todas las variables deben aparecer en esta sección para definir su tipo.
  - Las cadenas (string) pueden tener hasta 1000 caracteres.
  - Las constantes de cadena se toman encerrando su valor entre comilla doble (“). Por ejemplo, “hola mundo”.

  ### Cuerpo de sentencias

  - Encerrado entre llaves { … }
  - Contiene una secuencia de sentencias, separadas por punto y coma ;

  ### Tipos de sentencias

   #### Asignación

     id := <expresión>;

   - El lado derecho puede ser:
   - Expresión aritmética sobre float (soporta +, -, *, /, ^ (potencia), con precedencias y asociatividad izquierda definidas).

   #### Operación de cadenas:

   Concatenación: s1 + s2
    
   ##### Subcadena 
   
     substr(s, inicio, final)
     
   #### Búsqueda
     
     find(s1, s2)
   
   Devuelve posición si se encontró o -1
  
   #### Longitud
   
     long(s)

   #### Lectura

     read("Mensaje: ", id);
    
   Muestra la cadena literal al usuario y asigna a id el valor ingresado (sea Float o String).
    
   #### Escritura
    
     write(expr1, expr2, ...);
    
   Imprime en consola cadenas, valores numéricos o variables de tipo cadena.
    
   #### Condicional

     if <condición> {
     } else {
     };
    
   Si la sentencia del else no se usa se puede eliminar y agregar el ; al final del cuerpo del “if”.
    
   #### Ciclo “Mientras”
    
     while <condición> {
     };
    
   Evalúa la condición antes de cada iteración.

   
  ## Operadores relacionales disponibles

  Todos son aplicables a variables de tipo float o string.

  - [x] =
  - [x] !=
  - [x] <
  - [x] <=
  - [x] >= 

 ## Operadores lógicos

 Aplicables para resultados de los operadores relacionales.

 - [x] & (and)
 - [x] | (or)
 - [x] ! (not)

## Errores comunes

- Uso de variable no declarada.
- Uso de caracter inválido.
- Incompatibilidad de tipos en asignaciones o expresiones.
- Inconsistencia con la sintaxis, por ejemplo, la falta de un “;” .

