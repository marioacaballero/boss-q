
Program leerTas;

Const simb: array[1..32] Of string = ('program', '{', '}', ';', 'var', 'id',
                                      'Float', 'String', 'oprel', 'while', '(',
                                      ')', 'if', 'read', 'write', 'constreal',
                                      'constcadena', 'substr', 'find', 'long',
                                      '-', '+', '*', '/', '^', ',', '&', '!',
                                      '[', '|', ']', 'else');

Var 
  f: File Of char;
  i, j: byte;
  x: char;
  flag: Boolean;

Begin
  Assign(f, './TAS - Sheet1.csv');
  Reset(f);
  While Not Eof(f) Do
    Begin
      flag := true;
      i := 0;
      j := 0;
      While flag And (Not Eof(f)) Do
        Begin
          read(f, x);
          If (x = '~') Then inc(i)
          Else
            Begin
              If (j < i) Then
                Begin
                  write(' ',simb[i], '~ ');
                  j := i;
                End;
              If (x <> '"') Then
                Write(x);
            End;
          If (i = 33) Then
            Begin
              i := 0;
              flag := False;
            End;
        End;
    End;
End.
