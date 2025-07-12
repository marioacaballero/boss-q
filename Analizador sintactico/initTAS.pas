
Program initTAS;

Uses SysUtils, TypInfo;

Const 
  maxProduccion = 8;

Type 
  TipoSimbGramCom = (Tprogram,T_llaveabre,T_llavecierra,Tptoycoma,Tvar,Tid
                     ,TFloat,TString,Toprel,Twhile,Tparentesisabre,
                     Tparentisiscierra,Tif,Tread,Twrite,Tcreal,Tccadena,
                     Tsubstr,Tfind,Tlong,Tmenos,Tmas,TProducto,T_division,
                     Tpot,Tcoma,Tand,Tnot,T_corchabre,Tor,T_corchcierra,Telse,
                     ErrorLex,Pesos,Programa,Asignacion,BloqueVar,Exp3,Cond,Exp,
                     Cuerpo,Ciclica,
                     Exp5,Condicional,Exp6,ListaExp,ListaDefVar,Exp7,Exp4,
                     ListaDefVar2,Cond2,Condicional2,Cond5,Lectura,Sentencia,
                     Exp2,Cond3,DefVar,Escritura,ListaExp2,Typo,Cond4);

{  TipoSimboloGramatical = (Tprogram,T_llaveabre,T_llavecierra,Tptoycoma,Tvar,Tid
                           ,TFloat,TString,Toprel,Twhile,Tparentesisabre,
                           Tparentisiscierra,Tif,Tread,Twrite,Tcreal,Tccadena,
                           Tsubstr,Tfind,Tlong,Tmenos,Tmas,TProducto,T_division,
                           Tpot,Tcoma,Tand,Tnot,T_corchabre,Tor,T_corchcierra,
                           Telse,
                           ErrorLex,Pesos);

  TipoVarPrograma = (Programa,Asignacion,BloqueVar,Exp3,Cond,Exp,Cuerpo,Ciclica,
                     Exp5,Condicional,Exp6,ListaExp,ListaDefVar,Exp7,Exp4,
                     ListaDefVar2,Cond2,Condicional2,Cond5,Lectura,Sentencia,
                     Exp2,Cond3,DefVar,Escritura,ListaExp2,Typo,Cond4);}

  t_produccion = Record
    elem: array [1..maxProduccion] Of TipoSimbGramCom;
    cant: byte;
  End;

  t_puntero_produccion =  ^t_produccion;

  tipo_TAS = array [TipoSimbGramCom,TipoSimbGramCom] Of ^t_produccion;

  // Procedure initTAS(Var TAS: tipo_TAS);

Const 

  simb: array[1..32] Of TipoSimbGramCom = (Tprogram,T_llaveabre,
                                           T_llavecierra,Tptoycoma,Tvar,
                                           Tid,TFloat,TString,Toprel,
                                           Twhile,
                                           Tparentesisabre,
                                           Tparentisiscierra,Tif,Tread,
                                           Twrite,Tcreal,Tccadena,
                                           Tsubstr,Tfind,Tlong,Tmenos,Tmas
                                           ,TProducto,T_division,
                                           Tpot,Tcoma,Tand,Tnot,
                                           T_corchabre,Tor,T_corchcierra,
                                           Telse);

Function StringToTipoSimbolo(Const S: String): TipoSimbGramCom;

Var 
  enumValue: Integer;
Begin
  enumValue := GetEnumValue(TypeInfo(TipoSimbGramCom), S);
  StringToTipoSimbolo := TipoSimbGramCom(enumValue);
End;

Var 
  f: File Of char;
  i, j: byte;
  x: char;
  flag: Boolean;
  w: string;
  s, w2, variable: TipoSimbGramCom;
  tas: tipo_TAS;
  dir: t_puntero_produccion;
  prod: t_produccion;
Begin
  Assign(f, '../TAS - Sheet1 copy.csv');
  Reset(f);


  While Not Eof(f) Do
    Begin
      For i:=0 To maxProduccion Do
        prod.elem[i] := Pesos;
      flag := true;
      i := 0;
      j := 0;
      w := '';
      prod.cant := 0;
      While flag And (Not Eof(f)) Do
        Begin
          w := '';
          read(f, x);
          // If (j < i) And (x <> '~') Then
          //   Begin
          //     // write(' ',simb[i], '~ ');
          //     s := simb[i];
          //     j := i;
          //   End;
          While (x <> '~') And (Not Eof(f)) Do
            Begin
              If (x <> '<') And (x <> '>') And (x <> '"') And (x <> ' ') Then
                w := w + x;
              read(f, x);
            End;
          If (i=0)Then variable := StringToTipoSimbolo(w);
          // write(w);
          If (i > 0) And (w <> '') Then
            Begin
              prod.cant := prod.cant + 1;
              prod.elem[prod.cant] := StringToTipoSimbolo(w);
              write(prod.elem[prod.cant]);
            End;
          inc(i);

          If (i = 33) Then
            Begin
              i := 0;
              flag := False;
            End;
        End;
    End;
  // New(dir);
  // dir := Nil;
  // For i := 1 To prod.cant Do
  //   dir^.elem[i] := prod.elem[i];
  // dir^.cant := prod.cant;

  // tas[variable,s] := dir;
  write(StringToTipoSimbolo('Cond4'));
  // j := prod.cant;

  // For i:=0 To j Do
  //   write(prod.elem[i]);

End.
