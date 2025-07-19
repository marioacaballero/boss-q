
Unit analizadorLex;
// logica principal del analizador lexico

Interface

{$unitPath ./}
{$unitPath ../helpers/}
{$unitPath ../../AnalizadorSintactico/helpers/}

Uses 
extractor, auxiliares, unitInitTAS;

Procedure anLex(Var control: LongInt; Var CompLex: TipoSimbGramCom; Var
                lexema: String; Var ts: TablaDeSimbolos);

Implementation

Procedure anLex(Var control: LongInt; Var CompLex: TipoSimbGramCom; Var
                lexema: String; Var ts: TablaDeSimbolos);

Var 
  fuente: FileOfChar;
Begin
  Assign(fuente, '../calcdescuento.bqs');
  Reset(fuente);
  ObtenerSiguienteCompLex(fuente, control, complex, lexema, ts);
  Close(fuente);
End;
End.
