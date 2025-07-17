
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
  lexema := '';
  anLex(control, complex, lexema, TS);

  While (complex <> ErrorLex) And (complex <> ErrorSint) And (complex <> Pesos) 
    Do
    Begin
      desapilar(pila, elem);

      If elem In [T_llaveabre..Pesos] Then // Para cuando es terminal
        Begin
          If (elem = complex) Then
            // antes debo guardar el lexema
            anLex(control, complex, lexema, TS)
          Else
            Begin
              WriteLn('Se esperaba ', elem, ' y se encontro ',complex);
              complex := ErrorSint;
            End;
        End;


      If elem In [Programa..Cond4] Then  // Para cuando es variable
        Begin
          If TAS[elem,complex] = Nil Then
            Begin
              WriteLn('Desde ', elem,
                      ' no se puede derivar una cadena con ', complex);
              complex := ErrorSint;
            End
          Else
            For i:= TAS[elem,complex]^.cant Downto 1 Do
              apilar(pila, TAS[elem,complex]^.elem[i]);
        End;

      If (elem = Pesos) Then  // Para cuando es el ultimo de la pila
        If complex <> Pesos Then
          complex := ErrorSint;

    End;

  If complex = ErrorLex Then
    WriteLn('Error lexico: ',lexema, ' es invalido');

End.
