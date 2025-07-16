
Program analizadorSint;

Uses unitInitTAS;

Type 

  t_elem_Pila = Record
    simb: t_simbolo_gramatical;
    nodo: t_arbol_derivacion;
  End;
  t_pila = Record
    elem: array [1..maxPila] Of t_elem_Pila;
    tope: word;
  End;

  t_arbol_derivacion = ^t_nodo_arbol;
  t_nodo_arbol = Record
    simbolo: t_simbolo_gramatical;
    Lexema: string;
    Hijos: array[1..max] Of t_arbol_derivacion;
    cant: byte;
    // cantidad de hijos.

  End;

Var 
  TAS: tipo_TAS;
  i: byte;
Begin
  initTAS(TAS);

  For i:= 1 To TAS[Exp3,Tid]^.cant Do
    writeln(TAS[Exp3,Tid]^.elem[i]);

End.
