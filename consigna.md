# PROYECTO INTEGRADOR - Sintaxis y Semántica de los Lenguajes

## Características del lenguaje

1. Un programa está compuesto por una sección de declaración de variables y un cuerpo.
2. Existen dos tipos de variables: reales y cadenas de caracteres. Todas las variables deben ser declaradas. Las
   cadenas pueden contener hasta 1000 caracteres.
3. El cuerpo es una secuencia de sentencias entre algún tipo de separadores, ya sean palabras reservadas (como
   begin y end u otras) o símbolos (como llaves u otros).
4. Una sentencia puede ser una asignación, una lectura, una escritura, un Si-Entonces-Sino o un ciclo tipo
   Mientras.
5. El lado derecho de una asignación puede ser una expresión aritmética sobre números reales, que incluye suma,
   resta, producto, división, potencia y raíz. Se deben definir prioridades entre los operadores y su asociatividad
   debe ser por izquierda. También puede ser una operación sobre cadenas, que puede incluir: concatenación
   (+), extracción de subcadena (subcadena(s, inicio, longitud)), búsqueda de una subcadena dentro de otra
   (buscar(s1, s2) devuelve posición o -1) y obtención de longitud (longitud(s)). También se permiten constantes
   cadena. Las cadenas pueden ocupar más de una línea. Se permitirá el uso de paréntesis.
6. Una lectura contiene una cadena que se mostrará por pantalla y la variable a leer (puede ser real o cadena).
7. Una escritura contiene una lista de una o más cadenas constantes, expresiones aritméticas o variables de tipo
   cadena.
8. Las condiciones del Mientras y el Si deben permitir operadores relacionales y lógicos. Los operadores
   relacionales podrán comparar valores reales o cadenas.

## Actividades a realizar

1. Elegir un nombre para su lenguaje.
2. Definición de la sintaxis mediante la CFG correspondiente.
3. Definición de los componentes léxicos (terminales de la CFG) mediante expresiones regulares (cuando su
   estructura lo justifique)
4. Autómatas determinísticos para los componentes léxicos complejos.
5. Especificación de la semántica asociada a cada variable de la CFG.
6. Construcción del Intérprete:
   1. Analizador Léxico.
   2. Analizador Sintáctico.
   3. Evaluador (ejecuta el programa, en base al árbol de análisis sintáctico).
7. Escriba un programa que lea una cadena y cuente cuántas vocales contiene. El resultado debe mostrarse por
   pantalla. El programa debe recorrer la cadena carácter por carácter.
8. Escriba un programa que lea una cadena y determine si es un palíndromo. El resultado debe ser una cadena
   que diga "Es palíndromo" o "No es palíndromo".
9. Escribir otro programa definido por el grupo. Escribir el enunciado, programar la solución y realizar pruebas.

## Entregables

1. Documentación del programa: qué hace y cómo se usa.
2. Definición formal de la sintaxis mediante una gramática en notación BNF.
3. Gramática modificada LL(1) y TAS.
4. Descripción de la semántica asociada.
5. Programas fuente.
6. Programas escritos en este nuevo lenguaje, correspondientes a los puntos 7, 8 y 9 de las actividades a realizar.
