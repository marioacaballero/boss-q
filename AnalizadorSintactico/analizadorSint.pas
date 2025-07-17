
Program analizadorSint;

{$unitPath ./helpers/}
{$unitPath ../AnalizadorLexico/}
{$unitPath ../AnalizadorLexico/helpers/}

Uses 
analizadorLex, unitInitTAS, unitPila, auxiliares, unitArbol;

Var 
  TAS: tipo_TAS;
  i: byte;
  control: longint;
  lexema: string;
  complex: TipoSimbGramCom;
  TS: TablaDeSimbolos;
  pila: t_pila;
  elem: t_elem_Pila;
  raiz, dir: t_arbol_derivacion;
  f: Text;
Begin
  cargarPalRes(TS);
  initTAS(TAS);
  iniciarArbol(raiz);
  iniciarpila(pila, raiz);
  control := 0;
  lexema := '';
  anLex(control, complex, lexema, TS);

  While (complex <> ErrorLex) And (complex <> ErrorSint) And (complex <> Pesos) 
    Do
    Begin
      desapilar(pila, elem);
      If elem.simb In [T_llaveabre..Pesos] Then // Para cuando es terminal
        Begin
          If (elem.simb = complex) Then
            Begin
              elem.nodo^.lexema := lexema;
              anLex(control, complex, lexema, TS);
            End
          Else
            Begin
              WriteLn('Se esperaba ', elem.simb, ' y se encontro ',complex);
              complex := ErrorSint;
            End;
        End;


      If elem.simb In [Programa..Cond4] Then  // Para cuando es variable
        Begin
          If TAS[elem.simb,complex] = Nil Then
            Begin
              WriteLn('Desde ', elem.simb,
                      ' no se puede derivar una cadena con ', complex);
              complex := ErrorSint;
            End
          Else
            For i:= TAS[elem.simb,complex]^.cant Downto 1 Do
              Begin
                crearNodo(dir, TAS[elem.simb,complex]^.elem[i]);
                agregarDerivacion(elem.nodo, dir, i);
                apilar(pila, TAS[elem.simb,complex]^.elem[i], dir);
              End;
        End;

      If (elem.simb = Pesos) Then  // Para cuando es el ultimo de la pila
        If complex <> Pesos Then
          complex := ErrorSint;

    End;

  If complex = ErrorLex Then
    WriteLn('Error lexico: ',lexema, ' es invalido');

  Mostrar_arbol(raiz);

  Assign(f, '../arbol.txt');
  Rewrite(f);
  guardarArbol(f,raiz,1);
  Close(f);
End.
