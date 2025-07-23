
Unit evaluador;


Interface

{$unitPath ../AnalizadorSintactico/helpers}

Uses 
unitInitTAS, unitArbol;

Const 
  maxvar = 200;

Type 
  t_elem_estado = Record
    lexemaId: String;
    valreal: Real;
    t_typo: TipoSimbGramCom;
    valcadena: String;
  End;

  t_estado = Record
    elem: array[1..maxvar] Of t_elem_estado;
    cant: word;
  End;

Procedure evalPrograma(Var arbol: t_arbol_derivacion);
Procedure evalBloqueVar(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalListaDefVar(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalListaDefVar2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalDefVar(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalTypo(Var arbol: t_arbol_derivacion; Var state: t_estado; Var tipo:
                   TipoSimbGramCom);
Procedure evalCuerpo(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalSentencia(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalAsignacion(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalExp(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalExp5(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalExp2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalExp6(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalExp3(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalExp7(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalExp4(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCiclica(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCondicional(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCondicional2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCond(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCond4(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCond2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCond5(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCond3(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalLectura(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalEscritura(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalListaExp(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalListaExp2(Var arbol: t_arbol_derivacion; Var state: t_estado);

Implementation

Procedure inicializarEstado(Var state: t_estado);
Begin
  state.cant := 0;
End;

Procedure AgregarEstado(Var state: t_estado ; X: t_elem_estado);
Begin
  state.cant := state.cant + 1;
  state.elem[state.cant] := X;
End;

Procedure CrearVariable(lexema: String; Var state: t_estado; tipo :
                        TipoSimbGramCom);

Var X: t_elem_estado;
Begin
  X.lexemaId := lexema;
  X.t_typo := tipo;
  X.valcadena := '';
  X.valreal := 0;
  AgregarEstado(state,X);
End;

Procedure asignarValor(lexema:String; Var state: t_estado; valor:real; valorCad:
                       String);

Var 
  i: integer;
Begin
  For i:=1 To state.cant Do
    Begin
      If state.elem[i].lexemaid = lexema Then
        Begin
          If state.elem[i].tipo = TFloat Then
            state.elem[i].valreal := valor
          Else
            state.elem[i].valcadena := valorCad;
        End;
    End;

End;

// <Programa> ::= "program" "id" ";" <BloqueVar> "{" <Cuerpo> "}"
Procedure evalPrograma(Var arbol: t_arbol_derivacion);

Var state: t_estado;
Begin
  inicializarEstado(state);
  evalBloqueVar(arbol^.Hijos[4], state);
  evalCuerpo(arbol^.Hijos[6], state);
End;

// <BloqueVar> ::= "var" <ListaDefVar> | eps
Procedure evalBloqueVar(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then evalListaDefVar(arbol^.Hijos[2], state)
End;

// <ListaDefVar> ::= <DefVar> ";" <ListaDefVar2> 
Procedure evalListaDefVar(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalDefVar(arbol^.Hijos[1], state);
  evalListaDefVar2(arbol^.Hijos[3], state);
End;

// <ListaDefVar2> ::= <ListaDefVar> | eps
Procedure evalListaDefVar2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then evalListaDefVar(arbol^.Hijos[1], state);
End;

// <DefVar> ::= "id" ":" <Type>
Procedure evalDefVar(Var arbol: t_arbol_derivacion; Var state: t_estado);

Var 
  tipo: TipoSimbGramCom;
Begin
  evalTypo(arbol^.Hijos[3], state, tipo);
  crearVariable(arbol^.Hijos[1]^.Lexema, state, tipo)
End;

// <Type> ::= "Float" | "String"
Procedure evalTypo(Var arbol: t_arbol_derivacion; Var state: t_estado; Var tipo:
                   TipoSimbGramCom);
Begin
  If arbol^.Hijos[1]^.simbolo = TFloat Then tipo := TFloat;
  If arbol^.Hijos[1]^.simbolo = TString Then tipo := TString;
End;

// <Cuerpo> ::= <Sentencia> ";" <Cuerpo> | eps
Procedure evalCuerpo(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then
    Begin
      evalSentencia(arbol^.Hijos[1], state);
      evalCuerpo(arbol^.Hijos[3], state)
    End;
End;

// <Sentencia> ::= <Cíclica> | 
//        <Condicional> | <Asignación> | <Lectura> | <Escritura>
Procedure evalSentencia(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  Case (arbol^.Hijos[1]^.simbolo) Of 
    Twhile: evalCiclica(arbol^.Hijos[1], state);
    Tif: evalCondicional(arbol^.Hijos[1], state);
    Tid: evalAsignacion(arbol^.Hijos[1], state);
    Tread: evalLectura(arbol^.Hijos[1], state);
    Twrite: evalEscritura(arbol^.Hijos[1], state);
  End;
End;

// <Asignación> ::= "id" "opasig" <Exp>
Procedure evalAsignacion(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalExp(arbol^.Hijos[3], state)
End;

// <Exp> ::= <Exp2> <Exp5>
Procedure evalExp(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalExp2(arbol^.Hijos[1], state);
  evalExp5(arbol^.Hijos[2], state);
End;

// <Exp5> ::= "+" <Exp2> <Exp5> | "-" <Exp2> <Exp5> | eps
Procedure evalExp5(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then
    Begin
      Case (arbol^.Hijos[1]^.Simbolo) Of 
        Tmas:
              Begin
                evalExp2(arbol^.Hijos[2], state);
                evalExp5(arbol^.Hijos[3], state);
              End;
        Tmenos:
                Begin
                  evalExp2(arbol^.Hijos[2], state);
                  evalExp5(arbol^.Hijos[3], state);
                End;
      End;
    End;
End;

// <Exp2> ::= <Exp3> <Exp6>
Procedure evalExp2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalExp3(arbol^.Hijos[1], state);
  evalExp6(arbol^.Hijos[2], state);
End;

// <Exp6> ::= "*" <Exp3> <Exp6> | "/" <Exp3> <Exp6> | eps
Procedure evalExp6(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then
    Begin
      Case (arbol^.Hijos[1]^.Simbolo) Of 
        TProducto:
                   Begin
                     evalExp3(arbol^.Hijos[2], state);
                     evalExp6(arbol^.Hijos[3], state);
                   End;
        T_division:
                    Begin
                      evalExp3(arbol^.Hijos[2], state);
                      evalExp6(arbol^.Hijos[3], state);
                    End;
      End;
    End;
End;

// <Exp3> ::= <Exp4> <Exp7>
Procedure evalExp3(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalExp4(arbol^.Hijos[1], state);
  evalExp7(arbol^.Hijos[2], state);
End;

// <Exp7> ::= "^" <Exp4> <Exp7> | eps
Procedure evalExp7(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then
    Begin
      evalExp4(arbol^.Hijos[2], state);
      evalExp7(arbol^.Hijos[3], state);
    End;
End;

// <Exp4> ::= "(" <Exp> ")" | "constreal" | 
//    "id" | "constcadena" | 
//    "substr" "(" <Exp> "," <Exp> "," <Exp> ")" | 
//    "find" "(" <Exp> "," <Exp> ")" | 
//    "long" "(" <Exp> ")" | "-" <Exp4>
Procedure evalExp4(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  Case (arbol^.Hijos[1]^.Simbolo) Of 
    Tparentesisabre: evalExp(arbol^.Hijos[2], state);
    Tcreal:;
    Tid:;
    Tccadena:;
    Tsubstr:
             Begin
               evalExp(arbol^.Hijos[3], state);
               evalExp(arbol^.Hijos[5], state);
               evalExp(arbol^.Hijos[7], state);
             End;
    Tfind:
           Begin
             evalExp(arbol^.Hijos[3], state);
             evalExp(arbol^.Hijos[5], state);
           End;
    Tlong: evalExp(arbol^.Hijos[3], state);
    Tmenos: evalExp4(arbol^.Hijos[2], state)
  End;
End;

// <Cíclica> ::= "while" <Cond> "{" <Cuerpo> "}"
Procedure evalCiclica(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalCond(arbol^.Hijos[2], state);
  evalCuerpo(arbol^.Hijos[4], state);
End;

// <Condicional> ::= "if" <Cond> "{" <Cuerpo> "}" <Condicional2>
Procedure evalCondicional(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalCond(arbol^.Hijos[2], state);
  evalCuerpo(arbol^.Hijos[4], state);
  evalCondicional2(arbol^.Hijos[6], state);
End;

// <Condicional2> ::= "else" "{" <Cuerpo> "}" | eps
Procedure evalCondicional2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then evalCuerpo(arbol^.Hijos[3], state);
End;

// <Cond> ::= <Cond2> <Cond4>
Procedure evalCond(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalCond2(arbol^.Hijos[1], state);
  evalCond4(arbol^.Hijos[2], state);
End;

// <Cond4> ::= "|" <Cond2> <Cond4> | eps
Procedure evalCond4(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then
    Begin
      evalCond2(arbol^.Hijos[2], state);
      evalCond4(arbol^.Hijos[3], state);
    End;
End;

// <Cond2> ::= <Cond3> <Cond5>
Procedure evalCond2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalCond3(arbol^.Hijos[1], state);
  evalCond5(arbol^.Hijos[2], state);
End;

// <Cond5> ::= "&" <Cond3> <Cond5> | eps
Procedure evalCond5(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then
    Begin
      evalCond3(arbol^.Hijos[2], state);
      evalCond5(arbol^.Hijos[3], state);
    End;
End;

// <Cond3> ::= <Exp> "oprel" <Exp> | "!" <Cond3> | "[" <Cond> "]"
Procedure evalCond3(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  Case (arbol^.Hijos[1]^.Simbolo) Of 
    Tnot: evalCond3(arbol^.Hijos[2], state);
    T_corchabre: evalCond(arbol^.Hijos[2], state);
    Else
      Begin
        evalExp(arbol^.Hijos[1], state);
        evalExp(arbol^.Hijos[3], state);
      End;
  End;
End;

// <Lectura> ::= "read" "(" <Exp> "," "id" ")"
Procedure evalLectura(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalExp(arbol^.Hijos[3], state);
End;

// <Escritura> ::= "write" "(" <ListaExp> ")"
Procedure evalEscritura(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalListaExp(arbol^.Hijos[3], state);
End;

// <ListaExp> ::= <Exp> <ListaExp2>
Procedure evalListaExp(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  evalExp(arbol^.Hijos[1], state);
  evalListaExp2(arbol^.Hijos[2], state);
End;

// <ListaExp2> ::= "," <Exp> <ListaExp2> | eps
Procedure evalListaExp2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then
    Begin
      evalExp(arbol^.Hijos[2], state);
      evalListaExp2(arbol^.Hijos[3], state);
    End;
End;

End.
