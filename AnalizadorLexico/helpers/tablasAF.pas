
Unit tablasAF;

Interface

Type 
  Sigma = (Letra, Digito, Guion, Otro);
  Q = 0..3;
  TipoDelta = Array[Q,Sigma] Of Q;

  SigmaReal = (DigitoReal, OtroReal, PuntoReal, MenosReal); // Agregado MenosReal para el signo negativo
  Qreal = 0..6; 
  // Aumentado el rango de Qreal para incluir el nuevo estado 6
  // y para manejar el caso del signo negativo  
  TipoDeltaReal = Array [Qreal, SigmaReal] Of Qreal;

  SigmaCadena = (Comilla, LetraCad, DigitoCad, OtroCad);
  QCadena = 0..4;
  TipoDeltaCadena = Array [QCadena, SigmaCadena] Of QCadena;

Procedure AFIdentificador(Var delta: TipoDelta);
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

Procedure AFConstReal(Var delta: TipoDeltaReal);
Begin
  Delta[0,MenosReal] := 6; // Nuevo estado para el signo menos
  Delta[0,DigitoReal] := 1;
  Delta[0,OtroReal] := 5;
  Delta[0,PuntoReal] := 5;

  Delta[6,DigitoReal] := 1; // Después del menos, debe venir un dígito
  Delta[6,OtroReal] := 5;
  Delta[6,PuntoReal] := 5;
  Delta[6,MenosReal] := 5;

  Delta[1,DigitoReal] := 1;
  Delta[1,OtroReal] := 4;
  Delta[1,PuntoReal] := 2;
  Delta[2,DigitoReal] := 3;
  Delta[2,OtroReal] := 5;
  Delta[2,PuntoReal] := 5;
  Delta[3,DigitoReal] := 3;
  Delta[3,OtroReal] := 4;
  Delta[3,PuntoReal] := 5;
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
