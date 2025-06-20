
Unit auxiliares;

Interface

Const 
  Fr = [6,12];
  FinArch = #0;
  maxsim = 200;
  palres: array[1..10] Of string = ('program', 'begin', 'end', 'if', 'then',
                                    'else', 'while', 'do', 'read', 'write');

Type 
  SigmaReal = (Dig, Signo, Punto, Coma, OtraC);
  FileOfChar = file Of Char;
  Qr = 0..13;
  TipoDeltaReal = Array[Qr,SigmaReal] Of Qr;

  TipoSimboloGramatical = (Tid,Tcreal,Tcentera,Tccadena,Tparentesisabre,
                           Tparentisiscierra
                           ,Tmas,Tmenos,TProducto,T_division,Tptoycoma,Tcoma,
                           Tpunto,Toperadorrealacional,Toperadorasignacion,
                           ErrorGramatical, Pesos, TparReservada);
  TElemTS = Record
    compLex: TipoSimboloGramatical;
    Lexema: String;
  End;
  TablaDeSimbolos = Record
    elem: Array[1..MaxSim] Of TElemTS;
    cant: 0..maxsim;
  End;

Procedure LeerCar(Var Fuente:FileOfChar;Var control:
                  Longint; Var car:char);
Procedure InstalarEnTS(Lexema: String; Var TS:TablaDeSimbolos; Var CompLex:
                       TipoSimboloGramatical);
Procedure cargarPalRes(Var TS: TablaDeSimbolos);
Procedure SimboloEspecial(Var fuente: FileOfChar; Var control: LongInt; Var
                          lexema: String; Var complex: TipoSimboloGramatical);

Implementation

Function carasimbReal(cha:char): SigmaReal;
Begin
  Case cha Of 
    '0'..'9' : carasimbReal := Dig;
    '.'      : carasimbReal := Punto;
    ','      : carasimbReal := Coma;
    '-'      : carasimbReal := Signo;
    Else
      carasimbReal := OtraC;
  End;
End;

Procedure LeerCar(Var Fuente:FileOfChar;Var control:Longint; Var car:char);
Begin
  If control < filesize(Fuente) Then
    Begin
      seek(FUENTE,control);
      read(fuente,car);
    End
  Else
    car := FinArch;
End;

Procedure initTS(Var TS: TablaDeSimbolos);

Var 
  i: byte;
Begin
  ts.cant := 0;
  For i := 1 To maxsim Do
    Begin
      TS.elem[i].compLex := TparReservada;
      TS.elem[i].Lexema := '';
    End;
End;

Procedure cargarPalRes(Var TS: TablaDeSimbolos);

Var i: byte;
Begin
  initTS(TS);

  For i:= 1 To 10 Do
    Begin
      TS.elem[i].compLex := TparReservada;
      TS.elem[i].Lexema := palres[i];
    End;
  ts.cant := 10;
End;

Procedure buscarenTS(TS: TablaDeSimbolos; lexema: String; Var complex:
                     TipoSimboloGramatical; Var encontrado: Boolean);

Var 
  i: byte;
Begin
  i := 1;
  While (i <= ts.cant) And Not encontrado Do
    Begin
      If (ts.elem[i].Lexema = lexema) Then
        Begin
          encontrado := True;
          complex := ts.elem[i].compLex;
        End;
      inc(i);
    End;
End;

Procedure InstalarEnTS(Lexema: String; Var TS:TablaDeSimbolos; Var CompLex:
                       TipoSimboloGramatical);

Var 
  encontrado: Boolean;
Begin
  encontrado := False;
  buscarenTS(TS, lexema, CompLex, encontrado);
  If (Not encontrado) Then
    Begin
      CompLex := Tid;
      ts.cant := ts.cant + 1;
      ts.elem[ts.cant].compLex := Tid;
      ts.elem[ts.cant].Lexema := Lexema;
    End
End;

Procedure SimboloEspecial(Var fuente: FileOfChar; Var control: LongInt; Var
                          lexema: String; Var complex: TipoSimboloGramatical);

Var 
  car: Char;
  car2: Char;
  controlAux: LongInt;
Begin
  controlAux := control + 1;
  LeerCar(fuente, control, car);
  LeerCar(fuente, controlAux, car2);
  If (car = ':') And (car2 = '=') Then
    Begin
      lexema := ':=';
      complex := Toperadorasignacion;
      control := control + 2;
    End
  Else
    Begin
      Case Car Of 
        '(':
             Begin
               lexema := '(';
               complex := Tparentesisabre;
               control := control + 1;
             End;
        ')':
             Begin
               lexema := ')';
               complex := Tparentisiscierra;
               control := control + 1;
             End;
        ';':
             Begin
               lexema := ';';
               complex := Tptoycoma;
               control := control + 1;
             End;
        '.':
             Begin
               lexema := '.';
               complex := Tpunto;
               control := control + 1;
             End;
        ',':
             Begin
               lexema := ',';
               complex := Tcoma;
               control := control + 1;
             End;
        '<':
             Begin
               lexema := '<';
               complex := Toperadorrealacional;
               control := control + 1;
             End;
        '>':
             Begin
               lexema := '>';
               complex := Toperadorrealacional;
               control := control + 1;
             End;
        '=':
             Begin
               lexema := '=';
               complex := Toperadorrealacional;
               control := control + 1;
             End;
        '+':
             Begin
               lexema := '+';
               complex := Tmas;
               control := control + 1;
             End;
        '-':
             Begin
               lexema := '-';
               complex := Tmenos;
               control := control + 1;
             End;
        '*':
             Begin
               lexema := '*';
               complex := TProducto;
               control := control + 1;
             End;
        '/':
             Begin
               lexema := '/';
               complex := T_division;
               control := control + 1;
             End;
      End;
    End;
End;

End.
