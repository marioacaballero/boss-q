
Unit analizadorLex;
// logica principal del analizador lexico

Interface

{$unitPath ./}
{$unitPath ../helpers/}
{$unitPath ../../AnalizadorSintactico/helpers/}

Uses 
extractor, auxiliares, unitInitTAS;

Procedure anLex(Var fuente: FileOfChar; Var control: LongInt; Var CompLex:
                TipoSimbGramCom; Var
                lexema: String; Var ts: TablaDeSimbolos);

Implementation

Procedure anLex(Var fuente: FileOfChar; Var control: LongInt; Var CompLex:
                TipoSimbGramCom; Var
                lexema: String; Var ts: TablaDeSimbolos);

Begin
  ObtenerSiguienteCompLex(fuente, control, complex, lexema, ts);
End;
End.
