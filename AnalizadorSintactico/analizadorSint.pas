
Unit analizadorSint;

Interface
{$unitPath ./helpers/}
{$unitPath ../AnalizadorLexico/}
{$unitPath ../AnalizadorLexico/helpers/}

Uses 
analizadorLex, unitInitTAS, unitPila, auxiliares, unitArbol;

Procedure ASint(Var raiz: t_arbol_derivacion; Var fuente: FileOfChar; f: String)
;

Implementation
Procedure ASint(Var raiz: t_arbol_derivacion; Var fuente: FileOfChar; f: String)
;

Var 
  TAS: tipo_TAS;
  i: byte;
  control: longint;
  lexema: string;
  complex: TipoSimbGramCom;
  TS: TablaDeSimbolos;
  pila: t_pila;
  elem: t_elem_Pila;
  dir: t_arbol_derivacion;
Begin
  cargarPalRes(TS);
  initTAS(TAS);
  iniciarArbol(raiz);
  iniciarpila(pila, raiz);
  control := 0;
  lexema := '';
  anLex(fuente, control, complex, lexema, TS);

  While (complex <> ErrorLex) And (complex <> ErrorSint) And (complex <> Pesos) 
    Do
    Begin
      desapilar(pila, elem);
      If elem.simb In [T_llaveabre..Pesos] Then // Para cuando es terminal
        Begin
          If (elem.simb = complex) Then
            Begin
              elem.nodo^.lexema := lexema;
              anLex(fuente, control, complex, lexema, TS);
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

  If complex = Pesos Then WriteLn('Compilacion exitosa de ', f)
End;
End.
