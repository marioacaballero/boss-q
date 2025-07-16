
Unit unitInitTAS;

Interface

Const 
  maxProduccion = 8;

Type 
  TipoSimbGramCom = (T_llaveabre,Tprogram,Tvar,Tfind,TFloat,TString,Tlong,Tif,
                     Tsubstr,Telse,Twhile,Tread,Twrite,T_llavecierra,Tptoycoma,
                     Tid,T_dosp, T_igual,Toprel,Tparentesisabre,
                     Tparentisiscierra,Tcreal,Tccadena,Tmenos,Tmas,TProducto,
                     T_division,Tpot,Tcoma,Tand,Tnot,T_corchabre,Tor,
                     T_corchcierra,Topasig,Pesos,Programa,Asignacion,
                     BloqueVar,Exp3,Cond,Exp,Cuerpo,Ciclica,Exp5,Condicional,
                     Exp6,ListaExp,ListaDefVar,Exp7,Exp4,ListaDefVar2,Cond2,
                     Condicional2,Cond5,Lectura,Sentencia,Exp2,Cond3,DefVar,
                     Escritura,ListaExp2,Typo,Cond4,ErrorSint,ErrorLex);
  t_produccion = Record
    elem: array [1..maxProduccion] Of TipoSimbGramCom;
    cant: byte;
  End;

  t_puntero_produccion =  ^t_produccion;

  // tipo_TAS = array [TipoSimbGramCom,TipoSimbGramCom] Of ^t_produccion;
  tipo_TAS = array [Programa..Cond4,T_llaveabre..Pesos] Of ^t_produccion;

Procedure initTAS(Var TAS: tipo_TAS);

Implementation
Procedure initTAS(Var TAS: tipo_TAS);
Begin
  // Antes inicializar todos los valores de la matriz con nil
  // Programa
  New(TAS[Programa,Tprogram]);
  TAS[Programa,Tprogram]^.elem[1] := Tprogram;
  TAS[Programa,Tprogram]^.elem[2] := Tid;
  TAS[Programa,Tprogram]^.elem[3] := Tptoycoma;
  TAS[Programa,Tprogram]^.elem[4] := BloqueVar;
  TAS[Programa,Tprogram]^.elem[5] := T_llaveabre;
  TAS[Programa,Tprogram]^.elem[6] := Cuerpo;
  TAS[Programa,Tprogram]^.elem[7] := T_llavecierra;
  TAS[Programa,Tprogram]^.cant := 7;

  // Asignacion
  New(TAS[Asignacion,Tid]);
  TAS[Asignacion,Tid]^.elem[1] := Tid;
  TAS[Asignacion,Tid]^.elem[2] := Topasig;
  TAS[Asignacion,Tid]^.elem[3] := Exp;
  TAS[Asignacion,Tid]^.cant := 3;

  // Bloquevar
  New(TAS[BloqueVar,T_llaveabre]);
  TAS[BloqueVar,T_llaveabre]^.cant := 0;

  New(TAS[BloqueVar,Tvar]);
  TAS[BloqueVar,Tvar]^.elem[1] := Tvar;
  TAS[BloqueVar,Tvar]^.elem[2] := ListaDefVar;
  TAS[BloqueVar,Tvar]^.cant := 2;

  // Exp3
  New(TAS[Exp3, Tid]);
  TAS[Exp3, Tid]^.elem[1] := Exp4;
  TAS[Exp3, Tid]^.elem[2] := Exp7;
  TAS[Exp3, Tid]^.cant := 2;

  New(TAS[Exp3, Tparentesisabre]);
  TAS[Exp3, Tparentesisabre]^.elem[1] := Exp4;
  TAS[Exp3, Tparentesisabre]^.elem[2] := Exp7;
  TAS[Exp3, Tparentesisabre]^.cant := 2;

  New(TAS[Exp3, Tcreal]);
  TAS[Exp3, Tcreal]^.elem[1] := Exp4;
  TAS[Exp3, Tcreal]^.elem[2] := Exp7;
  TAS[Exp3, Tcreal]^.cant := 2;

  New(TAS[Exp3, Tccadena]);
  TAS[Exp3, Tccadena]^.elem[1] := Exp4;
  TAS[Exp3, Tccadena]^.elem[2] := Exp7;
  TAS[Exp3, Tccadena]^.cant := 2;

  New(TAS[Exp3, Tsubstr]);
  TAS[Exp3, Tsubstr]^.elem[1] := Exp4;
  TAS[Exp3, Tsubstr]^.elem[2] := Exp7;
  TAS[Exp3, Tsubstr]^.cant := 2;

  New(TAS[Exp3, Tfind]);
  TAS[Exp3, Tfind]^.elem[1] := Exp4;
  TAS[Exp3, Tfind]^.elem[2] := Exp7;
  TAS[Exp3, Tfind]^.cant := 2;

  New(TAS[Exp3, Tlong]);
  TAS[Exp3, Tlong]^.elem[1] := Exp4;
  TAS[Exp3, Tlong]^.elem[2] := Exp7;
  TAS[Exp3, Tlong]^.cant := 2;

  New(TAS[Exp3, Tmenos]);
  TAS[Exp3, Tmenos]^.elem[1] := Exp4;
  TAS[Exp3, Tmenos]^.elem[2] := Exp7;
  TAS[Exp3, Tmenos]^.cant := 2;

  //Cond
  New(TAS[Cond, Tid]);
  TAS[Cond, Tid]^.elem[1] := Cond2;
  TAS[Cond, Tid]^.elem[2] := Cond4;
  TAS[Cond, Tid]^.cant := 2;

  New(TAS[Cond, Tparentesisabre]);
  TAS[Cond, Tparentesisabre]^.elem[1] := Cond2;
  TAS[Cond, Tparentesisabre]^.elem[2] := Cond4;
  TAS[Cond, Tparentesisabre]^.cant := 2;

  New(TAS[Cond, Tcreal]);
  TAS[Cond, Tcreal]^.elem[1] := Cond2;
  TAS[Cond, Tcreal]^.elem[2] := Cond4;
  TAS[Cond, Tcreal]^.cant := 2;

  New(TAS[Cond, Tccadena]);
  TAS[Cond, Tccadena]^.elem[1] := Cond2;
  TAS[Cond, Tccadena]^.elem[2] := Cond4;
  TAS[Cond, Tccadena]^.cant := 2;

  New(TAS[Cond, Tsubstr]);
  TAS[Cond, Tsubstr]^.elem[1] := Cond2;
  TAS[Cond, Tsubstr]^.elem[2] := Cond4;
  TAS[Cond, Tsubstr]^.cant := 2;

  New(TAS[Cond, Tfind]);
  TAS[Cond, Tfind]^.elem[1] := Cond2;
  TAS[Cond, Tfind]^.elem[2] := Cond4;
  TAS[Cond, Tfind]^.cant := 2;

  New(TAS[Cond, Tlong]);
  TAS[Cond, Tlong]^.elem[1] := Cond2;
  TAS[Cond, Tlong]^.elem[2] := Cond4;
  TAS[Cond, Tlong]^.cant := 2;

  New(TAS[Cond, Tmenos]);
  TAS[Cond, Tmenos]^.elem[1] := Cond2;
  TAS[Cond, Tmenos]^.elem[2] := Cond4;
  TAS[Cond, Tmenos]^.cant := 2;

  New(TAS[Cond, Tnot]);
  TAS[Cond, Tnot]^.elem[1] := Cond2;
  TAS[Cond, Tnot]^.elem[2] := Cond4;
  TAS[Cond, Tnot]^.cant := 2;

  New(TAS[Cond, T_corchabre]);
  TAS[Cond, T_corchabre]^.elem[1] := Cond2;
  TAS[Cond, T_corchabre]^.elem[2] := Cond4;
  TAS[Cond, T_corchabre]^.cant := 2;

  // Exp
  New(TAS[Exp, Tid]);
  TAS[Exp, Tid]^.elem[1] := Exp2;
  TAS[Exp, Tid]^.elem[2] := Exp5;
  TAS[Exp, Tid]^.cant := 2;

  New(TAS[Exp, Tparentesisabre]);
  TAS[Exp, Tparentesisabre]^.elem[1] := Exp2;
  TAS[Exp, Tparentesisabre]^.elem[2] := Exp5;
  TAS[Exp, Tparentesisabre]^.cant := 2;

  New(TAS[Exp, Tcreal]);
  TAS[Exp, Tcreal]^.elem[1] := Exp2;
  TAS[Exp, Tcreal]^.elem[2] := Exp5;
  TAS[Exp, Tcreal]^.cant := 2;

  New(TAS[Exp, Tccadena]);
  TAS[Exp, Tccadena]^.elem[1] := Exp2;
  TAS[Exp, Tccadena]^.elem[2] := Exp5;
  TAS[Exp, Tccadena]^.cant := 2;

  New(TAS[Exp, Tsubstr]);
  TAS[Exp, Tsubstr]^.elem[1] := Exp2;
  TAS[Exp, Tsubstr]^.elem[2] := Exp5;
  TAS[Exp, Tsubstr]^.cant := 2;

  New(TAS[Exp, Tfind]);
  TAS[Exp, Tfind]^.elem[1] := Exp2;
  TAS[Exp, Tfind]^.elem[2] := Exp5;
  TAS[Exp, Tfind]^.cant := 2;

  New(TAS[Exp, Tlong]);
  TAS[Exp, Tlong]^.elem[1] := Exp2;
  TAS[Exp, Tlong]^.elem[2] := Exp5;
  TAS[Exp, Tlong]^.cant := 2;

  New(TAS[Exp, Tmenos]);
  TAS[Exp, Tmenos]^.elem[1] := Exp2;
  TAS[Exp, Tmenos]^.elem[2] := Exp5;
  TAS[Exp, Tmenos]^.cant := 2;

    // Cuerpo
  
  New(TAS[Cuerpo, T_llaveabre]);
  TAS[Cuerpo, T_llaveabre]^.cant := 0;
  
  New(TAS[Cuerpo, T_llavecierra]);
  TAS[Cuerpo, T_llavecierra]^.cant := 0;

  New(TAS[Cuerpo, Toprel]);
  TAS[Cuerpo, Toprel]^.cant := 0;

  New(TAS[Cuerpo, Tparentisiscierra]);
  TAS[Cuerpo, Tparentisiscierra]^.cant := 0;

  New(TAS[Cuerpo, Tmenos]);
  TAS[Cuerpo, Tmenos]^.cant := 0;
  
  New(TAS[Cuerpo, Tmas]);
  TAS[Cuerpo, Tmas]^.cant := 0;

  New(TAS[Cuerpo, TProducto]);
  TAS[Cuerpo, TProducto]^.cant := 0;

  New(TAS[Cuerpo, T_division]);
  TAS[Cuerpo, T_division]^.cant := 0;

    New(TAS[Cuerpo, Tcoma]);
  TAS[Cuerpo, Tcoma]^.cant := 0;
  
  New(TAS[Cuerpo, Tand]);
  TAS[Cuerpo, Tand]^.cant := 0;

  New(TAS[Cuerpo, Tor]);
  TAS[Cuerpo, Tor]^.cant := 0;

  New(TAS[Cuerpo, T_corchcierra]);
  TAS[Cuerpo, T_corchcierra]^.cant := 0;

  New(TAS[Cuerpo, Tid]);
  TAS[Cuerpo, Tid]^.elem[1] := Sentencia;
  TAS[Cuerpo, Tid]^.elem[2] := Tptoycoma;
  TAS[Cuerpo, Tid]^.elem[3] := Cuerpo;
  TAS[Cuerpo, Tid]^.cant := 3;

  New(TAS[Cuerpo, Twhile]);
  TAS[Cuerpo, Twhile]^.elem[1] := Sentencia;
  TAS[Cuerpo, Twhile]^.elem[2] := Tptoycoma;
  TAS[Cuerpo, Twhile]^.elem[3] := Cuerpo;
  TAS[Cuerpo, Twhile]^.cant := 3;

  New(TAS[Cuerpo, Tif]);
  TAS[Cuerpo, Tif]^.elem[1] := Sentencia;
  TAS[Cuerpo, Tif]^.elem[2] := Tptoycoma;
  TAS[Cuerpo, Tif]^.elem[3] := Cuerpo;
  TAS[Cuerpo, Tif]^.cant := 3;

  New(TAS[Cuerpo, Tread]);
  TAS[Cuerpo, Tread]^.elem[1] := Sentencia;
  TAS[Cuerpo, Tread]^.elem[2] := Tptoycoma;
  TAS[Cuerpo, Tread]^.elem[3] := Cuerpo;
  TAS[Cuerpo, Tread]^.cant := 3;

  New(TAS[Cuerpo, Twrite]);
  TAS[Cuerpo, Twrite]^.elem[1] := Sentencia;
  TAS[Cuerpo, Twrite]^.elem[2] := Tptoycoma;
  TAS[Cuerpo, Twrite]^.elem[3] := Cuerpo;
  TAS[Cuerpo, Twrite]^.cant := 3;

  // Ciclica
  New(TAS[Ciclica, Twhile]);
  TAS[Ciclica, Twhile]^.elem[1] := Twhile;
  TAS[Ciclica, Twhile]^.elem[2] := Cond;
  TAS[Ciclica, Twhile]^.elem[3] := T_llaveabre;
  TAS[Ciclica, Twhile]^.elem[4] := Cuerpo;
  TAS[Ciclica, Twhile]^.elem[5] := T_llavecierra;
  TAS[Ciclica, Twhile]^.cant := 5;

  // Exp5
  New(TAS[Exp5, T_llaveabre]);
  TAS[Exp5, T_llaveabre]^.cant := 0;
  
  New(TAS[Exp5, Tptoycoma]);
  TAS[Exp5, Tptoycoma]^.cant := 0;

  New(TAS[Exp5, Toprel]);
  TAS[Exp5, Toprel]^.cant := 0;

  New(TAS[Exp5, Tparentisiscierra]);
  TAS[Exp5, Tparentisiscierra]^.cant := 0;

  New(TAS[Exp5, Tcoma]);
  TAS[Exp5, Tcoma]^.cant := 0;
  
  New(TAS[Exp5, Tand]);
  TAS[Exp5, Tand]^.cant := 0;

  New(TAS[Exp5, Tor]);
  TAS[Exp5, Tor]^.cant := 0;

  New(TAS[Exp5, T_corchcierra]);
  TAS[Exp5, T_corchcierra]^.cant := 0;

  New(TAS[Exp5, Tmenos]);
  TAS[Exp5, Tmenos]^.elem[1] := Tmenos;
  TAS[Exp5, Tmenos]^.elem[2] := Exp2;
  TAS[Exp5, Tmenos]^.elem[3] := Exp5;
  TAS[Exp5, Tmenos]^.cant := 3;

  New(TAS[Exp5, Tmas]);
  TAS[Exp5, Tmas]^.elem[1] := Tmas;
  TAS[Exp5, Tmas]^.elem[2] := Exp2;
  TAS[Exp5, Tmas]^.elem[3] := Exp5;
  TAS[Exp5, Tmas]^.cant := 3;

  // Condicional
  New(TAS[Condicional, Tif]);
  TAS[Condicional, Tif]^.elem[1] := Tif;
  TAS[Condicional, Tif]^.elem[2] := Cond;
  TAS[Condicional, Tif]^.elem[3] := T_llaveabre;
  TAS[Condicional, Tif]^.elem[4] := Cuerpo;
  TAS[Condicional, Tif]^.elem[5] := T_llavecierra;
  TAS[Condicional, Tif]^.elem[6] := Condicional2;
  TAS[Condicional, Tif]^.cant := 6;

  // Exp6
  New(TAS[Exp6, T_llaveabre]);
  TAS[Exp6, T_llaveabre]^.cant := 0;
  
  New(TAS[Exp6, Tptoycoma]);
  TAS[Exp6, Tptoycoma]^.cant := 0;

  New(TAS[Exp6, Toprel]);
  TAS[Exp6, Toprel]^.cant := 0;

  New(TAS[Exp6, Tparentisiscierra]);
  TAS[Exp6, Tparentisiscierra]^.cant := 0;

  New(TAS[Exp6, Tmenos]);
  TAS[Exp6, Tmenos]^.cant := 0;

  New(TAS[Exp6, Tmas]);
  TAS[Exp6, Tmas]^.cant := 0;

  New(TAS[Exp6, Tcoma]);
  TAS[Exp6, Tcoma]^.cant := 0;

  New(TAS[Exp6, Tand]);
  TAS[Exp6, Tand]^.cant := 0;

  New(TAS[Exp6, Tor]);
  TAS[Exp6, Tor]^.cant := 0;

  New(TAS[Exp6, T_corchcierra]);
  TAS[Exp6, T_corchcierra]^.cant := 0;

  New(TAS[Exp6, TProducto]);
  TAS[Exp6, TProducto]^.elem[1] := TProducto;
  TAS[Exp6, TProducto]^.elem[2] := Exp3;
  TAS[Exp6, TProducto]^.elem[3] := Exp6;
  TAS[Exp6, TProducto]^.cant := 3;

  New(TAS[Exp6, T_division]);
  TAS[Exp6, T_division]^.elem[1] := T_division;
  TAS[Exp6, T_division]^.elem[2] := Exp3;
  TAS[Exp6, T_division]^.elem[3] := Exp6;
  TAS[Exp6, T_division]^.cant := 3;

  // ListaExp
  New(TAS[ListaExp, Tid]);
  TAS[ListaExp, Tid]^.elem[1] := Exp;
  TAS[ListaExp, Tid]^.elem[2] := ListaExp2;
  TAS[ListaExp, Tid]^.cant := 2;

  New(TAS[ListaExp, Tparentesisabre]);
  TAS[ListaExp, Tparentesisabre]^.elem[1] := Exp;
  TAS[ListaExp, Tparentesisabre]^.elem[2] := ListaExp2;
  TAS[ListaExp, Tparentesisabre]^.cant := 2;

  New(TAS[ListaExp, Tcreal]);
  TAS[ListaExp, Tcreal]^.elem[1] := Exp;
  TAS[ListaExp, Tcreal]^.elem[2] := ListaExp2;
  TAS[ListaExp, Tcreal]^.cant := 2;

  New(TAS[ListaExp, Tccadena]);
  TAS[ListaExp, Tccadena]^.elem[1] := Exp;
  TAS[ListaExp, Tccadena]^.elem[2] := ListaExp2;
  TAS[ListaExp, Tccadena]^.cant := 2;

  New(TAS[ListaExp, Tsubstr]);
  TAS[ListaExp, Tsubstr]^.elem[1] := Exp;
  TAS[ListaExp, Tsubstr]^.elem[2] := ListaExp2;
  TAS[ListaExp, Tsubstr]^.cant := 2;

  New(TAS[ListaExp, Tfind]);
  TAS[ListaExp, Tfind]^.elem[1] := Exp;
  TAS[ListaExp, Tfind]^.elem[2] := ListaExp2;
  TAS[ListaExp, Tfind]^.cant := 2;

  New(TAS[ListaExp, Tlong]);
  TAS[ListaExp, Tlong]^.elem[1] := Exp;
  TAS[ListaExp, Tlong]^.elem[2] := ListaExp2;
  TAS[ListaExp, Tlong]^.cant := 2;

  New(TAS[ListaExp, Tmenos]);
  TAS[ListaExp, Tmenos]^.elem[1] := Exp;
  TAS[ListaExp, Tmenos]^.elem[2] := ListaExp2;
  TAS[ListaExp, Tmenos]^.cant := 2;

  // ListaDefVar
  New(TAS[ListaDefVar, Tid]);
  TAS[ListaDefVar, Tid]^.elem[1] := DefVar;
  TAS[ListaDefVar, Tid]^.elem[2] := Tptoycoma;
  TAS[ListaDefVar, Tid]^.elem[3] := ListaDefVar2;
  TAS[ListaDefVar, Tid]^.cant := 3;

  // Exp7
  New(TAS[Exp7, T_llaveabre]);
  TAS[Exp7, T_llaveabre]^.cant := 0;

  New(TAS[Exp7, T_llavecierra]);
  TAS[Exp7, T_llavecierra]^.cant := 0;

  New(TAS[Exp7, Tptoycoma]);
  TAS[Exp7, Tptoycoma]^.cant := 0;

    New(TAS[Exp7, Tid]);
  TAS[Exp7, Tid]^.cant := 0;

  New(TAS[Exp7, Toprel]);
  TAS[Exp7, Toprel]^.cant := 0;

  New(TAS[Exp7, Twhile]);
  TAS[Exp7, Twhile]^.cant := 0;

  New(TAS[Exp7, Tparentisiscierra]);
  TAS[Exp7, Tparentisiscierra]^.cant := 0;

  New(TAS[Exp7, Tif]);
  TAS[Exp7, Tif]^.cant := 0;

  New(TAS[Exp7, Tread]);
  TAS[Exp7, Tread]^.cant := 0;

  New(TAS[Exp7, Twrite]);
  TAS[Exp7, Twrite]^.cant := 0;

  New(TAS[Exp7, Tmenos]);
  TAS[Exp7, Tmenos]^.cant := 0;

  New(TAS[Exp7, Tmas]);
  TAS[Exp7, Tmas]^.cant := 0;

  New(TAS[Exp7, Tcoma]);
  TAS[Exp7, Tcoma]^.cant := 0;

  New(TAS[Exp7, TProducto]);
  TAS[Exp7, TProducto]^.cant := 0;

  New(TAS[Exp7, T_division]);
  TAS[Exp7, T_division]^.cant := 0;

  New(TAS[Exp7, Tand]);
  TAS[Exp7, Tand]^.cant := 0;

  New(TAS[Exp7, Tor]);
  TAS[Exp7, Tor]^.cant := 0;

  New(TAS[Exp7, T_corchcierra]);
  TAS[Exp7, T_corchcierra]^.cant := 0;

  New(TAS[Exp7, Tpot]);
  TAS[Exp7, Tpot]^.elem[1] := Tpot;
  TAS[Exp7, Tpot]^.elem[2] := Exp4;
  TAS[Exp7, Tpot]^.elem[3] := Exp7;
  TAS[Exp7, Tpot]^.cant := 3;

  // Exp4
  New(TAS[Exp4, Tid]);
  TAS[Exp4, Tid]^.elem[1] := Tid;
  TAS[Exp4, Tid]^.cant := 1;

  New(TAS[Exp4, Tparentesisabre]);
  TAS[Exp4, Tparentesisabre]^.elem[1] := Tparentesisabre;
  TAS[Exp4, Tparentesisabre]^.elem[2] := Exp;
  TAS[Exp4, Tparentesisabre]^.elem[3] := Tparentisiscierra;
  TAS[Exp4, Tparentesisabre]^.cant := 3;

  New(TAS[Exp4, Tcreal]);
  TAS[Exp4, Tcreal]^.elem[1] := Tcreal;
  TAS[Exp4, Tcreal]^.cant := 1;

  New(TAS[Exp4, Tccadena]);
  TAS[Exp4, Tccadena]^.elem[1] := Tccadena;
  TAS[Exp4, Tccadena]^.cant := 1;

  New(TAS[Exp4, Tsubstr]);
  TAS[Exp4, Tsubstr]^.elem[1] := Tsubstr;
  TAS[Exp4, Tsubstr]^.elem[2] := Tparentesisabre;
  TAS[Exp4, Tsubstr]^.elem[3] := Exp;
  TAS[Exp4, Tsubstr]^.elem[4] := Tcoma;
  TAS[Exp4, Tsubstr]^.elem[5] := Exp;
  TAS[Exp4, Tsubstr]^.elem[6] := Tcoma;
  TAS[Exp4, Tsubstr]^.elem[7] := Exp;
  TAS[Exp4, Tsubstr]^.elem[8] := Tparentisiscierra;
  TAS[Exp4, Tsubstr]^.cant := 8;

  New(TAS[Exp4, Tfind]);
  TAS[Exp4, Tfind]^.elem[1] := Tfind;
  TAS[Exp4, Tfind]^.elem[2] := Tparentesisabre;
  TAS[Exp4, Tfind]^.elem[3] := Exp;
  TAS[Exp4, Tfind]^.elem[4] := Tcoma;
  TAS[Exp4, Tfind]^.elem[5] := Exp;
  TAS[Exp4, Tfind]^.elem[6] := Tparentisiscierra;
  TAS[Exp4, Tfind]^.cant := 6;

  New(TAS[Exp4, Tlong]);
  TAS[Exp4, Tlong]^.elem[1] := Tlong;
  TAS[Exp4, Tlong]^.elem[2] := Tparentesisabre;
  TAS[Exp4, Tlong]^.elem[3] := Exp;
  TAS[Exp4, Tlong]^.elem[4] := Tparentisiscierra;
  TAS[Exp4, Tlong]^.cant := 4;

  New(TAS[Exp4, Tmenos]);
  TAS[Exp4, Tmenos]^.elem[1] := Tmenos;
  TAS[Exp4, Tmenos]^.elem[2] := Exp4;
  TAS[Exp4, Tmenos]^.cant := 2;

  // ListaDefVar2
  New(TAS[ListaDefVar2, T_llaveabre]);
  TAS[ListaDefVar2, T_llaveabre]^.cant := 0;

  New(TAS[ListaDefVar2, Tid]);
  TAS[ListaDefVar2, Tid]^.elem[1] := ListaDefVar;
  TAS[ListaDefVar2, Tid]^.cant := 1;

  // Cond2
  New(TAS[Cond2, Tid]);
  TAS[Cond2, Tid]^.elem[1] := Cond3;
  TAS[Cond2, Tid]^.elem[2] := Cond5;
  TAS[Cond2, Tid]^.cant := 2;

  New(TAS[Cond2, Tparentesisabre]);
  TAS[Cond2, Tparentesisabre]^.elem[1] := Cond3;
  TAS[Cond2, Tparentesisabre]^.elem[2] := Cond5;
  TAS[Cond2, Tparentesisabre]^.cant := 2;

  New(TAS[Cond2, Tcreal]);
  TAS[Cond2, Tcreal]^.elem[1] := Cond3;
  TAS[Cond2, Tcreal]^.elem[2] := Cond5;
  TAS[Cond2, Tcreal]^.cant := 2;

  New(TAS[Cond2, Tccadena]);
  TAS[Cond2, Tccadena]^.elem[1] := Cond3;
  TAS[Cond2, Tccadena]^.elem[2] := Cond5;
  TAS[Cond2, Tccadena]^.cant := 2;

  New(TAS[Cond2, Tsubstr]);
  TAS[Cond2, Tsubstr]^.elem[1] := Cond3;
  TAS[Cond2, Tsubstr]^.elem[2] := Cond5;
  TAS[Cond2, Tsubstr]^.cant := 2;

  New(TAS[Cond2, Tfind]);
  TAS[Cond2, Tfind]^.elem[1] := Cond3;
  TAS[Cond2, Tfind]^.elem[2] := Cond5;
  TAS[Cond2, Tfind]^.cant := 2;

  New(TAS[Cond2, Tlong]);
  TAS[Cond2, Tlong]^.elem[1] := Cond3;
  TAS[Cond2, Tlong]^.elem[2] := Cond5;
  TAS[Cond2, Tlong]^.cant := 2;

  New(TAS[Cond2, Tmenos]);
  TAS[Cond2, Tmenos]^.elem[1] := Cond3;
  TAS[Cond2, Tmenos]^.elem[2] := Cond5;
  TAS[Cond2, Tmenos]^.cant := 2;

  New(TAS[Cond2, Tnot]);
  TAS[Cond2, Tnot]^.elem[1] := Cond3;
  TAS[Cond2, Tnot]^.elem[2] := Cond5;
  TAS[Cond2, Tnot]^.cant := 2;

  New(TAS[Cond2, T_corchabre]);
  TAS[Cond2, T_corchabre]^.elem[1] := Cond3;
  TAS[Cond2, T_corchabre]^.elem[2] := Cond5;
  TAS[Cond2, T_corchabre]^.cant := 2;

  // Condicional2
  New(TAS[Condicional2, Tptoycoma]);
  TAS[Condicional2, Tptoycoma]^.cant := 0;

  New(TAS[Condicional2, Telse]);
  TAS[Condicional2, Telse]^.elem[1] := Telse;
  TAS[Condicional2, Telse]^.elem[2] := T_llaveabre;
  TAS[Condicional2, Telse]^.elem[3] := Cuerpo;
  TAS[Condicional2, Telse]^.elem[4] := T_llavecierra;
  TAS[Condicional2, Telse]^.cant := 4;

  // Cond5
  New(TAS[Cond5, T_llaveabre]);
  TAS[Cond5, T_llaveabre]^.cant := 0;

  New(TAS[Cond5, Tor]);
  TAS[Cond5, Tor]^.cant := 0;

  New(TAS[Cond5, T_corchcierra]);
  TAS[Cond5, T_corchcierra]^.cant := 0;

  New(TAS[Cond5, Tand]);
  TAS[Cond5, Tand]^.elem[1] := Tand;
  TAS[Cond5, Tand]^.elem[2] := Cond3;
  TAS[Cond5, Tand]^.elem[3] := Cond5;
  TAS[Cond5, Tand]^.cant := 3;

  // Lectura
  New(TAS[Lectura, Tread]);
  TAS[Lectura, Tread]^.elem[1] := Tread;
  TAS[Lectura, Tread]^.elem[2] := Tparentesisabre;
  TAS[Lectura, Tread]^.elem[3] := Exp;
  TAS[Lectura, Tread]^.elem[4] := Tcoma;
  TAS[Lectura, Tread]^.elem[5] := Tid;
  TAS[Lectura, Tread]^.elem[6] := Tparentisiscierra;
  TAS[Lectura, Tread]^.cant := 6;

  // Sentencia
  New(TAS[Sentencia, Tid]);
  TAS[Sentencia, Tid]^.elem[1] := Asignacion;
  TAS[Sentencia, Tid]^.cant := 1;

  New(TAS[Sentencia, Twhile]);
  TAS[Sentencia, Twhile]^.elem[1] := Ciclica;
  TAS[Sentencia, Twhile]^.cant := 1;

  New(TAS[Sentencia, Tif]);
  TAS[Sentencia, Tif]^.elem[1] := Condicional;
  TAS[Sentencia, Tif]^.cant := 1;

  New(TAS[Sentencia, Tread]);
  TAS[Sentencia, Tread]^.elem[1] := Lectura;
  TAS[Sentencia, Tread]^.cant := 1;

  New(TAS[Sentencia, Twrite]);
  TAS[Sentencia, Twrite]^.elem[1] := Escritura;
  TAS[Sentencia, Twrite]^.cant := 1;

  // Exp2
  New(TAS[Exp2, Tid]);
  TAS[Exp2, Tid]^.elem[1] := Exp3;
  TAS[Exp2, Tid]^.elem[2] := Exp6;
  TAS[Exp2, Tid]^.cant := 2;

  New(TAS[Exp2, Tparentesisabre]);
  TAS[Exp2, Tparentesisabre]^.elem[1] := Exp3;
  TAS[Exp2, Tparentesisabre]^.elem[2] := Exp6;
  TAS[Exp2, Tparentesisabre]^.cant := 2;

  New(TAS[Exp2, Tcreal]);
  TAS[Exp2, Tcreal]^.elem[1] := Exp3;
  TAS[Exp2, Tcreal]^.elem[2] := Exp6;
  TAS[Exp2, Tcreal]^.cant := 2;

  New(TAS[Exp2, Tccadena]);
  TAS[Exp2, Tccadena]^.elem[1] := Exp3;
  TAS[Exp2, Tccadena]^.elem[2] := Exp6;
  TAS[Exp2, Tccadena]^.cant := 2;

  New(TAS[Exp2, Tsubstr]);
  TAS[Exp2, Tsubstr]^.elem[1] := Exp3;
  TAS[Exp2, Tsubstr]^.elem[2] := Exp6;
  TAS[Exp2, Tsubstr]^.cant := 2;

  New(TAS[Exp2, Tfind]);
  TAS[Exp2, Tfind]^.elem[1] := Exp3;
  TAS[Exp2, Tfind]^.elem[2] := Exp6;
  TAS[Exp2, Tfind]^.cant := 2;

  New(TAS[Exp2, Tlong]);
  TAS[Exp2, Tlong]^.elem[1] := Exp3;
  TAS[Exp2, Tlong]^.elem[2] := Exp6;
  TAS[Exp2, Tlong]^.cant := 2;

  New(TAS[Exp2, Tmenos]);
  TAS[Exp2, Tmenos]^.elem[1] := Exp3;
  TAS[Exp2, Tmenos]^.elem[2] := Exp6;
  TAS[Exp2, Tmenos]^.cant := 2;

  New(TAS[Exp2, Tnot]);
  TAS[Exp2, Tnot]^.elem[1] := Tnot;
  TAS[Exp2, Tnot]^.elem[2] := Cond3;
  TAS[Exp2, Tnot]^.cant := 2;

  New(TAS[Exp2, T_corchabre]);
  TAS[Exp2, T_corchabre]^.elem[1] := T_corchabre;
  TAS[Exp2, T_corchabre]^.elem[2] := Cond;
  TAS[Exp2, T_corchabre]^.elem[3] := T_corchcierra;
  TAS[Exp2, T_corchabre]^.cant := 3;

  // Cond3
  New(TAS[Cond3, Tid]);
  TAS[Cond3, Tid]^.elem[1] := Exp;
  TAS[Cond3, Tid]^.elem[2] := Toprel;
  TAS[Cond3, Tid]^.elem[3] := Exp;
  TAS[Cond3, Tid]^.cant := 3;

  New(TAS[Cond3, Tparentesisabre]);
  TAS[Cond3, Tparentesisabre]^.elem[1] := Exp;
  TAS[Cond3, Tparentesisabre]^.elem[2] := Toprel;
  TAS[Cond3, Tparentesisabre]^.elem[3] := Exp;
  TAS[Cond3, Tparentesisabre]^.cant := 3;

  New(TAS[Cond3, Tcreal]);
  TAS[Cond3, Tcreal]^.elem[1] := Exp;
  TAS[Cond3, Tcreal]^.elem[2] := Toprel;
  TAS[Cond3, Tcreal]^.elem[3] := Exp;
  TAS[Cond3, Tcreal]^.cant := 3;

  New(TAS[Cond3, Tccadena]);
  TAS[Cond3, Tccadena]^.elem[1] := Exp;
  TAS[Cond3, Tccadena]^.elem[2] := Toprel;
  TAS[Cond3, Tccadena]^.elem[3] := Exp;
  TAS[Cond3, Tccadena]^.cant := 3;

  New(TAS[Cond3, Tsubstr]);
  TAS[Cond3, Tsubstr]^.elem[1] := Exp;
  TAS[Cond3, Tsubstr]^.elem[2] := Toprel;
  TAS[Cond3, Tsubstr]^.elem[3] := Exp;
  TAS[Cond3, Tsubstr]^.cant := 3;

  New(TAS[Cond3, Tfind]);
  TAS[Cond3, Tfind]^.elem[1] := Exp;
  TAS[Cond3, Tfind]^.elem[2] := Toprel;
  TAS[Cond3, Tfind]^.elem[3] := Exp;
  TAS[Cond3, Tfind]^.cant := 3;

  New(TAS[Cond3, Tlong]);
  TAS[Cond3, Tlong]^.elem[1] := Exp;
  TAS[Cond3, Tlong]^.elem[2] := Toprel;
  TAS[Cond3, Tlong]^.elem[3] := Exp;
  TAS[Cond3, Tlong]^.cant := 3;

  New(TAS[Cond3, Tmenos]);
  TAS[Cond3, Tmenos]^.elem[1] := Exp;
  TAS[Cond3, Tmenos]^.elem[2] := Toprel;
  TAS[Cond3, Tmenos]^.elem[3] := Exp;
  TAS[Cond3, Tmenos]^.cant := 3;

  // DefVar
  New(TAS[DefVar, Tid]);
  TAS[DefVar, Tid]^.elem[1] := Tid;
  TAS[DefVar, Tid]^.elem[2] := T_dosp;
  TAS[DefVar, Tid]^.elem[3] := Typo;
  TAS[DefVar, Tid]^.cant := 3;

  // Escritura
  New(TAS[Escritura, Twrite]);
  TAS[Escritura, Twrite]^.elem[1] := Twrite;
  TAS[Escritura, Twrite]^.elem[2] := Tparentesisabre;
  TAS[Escritura, Twrite]^.elem[3] := ListaExp;
  TAS[Escritura, Twrite]^.elem[4] := Tparentisiscierra;
  TAS[Escritura, Twrite]^.cant := 4;

  // ListaExp2
  New(TAS[ListaExp2, Tparentisiscierra]);
  TAS[ListaExp2, Tparentisiscierra]^.cant := 0;

  New(TAS[ListaExp2, Tcoma]);
  TAS[ListaExp2, Tcoma]^.elem[1] := Tcoma;
  TAS[ListaExp2, Tcoma]^.elem[2] := Exp;
  TAS[ListaExp2, Tcoma]^.elem[3] := ListaExp2;
  TAS[ListaExp2, Tcoma]^.cant := 3;

  // Typo
  New(TAS[Typo, TFloat]);
  TAS[Typo, TFloat]^.elem[1] := TFloat;
  TAS[Typo, TFloat]^.cant := 1;

  New(TAS[Typo, TString]);
  TAS[Typo, TString]^.elem[1] := TString;
  TAS[Typo, TString]^.cant := 1;

  // Cond4
  New(TAS[Cond4, T_llaveabre]);
  TAS[Cond4, T_llaveabre]^.cant := 0;

  New(TAS[Cond4, T_corchcierra]);
  TAS[Cond4, T_corchcierra]^.cant := 0;

  New(TAS[Cond4, Tor]);
  TAS[Cond4, Tor]^.elem[1] := Tor;
  TAS[Cond4, Tor]^.elem[2] := Cond2;
  TAS[Cond4, Tor]^.elem[3] := Cond4;
  TAS[Cond4, Tor]^.cant := 3;
End;

End.
