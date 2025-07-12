
Program leerTas;

Const 
  variables: array [1..27] Of string = ('tprogram', 'tasignacion',
                                        'tbloquevar', 'texp3', 'tcond',
                                        'texp', 'tcuerpo',
                                        'tciclica', 'tcondicional' , 'texp6'
                                        , 'tlistaexp', 'tlistadefvar',
                                        'texp7', 'texp4',
                                        'tlistadefvar2', 'tcond2',
                                        'tcondicional2', 'tcond5',
                                        'tlectura', 'tsentencia', 'texp2',
                                        'tcond3', 'tdefvar', 'tescritura',
                                        'tlistaexp2', 'ttype', 'tcond4');

  simb: array[1..32] Of string = ('program','{','}',';','var','id','Float',
                                  'String','oprel','while','(',')','if','read',
                                  'write','constreal','constcadena','substr',
                                  'find','long','-','+','*','/','^',',','&','!',
                                  '[','|',']','else');

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
