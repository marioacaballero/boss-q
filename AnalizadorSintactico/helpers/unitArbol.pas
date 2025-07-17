
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

Procedure iniciarArbol (Var raiz: t_arbol_derivacion);
Procedure agregarDerivacion (Var raiz: t_arbol_derivacion; dir:
                             t_arbol_derivacion; i: byte);
Procedure Mostrar_arbol (Var arbol:t_arbol_derivacion);
Procedure crearNodo(Var dir: t_arbol_derivacion; elem: TipoSimbGramCom);
Procedure guardarArbol(Var ar:text; Var raiz: t_arbol_derivacion; Desplazamiento
                       :integer);

Implementation

Procedure iniciarArbol (Var raiz: t_arbol_derivacion);
Begin
  New(raiz);
  raiz^.simbolo := Programa;
  raiz^.Lexema := '';
  raiz^.cant := 0;
End;

Procedure crearNodo(Var dir: t_arbol_derivacion; elem: TipoSimbGramCom);

Begin
  New(dir);
  dir^.simbolo := elem;
  dir^.Lexema := '';
  dir^.cant := 0;
End;

Procedure agregarDerivacion (Var raiz: t_arbol_derivacion; dir:
                             t_arbol_derivacion; i: byte);
Begin
  raiz^.Hijos[i] := dir;
  inc(raiz^.cant);
End;

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
