
Unit validadores;

Interface
{$unitPath ./}

Uses 
auxiliares, tablasAF;

Function EsIdentificador(Var Fuente:FileOfChar; Var Control:LongInt; Var Lexema:
                         String): Boolean;
Function EsConstanteEntera(Var Fuente:FileOfChar;Var Control: Longint;Var Lexema
                           :
                           String): Boolean;
Function EsConstanteReal(Var Fuente:FileOfChar;Var Control: Longint;Var Lexema:
                         String)
: Boolean;
Function EsConstanteCadena(Var Fuente:FileOfChar;Var Control: Longint;Var Lexema
                           :
                           String): Boolean;
Function EsSimboloEspecial(Var fuente: FileOfChar;Var control: LongInt): Boolean
;

Implementation

Function EsSimboloEspecial(Var fuente: FileOfChar;Var control: LongInt): Boolean
;

Var 
  car: char;
Begin
  LeerCar(Fuente, control, Car);
  Case Car Of 
    '^': EsSimboloEspecial := True;
    '&': EsSimboloEspecial := True;
    '!': EsSimboloEspecial := True;
    '~': EsSimboloEspecial := True;
    ']': EsSimboloEspecial := True;
    '[': EsSimboloEspecial := True;
    '{': EsSimboloEspecial := True;
    '}': EsSimboloEspecial := True;
    '(': EsSimboloEspecial := True;
    ')': EsSimboloEspecial := True;
    ';': EsSimboloEspecial := True;
    '.': EsSimboloEspecial := True;
    ',': EsSimboloEspecial := True;
    '<': EsSimboloEspecial := True;
    '>': EsSimboloEspecial := True;
    '=': EsSimboloEspecial := True;
    '+': EsSimboloEspecial := True;
    '-': EsSimboloEspecial := True;
    '*': EsSimboloEspecial := True;
    '/': EsSimboloEspecial := True;
    ':': EsSimboloEspecial := True;
    Else
      EsSimboloEspecial := false
  End;
End;

Function EsIdentificador(Var Fuente:FileOfChar; Var Control:LongInt; Var Lexema:
                         String): Boolean;

Const 
  q0 = 0;
  F = [2];

Function CarASimb(Car:Char): Sigma;

Begin
  Case Car Of 
    'a'..'z', 'A'..'Z': CarASimb := Letra;
    '0'..'9'      : CarASimb := Digito;
    '_': CarASimb := Guion;
    Else
      CarASimb := Otro
  End;
End;

Var 
  ControlAux: LongInt;
  EstadoActual: Q;
  Delta: TipoDelta;
  Car: Char;
Begin
  {Cargar la tabla de transiciones}
  AFIdentificador(Delta);
  {Recorrer la cadena de entrada y cambiar estados}
  ControlAux := Control;
  EstadoActual := q0;
  While (EstadoActual <> 2) And (EstadoActual <> 3) Do
    Begin
      LeerCar(Fuente, ControlAux, Car);
      EstadoActual := Delta[EstadoActual,CarASimb(Car)];
      ControlAux := ControlAux + 1;
      If (EstadoActual<>2) Then
        Lexema := Lexema + Car;
    End;
  If EstadoActual In F Then
    Begin
      EsIdentificador := True;
      Control := ControlAux - 1;
    End
  Else
    Begin
      EsIdentificador := False;
      lexema := '';
    End;

End;

Function EsConstanteEntera(Var Fuente:FileOfChar;Var Control: Longint;Var Lexema
                           :
                           String): Boolean;

Const 
  q0 = 0;
  F = [4];

Function CarASimbEnt(Car:Char): SigmaEnt;

Begin
  Case Car Of 
    '0'..'9'      : CarASimbEnt := DigitoEnt;
    '-': CarASimbEnt := GuionEnt;
    Else
      CarASimbEnt := OtroEnt
  End;
End;

Var 
  ControlAux: LongInt;
  EstadoActual: Qent;
  Delta: TipoDeltaEnt;
  Car: Char;
Begin
  {Cargar la tabla de transiciones}
  AFConstEntera(Delta);
  ControlAux := Control;
  EstadoActual := q0;
  While (EstadoActual <> 4) And (EstadoActual <> 5) Do
    Begin
      LeerCar(Fuente, ControlAux, Car);
      EstadoActual := Delta[EstadoActual,CarASimbEnt(Car)];
      ControlAux := ControlAux + 1;
      If (EstadoActual<>4) Then
        Lexema := Lexema + Car;
    End;
  If EstadoActual In F Then
    Begin
      EsConstanteEntera := True;
      Control := ControlAux - 1;
    End
  Else
    Begin
      Lexema := '';
      EsConstanteEntera := False;
    End;
End;

Function EsConstanteCadena(Var Fuente:FileOfChar;Var Control: Longint;Var Lexema
                           :
                           String): Boolean;

Const 
  q0 = 0;
  F = [4];

Function CarASimbCad(Car:Char): SigmaCadena;

Begin
  Case Car Of 
    '0'..'9'      : CarASimbCad := DigitoCad;
    '"': CarASimbCad := Comilla;
    'a'..'z', 'A'..'Z': CarASimbCad := LetraCad;
    Else
      CarASimbCad := OtroCad
  End;
End;

Var 
  ControlAux: LongInt;
  EstadoActual: QCadena;
  Delta: TipoDeltaCadena;
  Car: Char;
Begin
  {Cargar la tabla de transiciones}
  AFConstCad(Delta);
  ControlAux := Control;
  EstadoActual := q0;
  While (EstadoActual <> 4) And (EstadoActual <> 3) Do
    Begin
      LeerCar(Fuente, ControlAux, Car);
      EstadoActual := Delta[EstadoActual,CarASimbCad(Car)];
      ControlAux := ControlAux + 1;
      If (EstadoActual<>4) Then
        Lexema := Lexema + Car;
    End;
  If EstadoActual In F Then
    Begin
      EsConstanteCadena := True;
      Control := ControlAux - 1;
    End
  Else
    Begin
      Lexema := '';
      EsConstanteCadena := False;
    End;
End;

Function EsConstanteReal(Var Fuente:FileOfChar;Var Control: Longint;Var Lexema:
                         String)
: Boolean;

Const 
  q0 = 0;
  F = [10];

Function CarASimbReal(Car:Char): SigmaReal;

Begin
  Case Car Of 
    '0'..'9'      : CarASimbReal := DigitoReal;
    '-': CarASimbReal := GuionReal;
    '.': CarASimbReal := PuntoReal;
    ',': CarASimbReal := ComaReal;
    Else
      CarASimbReal := OtroReal
  End;
End;

Var 
  ControlAux: LongInt;
  EstadoActual: Qreal;
  Delta: TipoDeltaReal;
  Car: Char;
Begin
    {Cargar la tabla de transiciones}
  AFConstReal(Delta);
  {Recorrer la cadena de entrada y cambiar estados}
  ControlAux := Control;
  EstadoActual := q0;
  Lexema := '';
  While (EstadoActual <> 10) And (EstadoActual <> 11) Do
    Begin
      LeerCar(Fuente, ControlAux, Car);
      EstadoActual := Delta[EstadoActual,CarASimbReal(Car)];
      ControlAux := ControlAux + 1;
      If (EstadoActual <> 10) Then
        Lexema := Lexema+Car;
    End;
  If EstadoActual In F Then
    Begin
      EsConstanteReal := True;
      Control := ControlAux - 1;
    End
  Else
    Begin
      Lexema := '';
      EsConstanteReal := False;
    End;
End;

End.
