
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

Procedure iniciarpila(Var pila: t_pila; raiz: t_arbol_derivacion);
Procedure apilar(Var pila: t_pila; elem: TipoSimbGramCom; dir:
                 t_arbol_derivacion);
Procedure desapilar(Var pila: t_pila; Var elem: t_elem_Pila);

Implementation

Procedure iniciarpila(Var pila: t_pila; raiz: t_arbol_derivacion);
Begin
  pila.elem[1].simb := Pesos;
  pila.elem[2].simb := Programa;
  pila.elem[2].nodo := raiz;
  pila.tope := 2;
End;

Procedure apilar(Var pila: t_pila; elem: TipoSimbGramCom; dir:
                 t_arbol_derivacion);
Begin
  inc(pila.tope);
  pila.elem[pila.tope].simb := elem;
  pila.elem[pila.tope].nodo := dir;
End;

Procedure desapilar(Var pila: t_pila; Var elem: t_elem_Pila);
Begin
  elem := pila.elem[pila.tope];
  Dec(pila.tope);
End;

End.
