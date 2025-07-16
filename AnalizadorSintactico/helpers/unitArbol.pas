
Unit unitArbol;

Interface

{$unitPath ./}

Uses 
unitInitTAS;

Type 
  t_arbol_derivacion = ^t_nodo_arbol;
  t_nodo_arbol = Record
    simbolo: TipoSimbGramCom;
    Lexema: string;
    Hijos: array[1..maxProduccion] Of t_arbol_derivacion;
    cant: byte;
    // cantidad de hijos.

  End;

Implementation

Procedure Mostrar_arbol (Var arbol:t_arbol_derivacion);

Var i: integer;
Begin
  writeln(arbol^.simbolo) ;
  For i:=1 To arbol^.cant Do
    Begin
      Mostrar_arbol(arbol^.hijos[i]);
    End;
End;

Procedure guardarArbol(Var ar:text; Var raiz: t_arbol_derivacion; Desplazamiento
                       :integer);

Var i : integer;
Begin
  Writeln(ar, '':desplazamiento,raiz^.simbolo,': ',raiz^.lexema);
  For i:=1 To raiz^.cant Do
    Begin
      guardarArbol(ar,raiz^.hijos[i],Desplazamiento+2);
    End;

End;

End.
