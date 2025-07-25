
Unit evaluador;


Interface

{$unitPath ../AnalizadorSintactico/helpers}

Uses 
unitInitTAS, unitArbol, math;

Const 
  maxvar = 200;

Type 

  t_valor = Record
    v_real: Real;
    v_cad: String;
    t_typo: TipoSimbGramCom;
  End;
  t_elem_estado = Record
    lexemaId: String;
    val: t_valor;
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
Procedure evalExp(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                  t_valor);
Procedure evalExp5(Var arbol: t_arbol_derivacion; Var state: t_estado; op1:
                   t_valor; Var res:t_valor);
Procedure evalExp2(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                   t_valor);
Procedure evalExp6(Var arbol: t_arbol_derivacion; Var state: t_estado; op1:
                   t_valor; Var res:t_valor);
Procedure evalExp3(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                   t_valor);

Procedure evalExp7(Var arbol: t_arbol_derivacion; Var state: t_estado; op1:
                   t_valor; Var res: t_valor);
Procedure evalExp4(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                   t_valor);
Procedure evalCiclica(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCondicional(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCondicional2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Procedure evalCond(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                   Boolean);
Procedure evalCond4(Var arbol: t_arbol_derivacion; Var state: t_estado; Var cond
                    : Boolean; Var res: Boolean);
Procedure evalCond2(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                    Boolean);
Procedure evalCond5(Var arbol: t_arbol_derivacion; Var state: t_estado; cond:
                    Boolean; Var res: Boolean);
Procedure evalCond3(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                    Boolean);
Procedure evalLectura(Var arbol: t_arbol_derivacion; Var state:t_estado);
Procedure evalEscritura(Var arbol: t_arbol_derivacion; Var state:t_estado);
Procedure evalListaExp(Var arbol: t_arbol_derivacion; Var state:t_estado);
Procedure evalListaExp2(Var arbol: t_arbol_derivacion; Var state:t_estado);

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
  X.val.t_typo := tipo;
  X.val.v_cad := '';
  X.val.v_real := 0;
  AgregarEstado(state,X);
End;

Procedure asignarValor(lexema:String; Var state: t_estado; valor: t_valor);

Var 
  i: integer;
Begin
  For i:=1 To state.cant Do
    Begin
      If state.elem[i].lexemaid = lexema Then
        Begin
          If state.elem[i].val.t_typo = valor.t_typo Then
            Begin
              If (valor.t_typo = Tccadena) And (copy(valor.v_cad, 1, 1) = '"')
                 And
                 (copy(valor.v_cad, length(valor.v_cad), 1) = '"') Then
                Begin
                  state.elem[i].val.v_cad := copy(valor.v_cad, 2,
                                             length(valor.v_cad) - 2);
                  state.elem[i].val.v_real := valor.v_real;
                  state.elem[i].val.t_typo := valor.t_typo;
                End
              Else
                state.elem[i].val := valor
            End
          Else
            Begin
              WriteLn('Se esperaba una variable de tipo ', valor.t_typo,
                      ' para ',
                      lexema);
              Halt;
            End;
        End;
    End;

End;

Procedure devolverValor(lexema: String; Var state: t_estado; Var valor: t_valor)
;

Var i: word;
Begin
  For i:=1 To state.cant Do
    Begin
      If state.elem[i].lexemaid = lexema Then
        valor := state.elem[i].val
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
  If arbol^.Hijos[1]^.simbolo = TFloat Then tipo := Tcreal;
  If arbol^.Hijos[1]^.simbolo = TString Then tipo := Tccadena;
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
    Ciclica: evalCiclica(arbol^.Hijos[1], state);
    Condicional: evalCondicional(arbol^.Hijos[1], state);
    Asignacion: evalAsignacion(arbol^.Hijos[1], state);
    Lectura: evalLectura(arbol^.Hijos[1], state);
    Escritura: evalEscritura(arbol^.Hijos[1], state);
  End;
End;

// <Asignación> ::= "id" "opasig" <Exp>
Procedure evalAsignacion(Var arbol: t_arbol_derivacion; Var state: t_estado);

Var 
  resultado: t_valor;
Begin
  evalExp(arbol^.Hijos[3], state, resultado);
  asignarValor(arbol^.Hijos[1]^.Lexema, state, resultado)
End;

// <Exp> ::= <Exp2> <Exp5>
Procedure evalExp(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                  t_valor);

Var op1: t_valor;
Begin
  evalExp2(arbol^.Hijos[1], state, op1);
  evalExp5(arbol^.Hijos[2], state, op1, res);
End;

// <Exp5> ::= "+" <Exp2> <Exp5> | "-" <Exp2> <Exp5> | eps
Procedure evalExp5(Var arbol: t_arbol_derivacion; Var state: t_estado; op1:
                   t_valor; Var res:t_valor);

Var op2: t_valor;
Begin
  If arbol^.cant <> 0 Then
    Begin
      Case (arbol^.Hijos[1]^.Simbolo) Of 
        Tmas:
              Begin
                If (op1.t_typo = Tcreal) And (op2.t_typo = Tcreal) Then
                  Begin
                    evalExp2(arbol^.Hijos[2], state, op2);
                    op2.v_real := op2.v_real + op1.v_real;
                    evalExp5(arbol^.Hijos[3], state, op2, res);
                  End
                Else If (op1.t_typo = Tccadena) And (op2.t_typo = Tccadena) Then
                       Begin
                         evalExp2(arbol^.Hijos[2], state, op2);
                         op2.v_cad := op2.v_cad + op1.v_cad;
                         evalExp5(arbol^.Hijos[3], state, op2, res);
                       End
                Else
                  Begin
                    WriteLn('Error: Operación no válida entre tipos ',
                            op1.t_typo, ' y ', op2.t_typo);
                    Halt;
                  End;
              End;
        Tmenos:
                Begin
                  If (op1.t_typo <> Tcreal) Or (op2.t_typo <> Tcreal) Then
                    Begin
                      WriteLn('Error: Operación no válida entre tipos ',
                              op1.t_typo, ' y ', op2.t_typo);
                      Halt;
                    End;
                  evalExp2(arbol^.Hijos[2], state, op2);
                  op2.v_real := op1.v_real - op2.v_real;
                  evalExp5(arbol^.Hijos[3], state, op2, res);
                End;
      End;
    End
  Else res := op1;
End;

// <Exp2> ::= <Exp3> <Exp6>
Procedure evalExp2(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                   t_valor);

Var op1: t_valor;
Begin
  evalExp3(arbol^.Hijos[1], state, op1);
  evalExp6(arbol^.Hijos[2], state, op1, res);
End;

// <Exp6> ::= "*" <Exp3> <Exp6> | "/" <Exp3> <Exp6> | eps
Procedure evalExp6(Var arbol: t_arbol_derivacion; Var state: t_estado; op1:
                   t_valor; Var res:t_valor);

Var op2: t_valor;
Begin
  If arbol^.cant <> 0 Then
    Begin
      Case (arbol^.Hijos[1]^.Simbolo) Of 
        TProducto:
                   Begin
                     evalExp3(arbol^.Hijos[2], state, op2);
                     If (op1.t_typo <> Tcreal) Or (op2.t_typo <> Tcreal) Then
                       Begin
                         WriteLn('Error: Operación no válida entre tipos ',
                                 op1.t_typo, ' y ', op2.t_typo);
                         Halt;
                       End;
                     op2.v_real := op2.v_real * op1.v_real;
                     evalExp6(arbol^.Hijos[3], state, op2, res);
                   End;
        T_division:
                    Begin
                      evalExp3(arbol^.Hijos[2], state, op2);
                      If (op1.t_typo <> Tcreal) Or (op2.t_typo <> Tcreal) Then
                        Begin
                          WriteLn('Error: Operación no válida entre tipos ',
                                  op1.t_typo, ' y ', op2.t_typo);
                          Halt;
                        End;
                      If op2.v_real = 0 Then
                        Begin
                          WriteLn('Error: División por cero');
                          Halt;
                        End;
                      op2.v_real := op1.v_real / op2.v_real;
                      evalExp6(arbol^.Hijos[3], state, op2, res);
                    End;
      End;
    End
  Else res := op1;
End;

// <Exp3> ::= <Exp4> <Exp7>
Procedure evalExp3(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                   t_valor);

Var op1: t_valor;
Begin
  evalExp4(arbol^.Hijos[1], state, op1);
  evalExp7(arbol^.Hijos[2], state, op1, res);
End;

// <Exp7> ::= "^" <Exp4> <Exp7> | eps
Procedure evalExp7(Var arbol: t_arbol_derivacion; Var state: t_estado; op1:
                   t_valor; Var res: t_valor);

Var op2: t_valor;
  n: Integer;
Begin
  If arbol^.cant <> 0 Then
    Begin
      evalExp4(arbol^.Hijos[2], state, op2);
      If (op1.t_typo <> Tcreal) Or (op2.t_typo <> Tcreal) Then
        Begin
          WriteLn('Error: Operación no válida entre tipos ', op1.t_typo, ' y '
                  ,
                  op2.t_typo);
          Halt;
        End;
      If (Frac(op2.v_real) > 0) And (op2.v_real > 0) Then
        Begin
          n := Round(1 / op2.v_real);
          // Solo si el exponente es exactamente 1/n
          If Abs(op2.v_real - (1 / n)) < 0.00001 Then
            Begin
              If (op1.v_real < 0) And (n Mod 2 = 0) Then
                Begin
                  WriteLn(

                     'Error: No se puede calcular raíz par de número negativo'
                  );
                  Halt;
                End;
            End;
        End;
      op2.v_real := Power(op1.v_real, op2.v_real);
      evalExp7(arbol^.Hijos[3], state, op2, res);
    End
  Else res := op1
End;

// <Exp4> ::= "(" <Exp> ")" | "constreal" | 
//    "id" | "constcadena" | 
//    "substr" "(" <Exp> "," <Exp> "," <Exp> ")" | 
//    "find" "(" <Exp> "," <Exp> ")" | 
//    "long" "(" <Exp> ")" | "-" <Exp4>
Procedure evalExp4(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                   t_valor);

Var err: Integer;
  cadena1, cadena2, inicio, longitud, op1: t_valor;
Begin
  Case (arbol^.Hijos[1]^.Simbolo) Of 
    Tparentesisabre: evalExp(arbol^.Hijos[2], state, res);
    Tcreal:
            Begin
              Val(arbol^.Hijos[1]^.lexema, res.v_real, err);
              res.t_typo := Tcreal;
              res.v_cad := '';
            End;
    Tid: devolverValor(arbol^.Hijos[1]^.lexema, state, res);
    Tccadena:
              Begin
                res.v_real := 0;
                res.t_typo := Tccadena;
                res.v_cad := copy(arbol^.Hijos[1]^.lexema, 2,
                             length(arbol^.Hijos[1]^.lexema) - 2);
              End;
    Tsubstr:
             Begin
               evalExp(arbol^.Hijos[3], state, cadena1);
               evalExp(arbol^.Hijos[5], state, inicio);
               evalExp(arbol^.Hijos[7], state, longitud);
               res.v_cad := Copy(cadena1.v_cad, Trunc(inicio.v_real), Trunc(
                            longitud.v_real));
               res.t_typo := Tccadena;
               res.v_real := 0;
             End;
    Tfind:
           Begin
             evalExp(arbol^.Hijos[3], state, cadena1);
             evalExp(arbol^.Hijos[5], state, cadena2);
             If Pos(cadena1.v_cad, cadena2.v_cad) > 0 Then
               Begin
                 res.v_real := Pos(cadena1.v_cad, cadena2.v_cad);
                 res.t_typo := Tcreal;
                 res.v_cad := '';
               End
             Else
               Begin
                 res.v_real := -1;
                 res.t_typo := Tcreal;
                 res.v_cad := '';
               End;
           End;
    Tlong:
           Begin
             evalExp(arbol^.Hijos[3], state, cadena1);
             res.v_real := Length(cadena1.v_cad);
             res.t_typo := Tcreal;
             res.v_cad := '';
           End;
    Tmenos:
            Begin
              evalExp4(arbol^.Hijos[2], state, op1);
              If op1.t_typo <> Tcreal Then
                Begin
                  WriteLn('Error: Operación no válida para cadena');
                  Halt;
                End;
              res.v_real := (-1) * op1.v_real;
              res.t_typo := Tcreal;
              res.v_cad := '';
            End;
  End;
End;

// <Cíclica> ::= "while" <Cond> "{" <Cuerpo> "}"
Procedure evalCiclica(Var arbol: t_arbol_derivacion; Var state: t_estado);

Var cond: Boolean;
Begin
  evalCond(arbol^.Hijos[2], state, cond);
  While cond Do
    Begin
      evalCuerpo(arbol^.Hijos[4], state);
      evalCond(arbol^.Hijos[2], state, cond);
    End;
End;

// <Condicional> ::= "if" <Cond> "{" <Cuerpo> "}" <Condicional2>
Procedure evalCondicional(Var arbol: t_arbol_derivacion; Var state: t_estado);

Var cond: Boolean;
Begin
  evalCond(arbol^.Hijos[2], state, cond);
  If cond Then
    evalCuerpo(arbol^.Hijos[4], state)
  Else
    evalCondicional2(arbol^.Hijos[6], state);
End;

// <Condicional2> ::= "else" "{" <Cuerpo> "}" | eps
Procedure evalCondicional2(Var arbol: t_arbol_derivacion; Var state: t_estado);
Begin
  If arbol^.cant <> 0 Then evalCuerpo(arbol^.Hijos[3], state);
End;

// <Cond> ::= <Cond2> <Cond4>
Procedure evalCond(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                   Boolean);

Var cond: Boolean;
Begin
  evalCond2(arbol^.Hijos[1], state, cond);
  evalCond4(arbol^.Hijos[2], state, cond, res);
End;

// <Cond4> ::= "|" <Cond2> <Cond4> | eps
Procedure evalCond4(Var arbol: t_arbol_derivacion; Var state: t_estado; Var cond
                    : Boolean; Var res: Boolean);

Var cond2: Boolean;
Begin
  If arbol^.cant <> 0 Then
    Begin
      evalCond2(arbol^.Hijos[2], state, cond2);
      cond2 := cond Or cond2;
      evalCond4(arbol^.Hijos[3], state, cond2, res);
    End
  Else res := cond;
End;

// <Cond2> ::= <Cond3> <Cond5>
Procedure evalCond2(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                    Boolean);

Var cond: Boolean;
Begin
  evalCond3(arbol^.Hijos[1], state, cond);
  evalCond5(arbol^.Hijos[2], state, cond, res);
End;

// <Cond5> ::= "&" <Cond3> <Cond5> | eps
Procedure evalCond5(Var arbol: t_arbol_derivacion; Var state: t_estado; cond:
                    Boolean; Var res: Boolean);

Var cond2: Boolean;
Begin
  If arbol^.cant <> 0 Then
    Begin
      evalCond3(arbol^.Hijos[2], state, cond2);
      cond2 := cond And cond2;
      evalCond5(arbol^.Hijos[3], state, cond2, res);
    End
  Else res := cond;
End;

// <Cond3> ::= <Exp> "oprel" <Exp> | "!" <Cond3> | "[" <Cond> "]"
Procedure evalCond3(Var arbol: t_arbol_derivacion; Var state: t_estado; Var res:
                    Boolean);

Var op1, op2: t_valor;
  oprel: string;
  cond: Boolean;
Begin
  Case (arbol^.Hijos[1]^.Simbolo) Of 
    Tnot:
          Begin
            evalCond3(arbol^.Hijos[2], state, cond);
            res := Not cond;
          End;
    T_corchabre: evalCond(arbol^.Hijos[2], state, res);
    Else
      Begin
        evalExp(arbol^.Hijos[1], state, op1);
        evalExp(arbol^.Hijos[3], state, op2);
        If op1.t_typo <> op2.t_typo Then
          Begin
            WriteLn('Error: Operación no válida entre tipos ',
                    op1.t_typo, ' y ', op2.t_typo);
            Halt;
          End;
        oprel := arbol^.Hijos[2]^.lexema;
        If op1.t_typo = Tcreal Then
          Case oprel Of 
            '=': res := op1.v_real = op2.v_real;
            '<': res := op1.v_real < op2.v_real;
            '>': res := op1.v_real > op2.v_real;
            '<=': res := op1.v_real <= op2.v_real;
            '>=': res := op1.v_real >= op2.v_real;
            '!=': res := op1.v_real <> op2.v_real;
          End
        Else
          Case oprel Of 
            '=': res := op1.v_cad = op2.v_cad;
            '<': res := op1.v_cad < op2.v_cad;
            '>': res := op1.v_cad > op2.v_cad;
            '<=': res := op1.v_cad <= op2.v_cad;
            '>=': res := op1.v_cad >= op2.v_cad;
            '!=': res := op1.v_cad <> op2.v_cad;
          End;
      End;
  End;
End;

// <Lectura> ::= "read" "(" <Exp> "," "id" ")"
Procedure evalLectura(Var arbol: t_arbol_derivacion; Var state:t_estado);

Var lec, res: t_valor;
  err: Integer;
  cad: String;
  vreal: Real;
Begin
  evalExp(arbol^.Hijos[3], state, lec);
  Write(lec.v_cad);
  // Eliminar comillas
  ReadLn(cad);
  Val(cad, vreal, err);
  If err > 0 Then
    Begin
      res.t_typo := Tccadena;
      res.v_cad := cad;
      res.v_real := 0;
    End
  Else
    Begin
      res.t_typo := Tcreal;
      res.v_real := vreal;
      res.v_cad := '';
    End;
  asignarValor(arbol^.Hijos[5]^.Lexema, state, res);
End;

// <Escritura> ::= "write" "(" <ListaExp> ")"
Procedure evalEscritura(Var arbol: t_arbol_derivacion; Var state:t_estado);
Begin
  evalListaExp(arbol^.Hijos[3], state);
End;

// <ListaExp> ::= <Exp> <ListaExp2>
Procedure evalListaExp(Var arbol: t_arbol_derivacion; Var state:t_estado);

Var res: t_valor;
Begin
  evalExp(arbol^.Hijos[1], state, res);
  If res.t_typo = Tccadena Then
    Writeln(res.v_cad)
  Else
    WriteLn(res.v_real:0:2);
  evalListaExp2(arbol^.Hijos[2], state);
End;

// <ListaExp2> ::= "," <Exp> <ListaExp2> | eps
Procedure evalListaExp2(Var arbol: t_arbol_derivacion; Var state:t_estado);

Var res: t_valor;
Begin
  If arbol^.cant <> 0 Then
    Begin
      evalExp(arbol^.Hijos[2], state, res);
      If res.t_typo = Tccadena Then
        Writeln(res.v_cad)
      Else
        WriteLn(res.v_real:0:2);
      evalListaExp2(arbol^.Hijos[3], state);
    End;
End;

End.
