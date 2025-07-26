
Program bossQ;

{$unitPath ./AnalizadorLexico/helpers/}
{$unitPath ./AnalizadorSintactico/}
{$unitPath ./Evaluador/}

Uses 
sysutils, analizadorSint, auxiliares, unitArbol, evaluador;

Var 
  fuente: FileOfChar;
  raiz: t_arbol_derivacion;
  f: string;
Begin
  // obtener la ruta
  f := '.'+PathDelim+'programa'+PathDelim+paramstr(1);

  // primero inicializo archivo
  Assign(fuente, f);
  Reset(fuente);

  // se lo paso al Sint
  ASint(raiz, fuente, paramstr(1));

  // evaluador
  evalPrograma(raiz);

  Close(fuente);
End.
