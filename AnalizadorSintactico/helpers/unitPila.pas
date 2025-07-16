
Unit unitPila;

Interface

{$unitPath ./}

Uses 

unitInitTAS, unitArbol;

Const 
  maxPila = 200;

Type 
  t_elem_Pila = Record
    simb: TipoSimbGramCom;
    nodo: t_arbol_derivacion;
  End;
  t_pila = Record
    elem: array [1..maxPila] Of t_elem_Pila;
    tope: word;
  End;

Procedure iniciarpila(Var pila: t_pila);
Procedure apilar(Var pila: t_pila; elem: TipoSimbGramCom);
Procedure desapilar(Var pila: t_pila; Var elem: TipoSimbGramCom);

Implementation

Procedure iniciarpila(Var pila: t_pila);
Begin
  pila.elem[1].simb := Pesos;
  pila.elem[2].simb := Programa;
  pila.tope := 2;
End;

Procedure apilar(Var pila: t_pila; elem: TipoSimbGramCom);
Begin
  inc(pila.tope);
  pila.elem[pila.tope].simb := elem;
End;

Procedure desapilar(Var pila: t_pila; Var elem: TipoSimbGramCom);
Begin
  elem := pila.elem[pila.tope].simb;
  Dec(pila.tope);
End;

End.
