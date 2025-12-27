// ============================================================================
// DIRETIVAS COMPLETAS PARA TRADUÇÃO DELPHI/PASCAL PARA XHARBOUR
// ============================================================================

// ----------------------------------------------------------------------------
// ESTRUTURA DO PROGRAMA
// ----------------------------------------------------------------------------
#command program <name>; => // Programa <name>
#command unit <name>; => // Unidade <name>
#command interface => // Interface
#command implementation => // Implementação
#command uses <units,...>; => #include "<units>.ch"
#command {$R *.dfm} => // Recursos do formulário
#command {$R *.res} => // Recursos
#command {$MODE DELPHI} => // Modo Delphi
#command {$APPTYPE CONSOLE} => // Aplicação console
#command {$APPTYPE GUI} => // Aplicação GUI

// ----------------------------------------------------------------------------
// COMENTÁRIOS
// ----------------------------------------------------------------------------
#command // <comment> => // <comment>
#command { <comment> } => /* <comment> */
#command (* <comment> *) => /* <comment> */

// ----------------------------------------------------------------------------
// SEÇÃO DE TIPOS
// ----------------------------------------------------------------------------
#command type => // TIPOS
#command = type => // definição de tipo

// Tipos básicos
#translate Integer => NUMERIC
#translate Cardinal => NUMERIC
#translate LongInt => NUMERIC
#translate Int64 => NUMERIC
#translate Word => NUMERIC
#translate Byte => NUMERIC
#translate ShortInt => NUMERIC
#translate SmallInt => NUMERIC
#translate Single => NUMERIC
#translate Double => NUMERIC
#translate Real => NUMERIC
#translate Extended => NUMERIC
#translate Currency => NUMERIC
#translate Comp => NUMERIC
#translate Boolean => LOGICAL
#translate ByteBool => LOGICAL
#translate WordBool => LOGICAL
#translate LongBool => LOGICAL
#translate Char => CHARACTER
#translate AnsiChar => CHARACTER
#translate WideChar => CHARACTER
#translate String => CHARACTER
#translate AnsiString => CHARACTER
#translate WideString => CHARACTER
#translate ShortString => CHARACTER
#translate PChar => CHARACTER
#translate Pointer => // Ponteiro
#translate Variant => // Variant
#translate OleVariant => // OleVariant

// ----------------------------------------------------------------------------
// DECLARAÇÕES DE TIPOS
// ----------------------------------------------------------------------------
#command <type1> = <type2>; => #define <type1> <type2>
#command <name> = <type>; => // alias <name> para <type>

// Tipos enumerados
#command (<values,...>); => // enumerado: <values>
#command T<Name> = (<values,...>); => // enumerado T<Name>

// Intervalos
#command <min>..<max> => // intervalo de <min> a <max>
#command T<Name> = <min>..<max>; => // tipo intervalo T<Name>

// Conjuntos
#command set of <type> => // conjunto de <type>
#command T<Name> = set of <type>; => // conjunto T<Name>

// Arrays
#command array[<index>] of <type> => ARRAY
#command array[<index1>, <index2>] of <type> => ARRAY 2D
#command T<Name> = array[<index>] of <type>; => // array T<Name>
#command T<Name> = array of <type>; => // array dinâmico T<Name>

// Registros (structs)
#command record => CLASS
#command end; => ENDCLASS
#command T<Name> = record => CLASS T<Name>
#command case <tag>: <type> of => // variant record

// Ponteiros
#command ^<type> => // ponteiro para <type>
#command P<Name> = ^T<Name>; => // ponteiro P<Name>

// Procedimentos e funções como tipos
#command procedure(<params>) => BLOCK
#command function(<params>): <rettype> => BLOCK
#command T<Name> = procedure(<params>); => // procedimento T<Name>
#command T<Name> = function(<params>): <rettype>; => // função T<Name>

// Classes
#command class(<parent>) => CLASS FROM <parent>
#command class => CLASS
#command T<Name> = class => CLASS T<Name>
#command T<Name> = class(<parent>) => CLASS T<Name> FROM <parent>

// Interfaces
#command interface => // interface
#command I<Name> = interface => // interface I<Name>
#command GUID '<guid>' => // GUID

// ----------------------------------------------------------------------------
// CONSTANTES
// ----------------------------------------------------------------------------
#command const => // CONSTANTES
#command <name> = <value>; => #define <name> <value>
#command <name>: <type> = <value>; => #define <name> <value>
#command ResourceString => // Strings de recurso

// Constantes especiais
#translate nil => NIL
#translate True => .T.
#translate False => .F.
#translate MAXINT => 2147483647
#translate MAXLONGINT => 2147483647

// ----------------------------------------------------------------------------
// VARIÁVEIS
// ----------------------------------------------------------------------------
#command var => // VARIÁVEIS
#command threadvar => // Variáveis de thread
#command <vars>: <type>; => LOCAL <vars> // <type>
#command <vars>: <type> = <value>; => LOCAL <vars> := <value> // <type>
#command <var1>, <var2>: <type>; => LOCAL <var1>, <var2> // <type>
#command absolute <address> => // variável absoluta

// ----------------------------------------------------------------------------
// PROCEDIMENTOS E FUNÇÕES
// ----------------------------------------------------------------------------
#command procedure <name>([<params>]); => PROCEDURE <name>([<params>])
#command function <name>([<params>]): <rettype>; => FUNCTION <name>([<params>]) AS <rettype>
#command begin => // BEGIN
#command end; => // END
#command exit => RETURN
#command Result => _RETURN
#command inherited => ::Super
#command self => ::Self
#command constructor Create([<params>]); => METHOD New([<params>]) CLASS <ClassName>
#command destructor Destroy; override; => METHOD Destroy() CLASS <ClassName>
#command override => // override
#command overload => // overload
#command virtual => // virtual
#command dynamic => // dynamic
#command abstract => // abstract
#command reintroduce => // reintroduce
#command stdcall => // calling convention
#command cdecl => // calling convention
#command pascal => // calling convention
#command register => // calling convention
#command safecall => // calling convention

// Parâmetros
#command const <param>: <type> => <param>
#command var <param>: <type> => @<param>
#command out <param>: <type> => @<param>
#command array of const => ... // array de constantes

// ----------------------------------------------------------------------------
// MÉTODOS DE CLASSE
// ----------------------------------------------------------------------------
#command private => HIDDEN:
#command protected => PROTECTED:
#command public => EXPORTED:
#command published => EXPORTED: // publicado
#command property <name>: <type> read <getter> write <setter>; => ;
    ACCESS <name> INLINE <getter> ; ;
    ASSIGN <name>(<value>) INLINE <setter>
#command property <name>: <type> read <field>; => ACCESS <name> INLINE ::<field>
#command property <name>: <type> write <field>; => ASSIGN <name>(<value>) INLINE ::<field> := <value>
#command default => // valor default
#command stored => // stored property
#command default(<value>) => // valor default
#command index <n> => // index property
#command read <method> => // método leitura
#command write <method> => // método escrita

// ----------------------------------------------------------------------------
// OPERADORES
// ----------------------------------------------------------------------------
// Aritméticos
#translate + => +
#translate - => -
#translate * => *
#translate / => /
#translate div => Int(<x> / <y>)
#translate mod => %
#translate shl => hb_bitShift(<x>, <y>)
#translate shr => hb_bitShift(<x>, -<y>)

// Relacionais
#translate = => ==
#translate <> => !=
#translate < => <
#translate > => >
#translate <= => <=
#translate >= => >=
#translate in => $ // em conjunto/array

// Lógicos
#translate and => .AND.
#translate or => .OR.
#translate xor => .XOR.
#translate not => !
#translate @ => // operador de endereço

// Operadores de conjuntos
#translate + => // união de conjuntos
#translate - => // diferença de conjuntos
#translate * => // interseção de conjuntos
#translate <= => // subconjunto
#translate >= => // superconjunto

// Atribuição
#translate := => :=
#translate += => +=
#translate -= => -=
#translate *= => *=
#translate /= => /=

// ----------------------------------------------------------------------------
// ESTRUTURAS DE CONTROLE
// ----------------------------------------------------------------------------
// IF/THEN/ELSE
#command if <cond> then => IF <cond>
#command else => ELSE
#command else if <cond> then => ELSEIF <cond>
#command endif => ENDIF
#command begin => 
#command end => 

// CASE
#command case <expr> of => DO CASE
#command <value>: => CASE <expr> == <value>
#command <value1>..<value2>: => CASE <expr> >= <value1> .AND. <expr> <= <value2>
#command else => OTHERWISE
#command end; => ENDCASE

// FOR
#command for <var> := <start> to <end> do => FOR <var> := <start> TO <end>
#command for <var> := <start> downto <end> do => FOR <var> := <start> TO <end> STEP -1
#command for <var> in <collection> do => FOR EACH <var> IN <collection>

// REPEAT/UNTIL
#command repeat => DO WHILE .T.
#command until <cond>; => ; IF <cond> ; EXIT ; ENDIF ; ENDDO

// WHILE
#command while <cond> do => DO WHILE <cond>

// WITH
#command with <obj> do => // with <obj>
#command with <obj1>, <obj2> do => // with múltiplos objetos

// TRY/EXCEPT/FINALLY
#command try => BEGIN SEQUENCE
#command except => RECOVER
#command on <E: Exception> do => RECOVER USING <E> IF <E>:ClassName == "Exception"
#command finally => ALWAYS
#command end; => END SEQUENCE
#command raise <Exception>.Create('<msg>') => Break(ErrorNew(, , <msg>))
#command raise <Exception>.CreateFmt('<fmt>', [<args>]) => Break(ErrorNew(, , hb_StrFormat(<fmt>, <args>)))
#command raise => Break()

// ----------------------------------------------------------------------------
// STRINGS E CHARACTERES
// ----------------------------------------------------------------------------
#command '''' => "'" // aspas simples
#command #<code> => Chr(<code>) // caractere por código
#command #13#10 => Chr(13) + Chr(10) // CRLF
#command #9 => Chr(9) // TAB
#command sLineBreak => hb_eol() // quebra de linha do sistema

// Funções de string
#command Length(<str>) => Len(<str>)
#command Copy(<str>, <start>, <count>) => SubStr(<str>, <start>, <count>)
#command Pos(<substr>, <str>) => At(<substr>, <str>)
#command Delete(<str>, <start>, <count>) => <str> := Stuff(<str>, <start>, <count>, "")
#command Insert(<substr>, <str>, <pos>) => <str> := Stuff(<str>, <pos>, 0, <substr>)
#command Str(<num>[, <width>[, <decimals>]]) => Str(<num>, iif(<width>==NIL, 10, <width>), iif(<decimals>==NIL, 0, <decimals>))
#command Val(<str>, <var>, <code>) => <var> := Val(<str>), <code> := iif(ValType(<var>) == "N", 0, 1)
#command Concat(<str1>, <str2>) => <str1> + <str2>
#command LowerCase(<str>) => Lower(<str>)
#command UpperCase(<str>) => Upper(<str>)
#command CompareStr(<str1>, <str2>) => iif(<str1> < <str2>, -1, iif(<str1> > <str2>, 1, 0))
#command CompareText(<str1>, <str2>) => iif(Upper(<str1>) < Upper(<str2>), -1, iif(Upper(<str1>) > Upper(<str2>), 1, 0))
#command SameText(<str1>, <str2>) => (Upper(<str1>) == Upper(<str2>))
#command AnsiUpperCase(<str>) => Upper(<str>)
#command AnsiLowerCase(<str>) => Lower(<str>)
#command AnsiCompareStr(<str1>, <str2>) => CompareStr(<str1>, <str2>)
#command AnsiCompareText(<str1>, <str2>) => CompareText(<str1>, <str2>)
#command Trim(<str>) => AllTrim(<str>)
#command TrimLeft(<str>) => LTrim(<str>)
#command TrimRight(<str>) => RTrim(<str>)
#command QuotedStr(<str>) => "'" + <str> + "'"
#command AnsiQuotedStr(<str>, <quote>) => <quote> + <str> + <quote>
#command AnsiDequotedStr(<str>, <quote>) => SubStr(<str>, 2, Len(<str>)-2)
#command IntToStr(<num>) => hb_NToS(<num>)
#command IntToHex(<num>, <digits>) => hb_NumToHex(<num>, <digits>)
#command StrToInt(<str>) => Val(<str>)
#command StrToIntDef(<str>, <default>) => iif(Empty(<str>), <default>, Val(<str>))
#command StrToFloat(<str>) => Val(<str>)
#command FloatToStr(<num>) => hb_NToS(<num>)
#command Format(<fmt>, <args>) => hb_StrFormat(<fmt>, <args>)
#command FormatFloat(<fmt>, <value>) => Transform(<value>, <fmt>)
#command DateTimeToStr(<date>) => DToC(<date>)
#command DateToStr(<date>) => DToC(<date>)
#command TimeToStr(<time>) => // converte tempo para string
#command StrToDate(<str>) => CToD(<str>)
#command StrToDateTime(<str>) => hb_StrToT(<str>)
#command StrToTime(<str>) => // converte string para tempo
#command DayOfWeek(<date>) => DoW(<date>)
#command DecodeDate(<date>, var <year>, var <month>, var <day>) => ;
    <year> := Year(<date>), <month> := Month(<date>), <day> := Day(<date>)
#command DecodeTime(<time>, var <hour>, var <min>, var <sec>, var <msec>) => ;
    <hour> := hb_Hour(<time>), <min> := hb_Minute(<time>), <sec> := hb_Sec(<time>), <msec> := 0
#command EncodeDate(<year>, <month>, <day>) => CToD(Str(<year>,4)+Str(<month>,2)+Str(<day>,2))
#command EncodeTime(<hour>, <min>, <sec>, <msec>) => (<hour>*3600 + <min>*60 + <sec> + <msec>/1000)
#command Now => hb_DateTime()
#command Date => Date()
#command Time => Time()
#command IncMonth(<date>, <months>) => hb_DateAdd("M", <months>, <date>)
#command IncDay(<date>, <days>) => hb_DateAdd("D", <days>, <date>)
#command IncYear(<date>, <years>) => hb_DateAdd("Y", <years>, <date>)
#command DaysBetween(<date1>, <date2>) => hb_DateDiff("D", <date1>, <date2>)
#command IsLeapYear(<year>) => hb_IsLeap(<year>)

// ----------------------------------------------------------------------------
// ARRAYS E COLEÇÕES
// ----------------------------------------------------------------------------
#command SetLength(<array>, <len>) => ASize(<array>, <len>)
#command Length(<array>) => Len(<array>)
#command High(<array>) => Len(<array>)
#command Low(<array>) => 1
#command FillChar(<var>, <count>, <value>) => <var> := Replicate(Chr(<value>), <count>)
#command Move(<source>, <dest>, <count>) => // move memória
#command Copy(<array>, <start>, <count>) => hb_ArraySlice(<array>, <start>, <count>)
#command Concat(<array1>, <array2>) => hb_ArrayMerge(<array1>, <array2>)
#command Insert(<element>, <array>, <index>) => hb_AIns(<array>, <index>, <element>, .T.)
#command Delete(<array>, <index>, <count>) => hb_ADel(<array>, <index>, <count>, .T.)
#command TStringList.Create => // cria string list

// ----------------------------------------------------------------------------
// MATEMÁTICA
// ----------------------------------------------------------------------------
#command Abs(<x>) => Abs(<x>)
#command Sqr(<x>) => (<x> ** 2)
#command Sqrt(<x>) => Sqrt(<x>)
#command Exp(<x>) => Exp(<x>)
#command Ln(<x>) => Log(<x>)
#command Log10(<x>) => Log10(<x>)
#command Int(<x>) => Int(<x>)
#command Frac(<x>) => (<x> - Int(<x>))
#command Trunc(<x>) => Int(<x>)
#command Round(<x>) => Round(<x>)
#command Pi => 3.14159265358979
#command Sin(<x>) => Sin(<x>)
#command Cos(<x>) => Cos(<x>)
#command Tan(<x>) => Tan(<x>)
#command ArcSin(<x>) => Asin(<x>)
#command ArcCos(<x>) => Acos(<x>)
#command ArcTan(<x>) => Atan(<x>)
#command ArcTan2(<y>, <x>) => Atan2(<y>, <x>)
#command Hypot(<x>, <y>) => Sqrt(<x>*<x> + <y>*<y>)
#command Cotan(<x>) => (Cos(<x>)/Sin(<x>))
#command Secant(<x>) => (1/Cos(<x>))
#command Cosecant(<x>) => (1/Sin(<x>))
#command Max(<x>, <y>) => Max(<x>, <y>)
#command Min(<x>, <y>) => Min(<x>, <y>)
#command Power(<base>, <exp>) => (<base> ** <exp>)
#command Random => hb_Random()
#command RandomRange(<min>, <max>) => hb_Random(<min>, <max>)
#command Randomize => hb_RandomSeed(Seconds())

// ----------------------------------------------------------------------------
// SISTEMA E ARQUIVOS
// ----------------------------------------------------------------------------
#command Write(<args>) => QQOut(<args>)
#command WriteLn(<args>) => QOut(<args>)
#command Writeln => QOut()
#command Read(<var>) => <var> := __Accept("")
#command ReadLn(<var>) => <var> := __Accept("")
#command AssignFile(<f>, <filename>) => LOCAL <f>
#command Reset(<f>) => <f> := hb_vfOpen(<filename>, FO_READ)
#command Rewrite(<f>) => <f> := hb_vfOpen(<filename>, FO_CREATE + FO_WRITE)
#command Append(<f>) => <f> := hb_vfOpen(<filename>, FO_CREATE + FO_WRITE)
#command CloseFile(<f>) => hb_vfClose(<f>)
#command FileExists(<filename>) => hb_FileExists(<filename>)
#command DirectoryExists(<dirname>) => hb_DirExists(<dirname>)
#command DeleteFile(<filename>) => hb_FileDelete(<filename>)
#command RenameFile(<old>, <new>) => hb_FileRename(<old>, <new>)
#command CopyFile(<source>, <dest>) => hb_FileCopy(<source>, <dest>)
#command FindFirst(<mask>, <attr>, <searchrec>) => <searchrec> := Directory(<mask>)
#command FindNext(<searchrec>) => // próximo arquivo
#command FindClose(<searchrec>) => // fecha busca
#command GetCurrentDir => CurDir()
#command SetCurrentDir(<dir>) => hb_CurDir(<dir>)
#command CreateDir(<dir>) => hb_DirCreate(<dir>)
#command RemoveDir(<dir>) => hb_DirDelete(<dir>)
#command ForceDirectories(<dir>) => hb_DirCreateAll(<dir>)
#command ExtractFileName(<path>) => hb_FNameNameExt(<path>)
#command ExtractFilePath(<path>) => hb_FNameDir(<path>)
#command ExtractFileDir(<path>) => hb_FNameDir(<path>)
#command ExtractFileExt(<path>) => hb_FNameExt(<path>)
#command ChangeFileExt(<filename>, <ext>) => hb_FNameName(<filename>) + <ext>
#command ExpandFileName(<filename>) => hb_FNameMerge(CurDir(), <filename>)
#command FileSize(<f>) => hb_vfSize(<f>)
#command FileGetDate(<f>) => hb_vfDate(<f>)
#command FileSetDate(<f>, <date>) => hb_vfSetDate(<f>, <date>)
#command FileRead(<f>, <buffer>, <count>) => hb_vfRead(<f>, <buffer>, <count>)
#command FileWrite(<f>, <buffer>, <count>) => hb_vfWrite(<f>, <buffer>, <count>)
#command FileSeek(<f>, <offset>, <origin>) => hb_vfSeek(<f>, <offset>, <origin>)
#command Eof(<f>) => hb_vfEof(<f>)
#command IOResult => FError()

// ----------------------------------------------------------------------------
// DIALOGS E GUI (Windows)
// ----------------------------------------------------------------------------
#command ShowMessage(<msg>) => MsgBox(<msg>)
#command MessageDlg(<msg>, <mt>, <mb>, <default>) => ;
    MessageBox(0, <msg>, "Mensagem", iif(<mt>=mtInformation, 64, iif(<mt>=mtWarning, 48, iif(<mt>=mtError, 16, 0))))
#command InputBox(<caption>, <prompt>, <default>) => __InputBox(<caption>, <prompt>, <default>)
#command InputQuery(<caption>, <prompt>, var <value>) => <value> := __InputBox(<caption>, <prompt>, <value>)
#command SelectDirectory(<caption>, <root>, var <dir>) => <dir> := __GetDir(<caption>, <root>)
#command OpenDialog => TOpenDialog
#command SaveDialog => TSaveDialog
#command Application.CreateForm(<FormClass>, var <Form>) => <Form> := <FormClass>:New()
#command Application.Run => // executa aplicação
#command Application.Terminate => QUIT
#command Application.MessageBox(<text>, <caption>, <flags>) => MessageBox(0, <text>, <caption>, <flags>)
#command Application.ProcessMessages => hb_IdleSleep(0.01)

// Controles comuns
#command TForm => CLASS TForm
#command TButton => CLASS TButton
#command TEdit => CLASS TEdit
#command TLabel => CLASS TLabel
#command TMemo => CLASS TMemo
#command TCheckBox => CLASS TCheckBox
#command TRadioButton => CLASS TRadioButton
#command TListBox => CLASS TListBox
#command TComboBox => CLASS TComboBox
#command TMainMenu => CLASS TMainMenu
#command TMenuItem => CLASS TMenuItem

// Eventos
#command OnClick => EVENT Click
#command OnChange => EVENT Change
#command OnKeyPress => EVENT KeyPress
#command OnCreate => EVENT Create
#command OnDestroy => EVENT Destroy
#command OnShow => EVENT Show
#command OnClose => EVENT Close
#command OnActivate => EVENT Activate
#command OnDeactivate => EVENT Deactivate

// ----------------------------------------------------------------------------
// BANCO DE DADOS
// ----------------------------------------------------------------------------
#command TDatabase => // componente database
#command TTable => // componente table
#command TQuery => // componente query
#command TDataSource => // componente datasource
#command TField => // campo
#command Open => // abre dataset
#command Close => // fecha dataset
#command First => // primeiro registro
#command Next => // próximo registro
#command Prior => // registro anterior
#command Last => // último registro
#command EOF => // fim do arquivo
#command BOF => // início do arquivo
#command FieldByName(<name>).AsString => // campo como string
#command FieldByName(<name>).AsInteger => // campo como inteiro
#command FieldByName(<name>).AsFloat => // campo como float
#command FieldByName(<name>.AsDateTime => // campo como data/hora
#command Post => // posta alterações
#command Cancel => // cancela alterações
#command Delete => // deleta registro
#command Edit => // edita registro
#command Insert => // insere registro
#command Append => // adiciona registro

// SQL
#command SQL.Add(<stmt>) => // adiciona SQL
#command Params.ParamByName(<name>).Value => // parâmetro
#command ExecSQL => // executa SQL
#command Active := True => // ativa componente

// ----------------------------------------------------------------------------
// SISTEMA E WINAPI
// ----------------------------------------------------------------------------
#command Windows. => // prefixo Windows API
#command GetLastError => GetLastError()
#command Sleep(<ms>) => hb_IdleSleep(<ms>)
#command Beep => Tone(1000, 1)
#command GetTickCount => GetTickCount()
#command GetCommandLine => hb_CmdLineArg()
#command ParamStr(<n>) => hb_PValue(<n>)
#command ParamCount => PCount()
#command GetModuleFileName(<hInstance>, <buffer>, <size>) => hb_ProgName()
#command GetCurrentThreadId => GetCurrentThreadId()
#command GetCurrentProcessId => GetCurrentProcessId()
#command ExitProcess(<code>) => QUIT <code>
#command AllocMem(<size>) => hb_AllocMem(<size>)
#command FreeMem(<ptr>) => hb_FreeMem(<ptr>)
#command GetMem(<ptr>, <size>) => <ptr> := hb_AllocMem(<size>)
#command ReallocMem(<ptr>, <size>) => <ptr> := hb_ReallocMem(<ptr>, <size>)
#command SizeOf(<type>) => hb_SizeOf(<type>)
#command FillChar(<dest>, <count>, <value>) => // preenche memória
#command Move(<source>, <dest>, <count>) => // move memória
#command ZeroMemory(<dest>, <size>) => // zera memória

// ----------------------------------------------------------------------------
// UNIDADES COMUNS
// ----------------------------------------------------------------------------
#command uses SysUtils; => // Sistema e utilitários
#command uses Classes; => // Classes básicas
#command uses Forms; => // Formulários
#command uses Dialogs; => // Diálogos
#command uses Controls; => // Controles
#command uses StdCtrls; => // Controles padrão
#command uses Graphics; => // Gráficos
#command uses Menus; => // Menus
#command uses FileCtrl; => // Controle de arquivos
#command uses StrUtils; => // Utilitários de string
#command uses DateUtils; => // Utilitários de data
#command uses Math; => // Matemática
#command uses Variants; => // Variantes
#command uses ComObj; => // Objetos COM
#command uses ActiveX; => // ActiveX
#command uses Windows; => // Windows API
#command uses Messages; => // Mensagens do Windows

// ----------------------------------------------------------------------------
// PALAVRAS-CHAVE ESPECIAIS
// ----------------------------------------------------------------------------
#command inherited => ::Super
#command self => ::Self
#command result => _RETURN
#command asm => // assembly inline
#command assembler => // assembler
#command export => // export
#command external => EXTERN
#command forward => // forward declaration
#command goto <label> => // goto
#command label => // label
#command name => // name
#command near => // near
#command far => // far
#command nodefault => // nodefault
#command package => // package
#command requires => // requires
#command contains => // contains
#command exports => // exports
#command local => LOCAL
#command finalization => // finalization
#command initialization => // initialization
#command inline => INLINE
#command library => // library
#command message => // message
#command object => // object (Turbo Pascal)
#command on => // on (exception)
#command operator => // operator
#command out => @
#command packed => // packed
#command pascal => // calling convention
#command platform => // platform
#command raise => Break()
#command read => // read property
#command readonly => // readonly
#command register => // register
#command reintroduce => // reintroduce
#command requires => // requires
#command resident => // resident
#command safecall => // safecall
#command sealed => // sealed
#command static => STATIC
#command stdcall => // stdcall
#command stored => // stored
#command strict => // strict
#command then => THEN
#command threadvar => // threadvar
#command to => TO
#command try => BEGIN SEQUENCE
#command type => //
#command unchecked => // unchecked
#command unit => //
#command unsafe => // unsafe
#command uses => #include
#command var => LOCAL
#command varargs => ... // argumentos variáveis
#command virtual => // virtual
#command winapi => // winapi
#command write => // write property
#command writeonly => // writeonly
#command delayed => // delayed
#command dispinterface => // dispinterface

// ----------------------------------------------------------------------------
// COMPILER DIRECTIVES
// ----------------------------------------------------------------------------
#command {$DEFINE <symbol>} => #define <symbol>
#command {$UNDEF <symbol>} => #undef <symbol>
#command {$IFDEF <symbol>} => #ifdef <symbol>
#command {$IFNDEF <symbol>} => #ifndef <symbol>
#command {$IF <expr>} => #if <expr>
#command {$ELSEIF <expr>} => #elseif <expr>
#command {$ELSE} => #else
#command {$ENDIF} => #endif
#command {$IFEND} => #endif
#command {$INCLUDE <file>} => #include "<file>"
#command {$I <file>} => #include "<file>"
#command {$R <file>} => // include resource
#command {$MESSAGE <msg>} => #pragma message(<msg>)
#command {$HINTS ON} => // hints on
#command {$HINTS OFF} => // hints off
#command {$WARNINGS ON} => // warnings on
#command {$WARNINGS OFF} => // warnings off
#command {$STACKFRAMES ON} => // stackframes on
#command {$STACKFRAMES OFF} => // stackframes off
#command {$OVERFLOWCHECKS ON} => // overflow checks
#command {$OVERFLOWCHECKS OFF} => // no overflow checks
#command {$RANGECHECKS ON} => // range checks
#command {$RANGECHECKS OFF} => // no range checks
#command {$BOOLEVAL ON} => // boolean evaluation
#command {$BOOLEVAL OFF} => // short-circuit boolean
#command {$EXTENDEDSYNTAX ON} => // extended syntax
#command {$EXTENDEDSYNTAX OFF} => // no extended syntax
#command {$TYPEDADDRESS ON} => // typed address
#command {$TYPEDADDRESS OFF} => // untyped address
#command {$WRITEABLECONST ON} => // writeable const
#command {$WRITEABLECONST OFF} => // read-only const
#command {$LONGSTRINGS ON} => // long strings
#command {$LONGSTRINGS OFF} => // short strings
#command {$OPENSTRINGS ON} => // open strings
#command {$OPENSTRINGS OFF} => // closed strings
#command {$H+} => // long strings (alias)
#command {$H-} => // short strings (alias)
#command {$J+} => // writeable const (alias)
#command {$J-} => // read-only const (alias)
#command {$IOCHECKS ON} => // I/O checks
#command {$IOCHECKS OFF} => // no I/O checks
#command {$ASSERTIONS ON} => #ifdef DEBUG
#command {$ASSERTIONS OFF} => #ifdef NDEBUG
#command {$DEBUGINFO ON} => // debug info
#command {$DEBUGINFO OFF} => // no debug info
#command {$LOCALSYMBOLS ON} => // local symbols
#command {$LOCALSYMBOLS OFF} => // no local symbols
#command {$REFERENCEINFO ON} => // reference info
#command {$REFERENCEINFO OFF} => // no reference info
#command {$SAFEDIVIDE ON} => // safe divide
#command {$SAFEDIVIDE OFF} => // no safe divide
#command {$VARSTRINGCHECKS ON} => // var string checks
#command {$VARSTRINGCHECKS OFF} => // no var string checks
#command {$TYPEINFO ON} => // type info
#command {$TYPEINFO OFF} => // no type info
#command {$OPTIMIZATION ON} => // optimization
#command {$OPTIMIZATION OFF} => // no optimization
#command {$STACKCHECKS ON} => // stack checks
#command {$STACKCHECKS OFF} => // no stack checks
#command {$IMPORTEDDATA ON} => // imported data
#command {$IMPORTEDDATA OFF} => // no imported data
#command {$LEGACYIFEND ON} => // legacy ifend
#command {$LEGACYIFEND OFF} => // no legacy ifend
#command {$MINENUMSIZE 1} => // min enum size 1
#command {$MINENUMSIZE 2} => // min enum size 2
#command {$MINENUMSIZE 4} => // min enum size 4
#command {$ZEROBASEDSTRINGS ON} => // zero-based strings
#command {$ZEROBASEDSTRINGS OFF} => // one-based strings
#command {$STRINGCHECKS ON} => // string checks
#command {$STRINGCHECKS OFF} => // no string checks
#command {$TYPEDADDRESS ON} => // typed address
#command {$TYPEDADDRESS OFF} => // untyped address
#command {$SCOPEDENUMS ON} => // scoped enums
#command {$SCOPEDENUMS OFF} => // unscoped enums
#command {$METHODINFO ON} => // method info
#command {$METHODINFO OFF} => // no method info
#command {$INLINE ON} => // inline expansion
#command {$INLINE OFF} => // no inline expansion
#command {$PACKENUM 1} => // pack enum 1 byte
#command {$PACKENUM 2} => // pack enum 2 bytes
#command {$PACKENUM 4} => // pack enum 4 bytes
#command {$PACKENUM 8} => // pack enum 8 bytes
#command {$PACKENUM 16} => // pack enum 16 bytes
#command {$PACKENUM DEFAULT} => // pack enum default
#command {$PACKRECORDS 1} => // pack records 1 byte
#command {$PACKRECORDS 2} => // pack records 2 bytes
#command {$PACKRECORDS 4} => // pack records 4 bytes
#command {$PACKRECORDS 8} => // pack records 8 bytes
#command {$PACKRECORDS 16} => // pack records 16 bytes
#command {$PACKRECORDS DEFAULT} => // pack records default
#command {$PACKSET 1} => // pack sets 1 byte
#command {$PACKSET 2} => // pack sets 2 bytes
#command {$PACKSET 4} => // pack sets 4 bytes
#command {$PACKSET 8} => // pack sets 8 bytes
#command {$PACKSET DEFAULT} => // pack sets default
#command {$ALIGN 1} => // align 1 byte
#command {$ALIGN 2} => // align 2 bytes
#command {$ALIGN 4} => // align 4 bytes
#command {$ALIGN 8} => // align 8 bytes
#command {$ALIGN 16} => // align 16 bytes
#command {$ALIGN ON} => // alignment on
#command {$ALIGN OFF} => // alignment off
#command {$A1} => // align 1 byte (alias)
#command {$A2} => // align 2 bytes (alias)
#command {$A4} => // align 4 bytes (alias)
#command {$A8} => // align 8 bytes (alias)
#command {$A16} => // align 16 bytes (alias)
#command {$A ON} => // alignment on (alias)
#command {$A OFF} => // alignment off (alias)
#command {$B+} => // boolean evaluation (alias)
#command {$B-} => // short-circuit boolean (alias)
#command {$C+} => // assertions on (alias)
#command {$C-} => // assertions off (alias)
#command {$D+} => // debug info on (alias)
#command {$D-} => // debug info off (alias)
#command {$E+} => // exceptions on (alias)
#command {$E-} => // exceptions off (alias)
#command {$F+} => // far calls on (alias)
#command {$F-} => // near calls (alias)
#command {$G+} => // 80286 code (alias)
#command {$G-} => // 8086 code (alias)
#command {$I+} => // I/O checks on (alias)
#command {$I-} => // I/O checks off (alias)
#command {$L+} => // local symbols on (alias)
#command {$L-} => // local symbols off (alias)
#command {$M <stacksize>} => // memory stack size
#command {$N+} => // numeric coprocessor (alias)
#command {$N-} => // software floating point (alias)
#command {$O+} => // optimization on (alias)
#command {$O-} => // optimization off (alias)
#command {$P+} => // open parameters (alias)
#command {$P-} => // value parameters (alias)
#command {$Q+} => // overflow checks on (alias)
#command {$Q-} => // overflow checks off (alias)
#command {$R+} => // range checks on (alias)
#command {$R-} => // range checks off (alias)
#command {$S+} => // stack checks on (alias)
#command {$S-} => // stack checks off (alias)
#command {$T+} => // typed @ operator (alias)
#command {$T-} => // untyped @ operator (alias)
#command {$U+} => // Pentium safe FDIV (alias)
#command {$U-} => // Pentium unsafe FDIV (alias)
#command {$V+} => // var-string checking (alias)
#command {$V-} => // no var-string checking (alias)
#command {$W+} => // Windows stack frames (alias)
#command {$W-} => // normal stack frames (alias)
#command {$X+} => // extended syntax on (alias)
#command {$X-} => // extended syntax off (alias)
#command {$Y+} => // symbol reference info (alias)
#command {$Y-} => // no symbol reference info (alias)
#command {$Z+} => // minimum enum size (alias)
#command {$Z-} => // normal enum size (alias)
#command {$Z1} => // enum size 1 (alias)
#command {$Z2} => // enum size 2 (alias)
#command {$Z4} => // enum size 4 (alias)

// ----------------------------------------------------------------------------
// CONTINUAÇÃO
// ----------------------------------------------------------------------------
#command ; => // ponto e vírgula (Delphi usa extensivamente)
#command .. => // intervalo
#command // => // comentário de linha
#command (* => /* início comentário de bloco
#command *) => */ fim comentário de bloco
#command { => /* início comentário de bloco alternativo
#command } => */ fim comentário de bloco alternativo

// ----------------------------------------------------------------------------
// ATALHOS PARA FORMS E COMPONENTES
// ----------------------------------------------------------------------------
#command Form1: TForm1 => LOCAL Form1
#command Button1: TButton => LOCAL Button1
#command Edit1: TEdit => LOCAL Edit1
#command Label1: TLabel => LOCAL Label1
#command MainMenu1: TMainMenu => LOCAL MainMenu1
#command MenuItem1: TMenuItem => LOCAL MenuItem1
#command Application: TApplication => // objeto aplicação
#command Screen: TScreen => // objeto tela
#command Printer: TPrinter => // objeto impressora
#command ClipBoard: TClipboard => // objeto clipboard
#command Canvas: TCanvas => // objeto canvas
#command Font: TFont => // objeto font
#command Pen: TPen => // objeto pen
#command Brush: TBrush => // objeto brush

// ----------------------------------------------------------------------------
// MANIPULAÇÃO DE OBJETOS
// ----------------------------------------------------------------------------
#command Free => :Destroy()
#command FreeAndNil(<obj>) => <obj>:Destroy(), <obj> := NIL
#command Create(<args>) => :New(<args>)
#command Owner => :oOwner
#command Parent => :oParent
#command Handle => :hWnd
#command Caption => :cCaption
#command Text => :cText
#command Name => :cName
#command Tag => :nTag
#command Left => :nLeft
#command Top => :nTop
#command Width => :nWidth
#command Height => :nHeight
#command Visible => :lVisible
#command Enabled => :lEnabled
#command Color => :nColor
#command Font.Name => :cFontName
#command Font.Size => :nFontSize
#command Font.Color => :nFontColor
#command Font.Style => :nFontStyle

// ----------------------------------------------------------------------------
// EVENT HANDLERS
// ----------------------------------------------------------------------------
#command procedure TForm1.Button1Click(Sender: TObject); => ;
    METHOD Button1Click(Sender) CLASS TForm1
#command procedure TForm1.FormCreate(Sender: TObject); => ;
    METHOD FormCreate(Sender) CLASS TForm1
#command procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction); => ;
    METHOD FormClose(Sender, @Action) CLASS TForm1
#command procedure TForm1.FormShow(Sender: TObject); => ;
    METHOD FormShow(Sender) CLASS TForm1

// ----------------------------------------------------------------------------
// COMPARAÇÃO DE STRINGS (Case-insensitive por default em Delphi)
// ----------------------------------------------------------------------------
#command <str1> = <str2> => (Upper(<str1>) == Upper(<str2>)) // Delphi é case-insensitive
#command <str1> <> <str2> => (Upper(<str1>) != Upper(<str2>))
#command AnsiSameText(<str1>, <str2>) => (Upper(<str1>) == Upper(<str2>))
#command SameStr(<str1>, <str2>) => (<str1> == <str2>) // case-sensitive