
Unit tablasAF;

Interface

Type 
  Sigma = (Letra, Digito, Guion, Otro);
  Q = 0..3;
  TipoDelta = Array[Q,Sigma] Of Q;

  SigmaEnt = (GuionEnt, DigitoEnt, OtroEnt);
  Qent = 0..5;
  TipoDeltaEnt = Array [Qent, SigmaEnt] Of Qent;

  SigmaReal = (GuionReal, DigitoReal, OtroReal, PuntoReal, ComaReal);
  Qreal = 0..11;
  TipoDeltaReal = Array [Qreal, SigmaReal] Of Qreal;

  SigmaCadena = (Comilla, LetraCad, DigitoCad, OtroCad);
  QCadena = 0..4;
  TipoDeltaCadena = Array [QCadena, SigmaCadena] Of QCadena;

Procedure AFIdentificador(Var delta: TipoDelta);
Procedure AFConstEntera(Var delta: TipoDeltaEnt);
Procedure AFConstReal(Var delta: TipoDeltaReal);
Procedure AFConstCad(Var delta: TipoDeltaCadena);

Implementation

Procedure AFIdentificador(Var delta: TipoDelta);
Begin
  Delta[0,Letra] := 1;
  Delta[0,Digito] := 3;
  Delta[0,Guion] := 3;
  Delta[0,Otro] := 3;
  Delta[1,Letra] := 1;
  Delta[1,Digito] := 1;
  Delta[1,Guion] := 1;
  Delta[1,Otro] := 2;
End;

Procedure AFConstEntera(Var delta: TipoDeltaEnt);
Begin
  Delta[0,GuionEnt] := 2;
  Delta[0,DigitoEnt] := 1;
  Delta[0,OtroEnt] := 5;
  Delta[1,GuionEnt] := 4;
  Delta[1,DigitoEnt] := 1;
  Delta[1,OtroEnt] := 4;
  Delta[2,GuionEnt] := 5;
  Delta[2,DigitoEnt] := 3;
  Delta[2,OtroEnt] := 5;
  Delta[3,GuionEnt] := 4;
  Delta[3,DigitoEnt] := 3;
  Delta[3,OtroEnt] := 4;
End;

Procedure AFConstReal(Var delta: TipoDeltaReal);
Begin
  Delta[0,GuionReal] := 1;
  Delta[0,DigitoReal] := 2;
  Delta[0,OtroReal] := 11;
  Delta[0,ComaReal] := 11;
  Delta[0,PuntoReal] := 11;
  Delta[1,GuionReal] := 11;
  Delta[1,DigitoReal] := 2;
  Delta[1,OtroReal] := 11;
  Delta[1,ComaReal] := 11;
  Delta[1,PuntoReal] := 11;
  Delta[2,GuionReal] := 11;
  Delta[2,DigitoReal] := 3;
  Delta[2,OtroReal] := 11;
  Delta[2,ComaReal] := 5;
  Delta[2,PuntoReal] := 6;
  Delta[3,GuionReal] := 11;
  Delta[3,DigitoReal] := 4;
  Delta[3,OtroReal] := 11;
  Delta[3,ComaReal] := 5;
  Delta[3,PuntoReal] := 6;
  Delta[4,GuionReal] := 11;
  Delta[4,DigitoReal] := 11;
  Delta[4,OtroReal] := 11;
  Delta[4,ComaReal] := 5;
  Delta[4,PuntoReal] := 6;
  Delta[5,GuionReal] := 11;
  Delta[5,DigitoReal] := 7;
  Delta[5,OtroReal] := 11;
  Delta[5,ComaReal] := 11;
  Delta[5,PuntoReal] := 11;
  Delta[6,GuionReal] := 11;
  Delta[6,DigitoReal] := 9;
  Delta[6,OtroReal] := 11;
  Delta[6,ComaReal] := 11;
  Delta[6,PuntoReal] := 11;
  Delta[7,GuionReal] := 11;
  Delta[7,DigitoReal] := 8;
  Delta[7,OtroReal] := 11;
  Delta[7,ComaReal] := 11;
  Delta[7,PuntoReal] := 11;
  Delta[8,GuionReal] := 11;
  Delta[8,DigitoReal] := 4;
  Delta[8,OtroReal] := 11;
  Delta[8,ComaReal] := 11;
  Delta[8,PuntoReal] := 11;
  Delta[9,GuionReal] := 10;
  Delta[9,DigitoReal] := 9;
  Delta[9,OtroReal] := 10;
  Delta[9,ComaReal] := 10;
  Delta[9,PuntoReal] := 10;
End;

Procedure AFConstCad(Var delta: TipoDeltaCadena);
Begin
  Delta[0,LetraCad] := 3;
  Delta[0,DigitoCad] := 3;
  Delta[0,Comilla] := 1;
  Delta[0,OtroCad] := 3;
  Delta[1,LetraCad] := 1;
  Delta[1,DigitoCad] := 1;
  Delta[1,Comilla] := 2;
  Delta[1,OtroCad] := 1;
  Delta[2,LetraCad] := 4;
  Delta[2,DigitoCad] := 4;
  Delta[2,Comilla] := 4;
  Delta[2,OtroCad] := 4;

End;
End.
