
Program analizadorSint;

Const 
  var_cant = 28;
  var_simb = 32;
  maxProduccion = 8;

Type 
  // t_elem_Pila = Record
  //   simb: t_simbolo_gramatical;
  //   nodo: t_arbol_derivacion;
  // End;

  TipoSimbGramCom = (Tid,Tcreal,Tcentera,Tccadena,Tparentesisabre,
                     Tparentisiscierra
                     ,Tmas,Tmenos,TProducto,T_division,Tptoycoma,
                     Tcoma,
                     Tpunto,Toperadorrealacional,
                     Toperadorasignacion,
                     ErrorLex, Pesos, TparReservada, T_llaveabre,
                     T_llavecierra, T_oplog, T_corchabre,
                     T_corchcierra,
                     Tpot);

  TipoVarPrograma = (Programa,Asignacion,BloqueVar,Exp3,Cond,Exp,Cuerpo,Ciclica,
                     Exp5,Condicional,Exp6,ListaExp,ListaDefVar,Exp7,Exp4,
                     ListaDefVar2,Cond2,Condicional2,Cond5,Lectura,Sentencia,
                     Exp2,Cond3,DefVar,Escritura,ListaExp2,Typo,Cond4);

  // t_pila = Record
  //   elem: array [1..maxPila] Of t_elem_Pila;
  //   tope: word;
  // End;

  t_produccion = Record
    elem: array [1..maxProduccion] Of TipoSimbGramCom;
    cant: byte;
  End;


  t_puntero_produccion =  ^t_produccion;

  tipo_TAS = array [TipoVarPrograma,TipoSimboloGramatical] Of ^t_produccion;

  // t_arbol_derivacion = ^t_nodo_arbol;
  // t_nodo_arbol = Record
  //   simbolo: t_simbolo_gramatical;
  //   Lexema: string;
  //   Hijos: array[1..max] Of t_arbol_derivacion;
  //   cant: byte;
  //cantidad de hijos.

  // End;

Begin
End.
