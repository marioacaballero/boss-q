
Program analizadorSint;


{$unitPath ./helpers/}
{$unitPath ../AnalizadorLexico/}
{$unitPath ../AnalizadorLexico/helpers/}

Uses 
analizadorLex, unitInitTAS, unitPila, auxiliares;

Var 
  TAS: tipo_TAS;
  i: byte;
  control: longint;
  lexema: string;
  complex, elem: TipoSimbGramCom;
  TS: TablaDeSimbolos;
  pila : t_pila;
Begin
  cargarPalRes(TS);
  initTAS(TAS);
  iniciarpila(pila);
  control := 0;
  complex := eps;
  lexema := '';
  anLex(control, complex, lexema, TS);
  WriteLn;
  For i:= 1 To pila.tope Do
    WriteLn(pila.elem[i].simb);
  WriteLn;
  WriteLn('complex: ', complex);

  While (complex <> ErrorLex) And (complex <> ErrorSint) And (complex <> Pesos) 
    Do
    Begin
      desapilar(pila, elem);
      WriteLn('complex: ', complex);

      If elem In [T_llaveabre..Pesos] Then // Para cuando es terminal
        Begin
          If (elem = complex) Then
            // antes debo guardar el lexema
            anLex(control, complex, lexema, TS)
          Else
            complex := ErrorSint;
          // se esperaba tal elem y se encontro complex
        End;


      If elem In [Programa..Cond4] Then  // Para cuando es variable
        Begin
          If TAS[elem,complex] = Nil Then
            complex := ErrorSint
                       // desde elem no se puede derivar una cadena con complex
          Else
            For i:= TAS[elem,complex]^.cant Downto 1 Do
              apilar(pila, TAS[elem,complex]^.elem[i]);
        End;

      If (elem = Pesos) Then  // Para cuando es el ultimo de la pila
        If complex <> Pesos Then
          complex := ErrorSint;

      WriteLn;
      For i:= 1 To pila.tope Do
        WriteLn(pila.elem[i].simb);
      WriteLn;
    End;

  If complex = ErrorLex Then
    WriteLn('Error lexico: ',lexema, ' es invalido');

  WriteLn('complex: ', complex);
  WriteLn('Lexema: ', Lexema);

  // For i:= 1 To TAS[ListaDefVar2, complex]^.cant Do
  //   writeln(TAS[Programa, Tprogram]^.elem[i])

End.
