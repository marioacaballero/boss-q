
Unit extractor;
// permite obtener las componentes segun corresponda, ya sea un identificador
// u otro tipo de variable

Interface

// trae las units desde la carpeta helpers
{$unitPath ./helpers/}
{$unitPath ../../AnalizadorSintactico/helpers/}

Uses 
validadores, auxiliares, unitInitTAS;

Procedure ObtenerSiguienteCompLex(Var Fuente:FileOfChar;Var Control:Longint; Var
                                  CompLex:TipoSimbGramCom;Var Lexema:
                                  String;Var TS:
                                  TablaDeSimbolos);

Implementation

Procedure ObtenerSiguienteCompLex(Var Fuente:FileOfChar;Var Control:Longint; Var
                                  CompLex:TipoSimbGramCom;Var Lexema:
                                  String;Var TS:
                                  TablaDeSimbolos);

Var 
  car: char;
  controlAux: LongInt;
Begin
  Lexema := '';
  car := #0;
  LeerCar(fuente, control, car);
  While car In [#1..#32] Do
    Begin
      control := control + 1;
      LeerCar(Fuente, control, car);
    End;
  controlAux := control;
  If (car = FinArch) Then
    Begin
      CompLex := Pesos;
      Lexema := '$Pesos';
    End
  Else
    Begin
      If EsIdentificador(Fuente,Control,Lexema) Then
        Begin
          InstalarEnTS(Lexema,TS,CompLex);
        End
      Else If EsConstanteCadena(Fuente,Control,Lexema) Then
             CompLex := Tccadena
      Else If EsConstanteReal(Fuente,Control,Lexema) Then
             CompLex := Tcreal
      Else If EsSimboloEspecial(Fuente,Control) Then
             SimboloEspecial(Fuente, control, Lexema, CompLex)
      Else
        Begin
          Lexema := car;
          CompLex := ErrorLex;
        End;
      If controlAux = Control Then
        Control := control + 1;
    End;
End;

End.
