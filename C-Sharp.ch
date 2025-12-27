// ============================================================================
// DIRETIVAS COMPLETAS PARA TRADUÇÃO DE C# (C-SHARP) PARA XHARBOUR
// ============================================================================

// ----------------------------------------------------------------------------
// DECLARAÇÕES DE NAMESPACE E CLASSE
// ----------------------------------------------------------------------------
#command using <namespace> => // Namespace <namespace> (informacional)
#command namespace <name> { => 
#command }                  => 
#command class <name> [: <base>] { => CLASS <name> [FROM <base>]
#command }                  => ENDCLASS
#command interface <name>   => CLASS <name>
#command struct <name>      => CLASS <name>
#command enum <name>        => 

// ----------------------------------------------------------------------------
// MODIFICADORES DE ACESSO
// ----------------------------------------------------------------------------
#translate public           => EXPORTED:
#translate private          => HIDDEN:
#translate protected        => PROTECTED:
#translate internal         => // internal (escopo de assembly)
#translate protected internal => PROTECTED:
#translate static           => CLASS VAR
#translate readonly         => 
#translate const            => #define
#translate volatile         => // volatile (não suportado diretamente)

// ----------------------------------------------------------------------------
// DECLARAÇÕES DE MEMBROS
// ----------------------------------------------------------------------------
#command <type> <var>[ = <init>]; => VAR <var> // <type> inicializado com <init>
#command <type> <var> { get; set; } => VAR <var>
#command <type>[] <var>         => VAR <var> AS ARRAY
#command List<<type>> <var>     => VAR <var> AS ARRAY
#command Dictionary<<k>,<v>> <var> => VAR <var> AS HASH

// Tipos de dados C# para xHarbour
#translate int              => NUMERIC
#translate long             => NUMERIC
#translate short            => NUMERIC
#translate byte             => NUMERIC
#translate float            => NUMERIC
#translate double           => NUMERIC
#translate decimal          => NUMERIC
#translate bool             => LOGICAL
#translate char             => CHARACTER
#translate string           => CHARACTER
#translate object           => 
#translate dynamic          => 
#translate var              => LOCAL
#translate void             => 

// ----------------------------------------------------------------------------
// MÉTODOS E FUNÇÕES
// ----------------------------------------------------------------------------
#command <modifiers> <type> <name>([<params>]) { => ;
    METHOD <name>([<params>]) CLASS <classname> ; INLINE <modifiers> ; RETURN <type>
#command }                  => ENDMETHOD

#command <modifiers> <type> <name>([<params>]) => ;
    METHOD <name>([<params>]) CLASS <classname>

#command return <exp>;      => RETURN <exp>
#command return;            => RETURN NIL
#command void <name>([<params>]) => PROCEDURE <name>([<params>])
#command yield return <exp> => AAdd(<yieldarray>, <exp>)

// Parâmetros
#translate ref <param>      => @<param>
#translate out <param>      => @<param>
#translate params <type>[] <param> => <param>

// ----------------------------------------------------------------------------
// CONSTRUTORES E DESTRUTORES
// ----------------------------------------------------------------------------
#command public <classname>() { => METHOD New() CLASS <classname>
#command ~<classname>()      => METHOD Destroy() CLASS <classname>
#command this                => ::Self
#command base                => ::Super

// ----------------------------------------------------------------------------
// PROPRIEDADES E INDEXADORES
// ----------------------------------------------------------------------------
#command get { return <field>; } => ACCESS <fieldname> ; RETURN ::<field>
#command set { <field> = value; } => ASSIGN <fieldname>(<value>) ; ::<field> := <value>
#command value                  => <value>
#command this[<index>]          => :<index>
#command =>                     => RETURN

// ----------------------------------------------------------------------------
// ESTRUTURAS DE CONTROLE
// ----------------------------------------------------------------------------
#command if (<cond>)          => IF <cond>
#command else if (<cond>)     => ELSEIF <cond>
#command else                 => ELSE
#command switch (<exp>)       => DO CASE
#command case <value>:        => CASE <exp> == <value>
#command default:             => OTHERWISE
#command break;               => EXIT
#command continue;            => LOOP

#command for (<init>; <cond>; <inc>) => ;
    <init> ; DO WHILE <cond> ; <inc>

#command for (<type> <var> in <collection>) => ;
    FOR EACH <var> IN <collection>

#command foreach (<type> <var> in <collection>) => ;
    AEval(<collection>, {|<var>| 

#command while (<cond>)       => DO WHILE <cond>
#command do {                 => DO WHILE .T.
#command } while (<cond>);    => ; ENDDO ; IF !(<cond>) ; EXIT ; ENDIF

#command try {                => BEGIN SEQUENCE
#command } catch (<type> <ex>) { => RECOVER USING <ex>
#command } finally {          => ALWAYS
#command }                    => END SEQUENCE

#command throw new <Exception>(<msg>) => Break(ErrorNew(, , <msg>))
#command throw;               => Break()
#command throw <ex>;          => Break(<ex>)

// ----------------------------------------------------------------------------
// OPERADORES
// ----------------------------------------------------------------------------
#translate =                  => :=
#translate ==                 => ==
#translate !=                 => !=
#translate ===                => ===  // identidade de objeto
#translate !==                => !==
#translate <                  => <
#translate >                  => >
#translate <=                 => <=
#translate >=                 => >=
#translate &&                 => .AND.
#translate ||                 => .OR.
#translate !                  => !
#translate &                  => .AND. (bit a bit)
#translate |                  => .OR. (bit a bit)
#translate ^                  => .XOR.
#translate ~                  => .NOT. (bit a bit)
#translate <<                 => hb_bitShift(<x>, <y>)
#translate >>                 => hb_bitShift(<x>, -<y>)
#translate +                  => +
#translate -                  => -
#translate *                  => *
#translate /                  => /
#translate %                  => %
#translate ++                 => ++
#translate --                 => --
#translate +=                 => +=
#translate -=                 => -=
#translate *=                 => *=
#translate /=                 => /=
#translate %=                 => %=
#translate &=                 => := <x> .AND. <y>
#translate |=                 => := <x> .OR. <y>
#translate ^=                 => := <x> .XOR. <y>
#translate <<=                => := hb_bitShift(<x>, <y>)
#translate >>=                => := hb_bitShift(<x>, -<y>)
#translate ??                 => hb_default(<x>, <y>)
#translate ?.                 => :? // null-conditional
#translate ?[                 => :?[ // null-conditional index
#translate ??=                => <x> := hb_default(<x>, <y>)

// Operadores de tipo
#translate is                 => hb_isKindOf
#translate as                 => hb_cast
#translate typeof(<type>)     => hb_typeOf
#translate nameof(<expr>)     => hb_nameOf

// ----------------------------------------------------------------------------
// EXPRESSÕES LAMBDA E DELEGADOS
// ----------------------------------------------------------------------------
#command (<params>) => <expr> => {|<params>| <expr>}
#command delegate <type> <name>([<params>]) => BLOCK {|<params>| }
#command Action<<T>>          => BLOCK
#command Func<<T, TResult>>   => BLOCK
#command Predicate<<T>>       => BLOCK {|<x>| }

// ----------------------------------------------------------------------------
// ATRIBUTOS E ANOTAÇÕES
// ----------------------------------------------------------------------------
#command [<attribute>]        => // <attribute>
#command [<attribute>(<args>)] => // <attribute>(<args>)
#translate Serializable       => // [Serializable]
#translate Obsolete           => // [Obsolete]
#translate DllImport          => DECLARE
#translate Conditional        => #ifdef

// ----------------------------------------------------------------------------
// LINQ (Language Integrated Query)
// ----------------------------------------------------------------------------
#command from <var> in <source> => <source>:Select({|<var>| 
#command where <condition>    => :Where({|| <condition>})
#command select <expr>        => :Select({|| <expr>})
#command orderby <expr>       => :OrderBy({|| <expr>})
#command group <expr> by <key> => :GroupBy({|| <key>}, {|| <expr>})
#command join <var2> in <source2> on <key1> equals <key2> => ;
    :Join(<source2>, {|| <key1>}, {|| <key2>}, {|<var1>, <var2>| 
#command into <group>         => })

// ----------------------------------------------------------------------------
// FUNÇÕES DE STRING
// ----------------------------------------------------------------------------
#translate string.IsNullOrEmpty(<str>) => Empty(<str>)
#translate string.IsNullOrWhiteSpace(<str>) => (Empty(AllTrim(<str>)))
#translate <str>.Length       => Len(<str>)
#translate <str>.Substring(<start>[, <length>]) => SubStr(<str>, <start>+1, <length>)
#translate <str>.IndexOf(<find>) => At(<find>, <str>)-1
#translate <str>.LastIndexOf(<find>) => hb_RAt(<find>, <str>)-1
#translate <str>.Replace(<old>, <new>) => StrTran(<str>, <old>, <new>)
#translate <str>.ToUpper()    => Upper(<str>)
#translate <str>.ToLower()    => Lower(<str>)
#translate <str>.Trim()       => AllTrim(<str>)
#translate <str>.TrimStart()  => LTrim(<str>)
#translate <str>.TrimEnd()    => RTrim(<str>)
#translate <str>.StartsWith(<prefix>) => (Left(<str>, Len(<prefix>)) == <prefix>)
#translate <str>.EndsWith(<suffix>) => (Right(<str>, Len(<suffix>)) == <suffix>)
#translate <str>.Contains(<substr>) => (<substr> $ <str>)
#translate <str>.Split(<delim>) => hb_ATokens(<str>, <delim>)
#translate string.Format(<format>, <args>) => ;
    hb_StrFormat(<format>, <args>)
#translate <str>.PadLeft(<width>) => PadL(<str>, <width>)
#translate <str>.PadRight(<width>) => PadR(<str>, <width>)
#translate string.Join(<delim>, <array>) => ArrayToStr(<array>, <delim>)
#translate string.Concat(<args>) => <args>

// ----------------------------------------------------------------------------
// FUNÇÕES DE ARRAY E COLEÇÕES
// ----------------------------------------------------------------------------
#translate <array>.Length     => Len(<array>)
#translate <array>[<index>]   => <array>[<index>+1]  // C# usa 0-based
#translate Array.Resize(ref <array>, <size>) => ASize(<array>, <size>)
#translate <list>.Add(<item>) => AAdd(<list>, <item>)
#translate <list>.Remove(<item>) => hb_ADel(<list>, <item>, .T.)
#translate <list>.Clear()     => <list> := {}
#translate <list>.Count       => Len(<list>)
#translate <dict>.Add(<key>, <value>) => hb_HSet(<dict>, <key>, <value>)
#translate <dict>[<key>]      => hb_HGet(<dict>, <key>)
#translate <dict>.ContainsKey(<key>) => hb_HHasKey(<dict>, <key>)
#translate <dict>.Keys        => hb_HKeys(<dict>)
#translate <dict>.Values      => hb_HValues(<dict>)
#translate <collection>.Any() => (Len(<collection>) > 0)
#translate <collection>.All({|| <cond>}) => (AScan(<collection>, {|| !<cond>}) == 0)
#translate <collection>.Select({|| <expr>}) => ;
    Array(Len(<collection>), {|i| <expr>})
#translate <collection>.Where({|| <cond>}) => ;
    hb_ArrayFilter(<collection>, {|| <cond>})
#translate <collection>.OrderBy({|| <key>}) => ;
    ASort(<collection>,,, {|| <key>})

// ----------------------------------------------------------------------------
// FUNÇÕES MATEMÁTICAS
// ----------------------------------------------------------------------------
#translate Math.Abs(<n>)      => Abs(<n>)
#translate Math.Ceiling(<n>)  => Ceiling(<n>)
#translate Math.Floor(<n>)    => Floor(<n>)
#translate Math.Round(<n>)    => Round(<n>)
#translate Math.Max(<a>,<b>)  => Max(<a>, <b>)
#translate Math.Min(<a>,<b>)  => Min(<a>, <b>)
#translate Math.Pow(<x>,<y>)  => (<x> ** <y>)
#translate Math.Sqrt(<n>)     => Sqrt(<n>)
#translate Math.Log(<n>)      => Log(<n>)
#translate Math.Log10(<n>)    => Log10(<n>)
#translate Math.Exp(<n>)      => Exp(<n>)
#translate Math.Sin(<n>)      => Sin(<n>)
#translate Math.Cos(<n>)      => Cos(<n>)
#translate Math.Tan(<n>)      => Tan(<n>)
#translate Math.PI            => 3.14159265358979
#translate Math.E             => 2.71828182845905

// ----------------------------------------------------------------------------
// FUNÇÕES DE DATA/HORA
// ----------------------------------------------------------------------------
#translate DateTime.Now       => hb_DateTime()
#translate DateTime.Today     => Date()
#translate DateTime.UtcNow    => hb_UTCDateTime()
#translate <dt>.Year          => Year(<dt>)
#translate <dt>.Month         => Month(<dt>)
#translate <dt>.Day           => Day(<dt>)
#translate <dt>.Hour          => hb_Hour(<dt>)
#translate <dt>.Minute        => hb_Minute(<dt>)
#translate <dt>.Second        => hb_Sec(<dt>)
#translate <dt>.AddDays(<n>)  => hb_DateAdd("D", <n>, <dt>)
#translate <dt>.AddMonths(<n>) => hb_DateAdd("M", <n>, <dt>)
#translate <dt>.AddYears(<n>) => hb_DateAdd("Y", <n>, <dt>)
#translate TimeSpan.FromDays(<n>) => (<n> * 86400)  // segundos
#translate TimeSpan.FromHours(<n>) => (<n> * 3600)
#translate TimeSpan.FromMinutes(<n>) => (<n> * 60)

// ----------------------------------------------------------------------------
// FUNÇÕES DE CONVERSÃO
// ----------------------------------------------------------------------------
#translate Convert.ToInt32(<exp>) => Int(Val(<exp>))
#translate Convert.ToInt64(<exp>) => Val(<exp>)
#translate Convert.ToDouble(<exp>) => Val(<exp>)
#translate Convert.ToDecimal(<exp>) => Val(<exp>)
#translate Convert.ToString(<exp>) => hb_ValToStr(<exp>)
#translate Convert.ToBoolean(<exp>) => iif(<exp>, .T., .F.)
#translate Convert.ToDateTime(<exp>) => hb_StrToT(<exp>)
#translate int.Parse(<str>)   => Val(<str>)
#translate double.Parse(<str>) => Val(<str>)
#translate bool.Parse(<str>)  => (Upper(<str>) == "TRUE")
#translate DateTime.Parse(<str>) => CToD(<str>)
#translate <type>.TryParse(<str>, out <result>) => ;
    (<result> := Val(<str>), !Empty(<str>))

// ----------------------------------------------------------------------------
// E/S E ARQUIVOS
// ----------------------------------------------------------------------------
#command Console.WriteLine([<args>]) => QOut( <args> )
#command Console.Write([<args>])    => QQOut( <args> )
#command Console.ReadLine()         => __Accept("")
#command Console.ReadKey()          => Inkey(0)

#command using (var <var> = new <type>([<args>])) { => ;
    LOCAL <var> := <type>:New([<args>])

#command File.ReadAllText(<path>)   => MemoRead(<path>)
#command File.WriteAllText(<path>, <text>) => MemoWrit(<path>, <text>)
#command File.Exists(<path>)        => hb_FileExists(<path>)
#command File.Delete(<path>)        => hb_FileDelete(<path>)
#command Directory.GetFiles(<path>) => Directory(<path>)
#command Path.Combine(<p1>, <p2>)   => (<p1> + "\" + <p2>)

// ----------------------------------------------------------------------------
// THREADING E ASSINCRONIA
// ----------------------------------------------------------------------------
#command async <type> <name>([<params>]) => ;
    METHOD <name>([<params>]) CLASS <classname> ; INLINE ASYNC
#command await <task>             => <task>:Result
#command Task.Run(() => {         => hb_threadStart({|| 
#command })                       => })
#command Task.Delay(<ms>)         => hb_IdleSleep(<ms>/1000)
#command Task.FromResult(<value>) => <value>
#command lock (<obj>) {           => hb_mutexLock(<obj>)
#command }                        => hb_mutexUnlock(<obj>)

// ----------------------------------------------------------------------------
// REFLEXÃO E ATRIBUTOS
// ----------------------------------------------------------------------------
#translate typeof(<T>)           => hb_typeOf(<T>)
#translate <obj>.GetType()       => hb_typeOf(<obj>)
#translate Type.GetType(<name>)  => hb_classFromName(<name>)
#translate Activator.CreateInstance(<type>) => <type>:New()
#translate <type>.GetProperties() => hb_classProperties(<type>)
#translate <type>.GetMethods()   => hb_classMethods(<type>)

// ----------------------------------------------------------------------------
// EXPRESSÕES REGULARES
// ----------------------------------------------------------------------------
#translate new Regex(<pattern>)  => hb_regexComp(<pattern>)
#translate <regex>.IsMatch(<str>) => hb_regexLike(<regex>, <str>)
#translate <regex>.Match(<str>)  => hb_regex(<regex>, <str>)
#translate <regex>.Matches(<str>) => hb_regexAll(<regex>, <str>)
#translate <regex>.Replace(<str>, <replacement>) => hb_regexReplace(<regex>, <str>, <replacement>)

// ----------------------------------------------------------------------------
// SERIALIZAÇÃO
// ----------------------------------------------------------------------------
#translate JsonConvert.SerializeObject(<obj>) => hb_JsonEncode(<obj>)
#translate JsonConvert.DeserializeObject<<T>>(<json>) => hb_JsonDecode(<json>)
#translate XmlSerializer                       => hb_XmlSerializer()
#translate DataContractSerializer              => // Serializador de contrato de dados

// ----------------------------------------------------------------------------
// ATALHOS E SINÔNIMOS
// ----------------------------------------------------------------------------
#command Debug.WriteLine(<msg>)  => // Debug: <msg>
#command Trace.WriteLine(<msg>)  => // Trace: <msg>
#command Assert(<cond>)          => // ASSERT <cond>
#command #region <name>          => // REGION <name>
#command #endregion              => // ENDREGION
#command #pragma warning disable => #pragma
#command #pragma warning restore => #endpragma
#command #line <num>             => // LINE <num>
#command #error <msg>            => #error <msg>
#command #warning <msg>          => #warning <msg>
#command #define <sym>           => #define <sym>
#command #undef <sym>            => #undef <sym>
#command #if <cond>              => #if <cond>
#command #elif <cond>            => #elseif <cond>
#command #else                   => #else
#command #endif                  => #endif

// ----------------------------------------------------------------------------
// CONSTANTES E VALORES ESPECIAIS
// ----------------------------------------------------------------------------
#define null                     NIL
#define true                     .T.
#define false                    .F.
#define default(<T>)             hb_defaultValue(<T>)
#define nameof(<expr>)           #<expr>
#define sizeof(<type>)           hb_sizeOf(<type>)
#define typeof(<T>)              #<T>

// Tipos anuláveis
#translate <type>?               => // nullable <type>
#translate <var>.HasValue        => (<var> != NIL)
#translate <var>.Value           => <var>
#translate <var>.GetValueOrDefault() => hb_default(<var>, default(<type>))

// ----------------------------------------------------------------------------
// OPERADORES DE CONVERSÃO
// ----------------------------------------------------------------------------
#translate (int)<exp>            => Int(<exp>)
#translate (double)<exp>         => Val(<exp>)
#translate (string)<exp>         => hb_ValToStr(<exp>)
#translate (bool)<exp>           => iif(<exp>, .T., .F.)
#translate (DateTime)<exp>       => hb_StrToT(<exp>)
#translate (<type>)<exp>         => hb_cast(<type>, <exp>)

// ----------------------------------------------------------------------------
// EXPRESSÕES DE INICIALIZAÇÃO
// ----------------------------------------------------------------------------
#command new <type>([<args>])    => <type>:New([<args>])
#command new <type> { <init> }   => <type>:New():<init>
#command new[] { <values> }      => { <values> }
#command new List<<type>>()      => {}
#command new Dictionary<<k>,<v>>() => {=>}

// ----------------------------------------------------------------------------
// CONTINUAÇÃO DE LINHAS LONGAS
// ----------------------------------------------------------------------------
#translate @                     => ; // string verbatim