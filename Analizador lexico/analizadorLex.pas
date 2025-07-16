
Program analizadorLex;
// logica principal del analizador lexico

{$unitPath ./helpers/}

Uses 
auxiliares, validadores, extractor;

Var 
  control: longint;
  fuente: FileOfChar;
  lexema: string;
  TS: TablaDeSimbolos;
  complex: TipoSimboloGramatical;
  i: byte;
  car: char;
Begin
  Assign(fuente, '../fuente.bqs');
  Reset(fuente);
  control := 0;
  cargarPalRes(TS);
  ObtenerSiguienteCompLex(fuente, control, complex, lexema, ts);
  WriteLn(CompLex, ' | ', Lexema);
  While (complex <> Pesos) And (complex <> ErrorLex) Do
    Begin
      ObtenerSiguienteCompLex(fuente, control, complex, lexema, ts);
      WriteLn(CompLex, ' | ', Lexema);
    End;
  // WriteLn;
  // WriteLn('TABLA DE SIMBOLOS');
  // For i:= 1 To ts.cant Do
  //   Begin
  //     Writeln(TS.elem[i].compLex, ' | ', ts.elem[i].Lexema)
  //   End;
  Close(fuente);
End.
