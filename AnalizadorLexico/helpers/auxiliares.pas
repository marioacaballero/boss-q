
Unit auxiliares;

Interface

{$unitPath ../../AnalizadorSintactico/helpers/}

Uses 
unitInitTAS;

Const 
  resquant = 12;
  Fr = [6,12];
  FinArch = #0;
  maxsim = 200;
  palres: array[1..resquant] Of string = ('program','var','find','float',
                                          'string','long','if','substr',
                                          'else','while','read','write');

  // substr = subcadena - long = longitud

Type 
  SigmaReal = (Dig, Signo, Punto, Coma, OtraC);
  FileOfChar = file Of Char;
  Qr = 0..13;
  TipoDeltaReal = Array[Qr,SigmaReal] Of Qr;

  TElemTS = Record
    compLex: TipoSimbGramCom;
    Lexema: String;
  End;
  TablaDeSimbolos = Record
    elem: Array[1..MaxSim] Of TElemTS;
    cant: 0..maxsim;
  End;

Procedure LeerCar(Var Fuente:FileOfChar;Var control:
                  Longint; Var car:char);
Procedure InstalarEnTS(Lexema: String; Var TS:TablaDeSimbolos; Var CompLex:
                       TipoSimbGramCom);
Procedure cargarPalRes(Var TS: TablaDeSimbolos);
Procedure SimboloEspecial(Var fuente: FileOfChar; Var control: LongInt; Var
                          lexema: String; Var complex: TipoSimbGramCom);

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
      TS.elem[i].compLex := Pesos;
      TS.elem[i].Lexema := '';
    End;
End;

Procedure cargarPalRes(Var TS: TablaDeSimbolos);

Var i: byte;
Begin
  initTS(TS);

  For i:= 1 To resquant Do
    Begin
      TS.elem[i].compLex := TipoSimbGramCom(i);
      TS.elem[i].Lexema := palres[i];
    End;
  ts.cant := resquant;
End;

Procedure buscarenTS(TS: TablaDeSimbolos; lexema: String; Var complex:
                     TipoSimbGramCom; Var encontrado: Boolean);

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
                       TipoSimbGramCom);

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
                          lexema: String; Var complex: TipoSimbGramCom);

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
      complex := Topasig;
      control := control + 2;
    End
  Else If (car = '>') And (car2 = '=') Then
         Begin
           lexema := '>=';
           complex := Toprel;
           control := control + 2;
         End
  Else If (car = '<') And (car2 = '=') Then
         Begin
           lexema := '<=';
           complex := Toprel;
           control := control + 2;
         End
  Else If (car = '!') And (car2 = '=') Then
         Begin
           lexema := '!=';
           complex := Toprel;
           control := control + 2;
         End
  Else
    Begin
      Case Car Of 
        '^':
             Begin
               lexema := '^';
               complex := Tpot;
               control := control + 1;
             End;
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
        '[':
             Begin
               lexema := '[';
               complex := T_corchabre;
               control := control + 1;
             End;
        ']':
             Begin
               lexema := ']';
               complex := T_corchcierra;
               control := control + 1;
             End;
        '{':
             Begin
               lexema := '{';
               complex := T_llaveabre;
               control := control + 1;
             End;
        '}':
             Begin
               lexema := '}';
               complex := T_llavecierra;
               control := control + 1;
             End;
        ';':
             Begin
               lexema := ';';
               complex := Tptoycoma;
               control := control + 1;
             End;
        ':':
             Begin
               lexema := ':';
               complex := T_dosp;
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
               complex := Toprel;
               control := control + 1;
             End;
        '>':
             Begin
               lexema := '>';
               complex := Toprel;
               control := control + 1;
             End;
        '=':
             Begin
               lexema := '=';
               complex := Toprel;
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
        '!':
             Begin
               lexema := '!';
               complex := Tnot;
               control := control + 1;
             End;
        '&':
             Begin
               lexema := '&';
               complex := Tand;
               control := control + 1;
             End;
        '|':
             Begin
               lexema := '|';
               complex := Tor;
               control := control + 1;
             End;
      End;
    End;
End;

End.
