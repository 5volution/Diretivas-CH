# ============================================================================
# DIRETIVAS COMPLETAS PARA TRADUÇÃO DE PYTHON PARA XHARBOUR
# ============================================================================

# ----------------------------------------------------------------------------
# ESTRUTURA DO PROGRAMA E MÓDULOS
# ----------------------------------------------------------------------------
#command #! /usr/bin/python3 => // Script Python
#command import <module> => #include "<module>.ch"
#command from <module> import <name> => #include "<module>.ch"
#command import <module> as <alias> => #include "<module>.ch" AS <alias>
#command __name__ == "__main__" => PROCEDURE Main()
#command if __name__ == "__main__": => 

# ----------------------------------------------------------------------------
# COMENTÁRIOS E DOCSTRINGS
# ----------------------------------------------------------------------------
#command # <comment> => // <comment>
#command """ <docstring> """ => /* <docstring> */
#command ''' <docstring> ''' => /* <docstring> */

# ----------------------------------------------------------------------------
# DECLARAÇÕES E ATRIBUIÇÕES
# ----------------------------------------------------------------------------
#command <var> = <value> => LOCAL <var> := <value>
#command <var> = None => LOCAL <var> := NIL
#command <var1>, <var2> = <val1>, <val2> => LOCAL <var1> := <val1>, <var2> := <val2>
#command global <var> => STATIC <var>
#command nonlocal <var> => STATIC <var>
#command del <var> => <var> := NIL

# ----------------------------------------------------------------------------
# TIPOS DE DADOS BÁSICOS
# ----------------------------------------------------------------------------
#translate None => NIL
#translate True => .T.
#translate False => .F.
#translate NoneType => NIL

# Tipos numéricos
#translate int => NUMERIC
#translate float => NUMERIC
#translate complex => // complex (não suportado diretamente)
#translate bool => LOGICAL

# Tipos sequenciais
#translate str => CHARACTER
#translate list => ARRAY
#translate tuple => ARRAY // tuplas são arrays em xHarbour
#translate range => ARRAY

# Tipos de mapeamento
#translate dict => HASH
#translate set => HASH // set como hash com valores booleanos

# ----------------------------------------------------------------------------
# OPERADORES
# ----------------------------------------------------------------------------
# Operadores aritméticos
#translate + => +
#translate - => -
#translate * => *
#translate / => /
#translate // => Int(<x>/<y>)  # divisão inteira
#translate % => %
#translate ** => **
#translate @ => // operador de matriz (não suportado)

# Operadores de comparação
#translate == => ==
#translate != => !=
#translate < => <
#translate > => >
#translate <= => <=
#translate >= => >=
#translate is => ==  # identidade de objeto
#translate is not => !=
#translate in => $  # contém em string/array
#translate not in => !(<x> $ <y>)

# Operadores lógicos
#translate and => .AND.
#translate or => .OR.
#translate not => !
#translate & => .AND. (bit a bit)
#translate | => .OR. (bit a bit)
#translate ^ => .XOR. (bit a bit)
#translate ~ => .NOT. (bit a bit)
#translate << => hb_bitShift(<x>, <y>)
#translate >> => hb_bitShift(<x>, -<y>)

# Operadores de atribuição
#translate += => +=
#translate -= => -=
#translate *= => *=
#translate /= => /=
#translate //= => := Int(<x>/<y>)
#translate %= => %=
#translate **= => **=
#translate &= => := <x> .AND. <y>
#translate |= => := <x> .OR. <y>
#translate ^= => := <x> .XOR. <y>
#translate <<= => := hb_bitShift(<x>, <y>)
#translate >>= => := hb_bitShift(<x>, -<y>)

# Operador walrus (Python 3.8+)
#command <var> := <expr> => LOCAL <var> := <expr>

# ----------------------------------------------------------------------------
# ESTRUTURAS DE CONTROLE
# ----------------------------------------------------------------------------
# IF/ELIF/ELSE
#command if <cond>: => IF <cond>
#command elif <cond>: => ELSEIF <cond>
#command else: => ELSE
#command : => THEN

# FOR loops
#command for <var> in range(<start>, <stop>[, <step>]): => ;
    FOR <var> := <start> TO <stop>-1 STEP iif(<step> == NIL, 1, <step>)
#command for <var> in range(<stop>): => FOR <var> := 0 TO <stop>-1
#command for <var> in <iterable>: => ;
    FOR EACH <var> IN <iterable>
#command for <var1>, <var2> in enumerate(<iterable>): => ;
    FOR <i> := 1 TO Len(<iterable>) ; <var1> := <i>-1 ; <var2> := <iterable>[<i>]
#command for <var1>, <var2> in zip(<a>, <b>): => ;
    FOR <i> := 1 TO Min(Len(<a>), Len(<b>)) ; ;
    <var1> := <a>[<i>] ; <var2> := <b>[<i>]
#command break => EXIT
#command continue => LOOP
#command else: (em loops) => // else clause em loops

# WHILE loops
#command while <cond>: => DO WHILE <cond>
#command while True: => DO WHILE .T.

# WITH statement (context managers)
#command with <expr> as <var>: => ;
    LOCAL <var> := <expr> ; TRY
#command __enter__() => // método enter do context manager
#command __exit__() => // método exit do context manager

# TRY/EXCEPT/FINALLY
#command try: => BEGIN SEQUENCE
#command except <Exception> as <e>: => RECOVER USING <e> IF <e>:ClassName == "<Exception>"
#command except: => RECOVER USING <e>
#command finally: => ALWAYS
#command raise <Exception>(<msg>) => Break(ErrorNew(, , <msg>))
#command raise => Break()
#command raise <Exception> from <cause> => Break(ErrorNew(, , , <cause>))

# ASSERT
#command assert <cond>[, <msg>] => #ifdef DEBUG ; IF !(<cond>) ; Break(ErrorNew(, , <msg>)) ; ENDIF ; #endif

# ----------------------------------------------------------------------------
# FUNÇÕES E MÉTODOS
# ----------------------------------------------------------------------------
#command def <name>([<params>]): => FUNCTION <name>([<params>])
#command def <name>(*args): => FUNCTION <name>(...)
#command def <name>(**kwargs): => FUNCTION <name>(hParams)
#command def <name>(*args, **kwargs): => FUNCTION <name>(..., hParams)
#command lambda <params>: <expr> => {|<params>| <expr>}
#command return <expr> => RETURN <expr>
#command return => RETURN NIL
#command yield <expr> => AAdd(<yield_array>, <expr>)
#command yield from <iterable> => AEval(<iterable>, {|x| AAdd(<yield_array>, x)})

# Parâmetros especiais
#translate *args => ...
#translate **kwargs => hParams
#translate / => // parâmetros posicionais apenas (Python 3.8+)
#translate * => // separador de parâmetros (Python 3.8+)

# Decoradores
#command @<decorator> => // decorador: @<decorator>
#command @<decorator>(<args>) => // decorador: @<decorator>(<args>)

# Funções built-in
#command print([<args>][, sep=<s>][, end=<e>][, file=<f>]) => ;
    QQOut(iif(<sep>==NIL, " ", <s>), <args>) ; QQOut(iif(<end>==NIL, hb_eol(), <e>))
#command input([<prompt>]) => __Accept(<prompt>)
#command len(<obj>) => Len(<obj>)
#command type(<obj>) => hb_typeOf(<obj>)
#command isinstance(<obj>, <type>) => hb_isKindOf(<obj>, <type>)
#command issubclass(<cls1>, <cls2>) => hb_isSubClass(<cls1>, <cls2>)
#command str(<obj>) => hb_ValToStr(<obj>)
#command int(<obj>) => Int(Val(<obj>))
#command float(<obj>) => Val(<obj>)
#command bool(<obj>) => iif(<obj>, .T., .F.)
#command chr(<code>) => Chr(<code>)
#command ord(<char>) => Asc(<char>)
#command hex(<n>) => hb_NumToHex(<n>)
#command oct(<n>) => hb_NumToOct(<n>)
#command bin(<n>) => hb_NumToBin(<n>)
#command abs(<n>) => Abs(<n>)
#command round(<n>[, <digits>]) => Round(<n>, iif(<digits>==NIL, 0, <digits>))
#command pow(<x>, <y>) => (<x> ** <y>)
#command max(<args>) => Max(<args>)
#command min(<args>) => Min(<args>)
#command sum(<iterable>) => hb_ArraySum(<iterable>)
#command sorted(<iterable>[, key=<k>][, reverse=<r>]) => ;
    ASort(<iterable>,,, {|| <k>}, iif(<r>==NIL, .F., <r>))
#command reversed(<iterable>) => hb_ArrayReverse(<iterable>)
#command enumerate(<iterable>[, start=<s>]) => {|a,i| {iif(<s>==NIL,0,<s>)+i-1, a[i]}}
#command zip(<iterables>) => // combina múltiplos iteráveis
#command map(<func>, <iterable>) => hb_ArrayEval(<iterable>, <func>)
#command filter(<func>, <iterable>) => hb_ArrayFilter(<iterable>, <func>)
#command any(<iterable>) => (AScan(<iterable>, {|x| x}) > 0)
#command all(<iterable>) => (AScan(<iterable>, {|x| !x}) == 0)
#command range(<start>, <stop>[, <step>]) => Array((<stop>-<start>)/iif(<step>==NIL,1,<step>), ;
    {|i| <start> + (i-1)*iif(<step>==NIL,1,<step>)})

# ----------------------------------------------------------------------------
# STRINGS E FORMATAÇÃO
# ----------------------------------------------------------------------------
# Strings literais
#translate f"<text>{<expr>}" => hb_StrFormat("<text>%s", <expr>)
#translate f"""<text>{<expr>}""" => hb_StrFormat("<text>%s", <expr>)
#translate r"<text>" => "<text>"  # raw string
#translate b"<text>" => "<text>"  # bytes literal
#translate u"<text>" => "<text>"  # unicode string

# Métodos de string
#translate <str>.lower() => Lower(<str>)
#translate <str>.upper() => Upper(<str>)
#translate <str>.capitalize() => Upper(Left(<str>,1)) + Lower(SubStr(<str>,2))
#translate <str>.title() => // title case
#translate <str>.strip() => AllTrim(<str>)
#translate <str>.lstrip() => LTrim(<str>)
#translate <str>.rstrip() => RTrim(<str>)
#translate <str>.strip(<chars>) => // strip caracteres específicos
#translate <str>.split([<sep>][, <maxsplit>]) => ;
    hb_ATokens(<str>, iif(<sep>==NIL, " ", <sep>), iif(<maxsplit>==NIL, -1, <maxsplit>))
#translate <str>.join(<iterable>) => ArrayToStr(<iterable>, <str>)
#translate <str>.replace(<old>, <new>[, <count>]) => ;
    StrTran(<str>, <old>, <new>, 1, iif(<count>==NIL, -1, <count>))
#translate <str>.find(<sub>[, <start>[, <end>]]) => ;
    At(<sub>, <str>, iif(<start>==NIL, 1, <start>))-1
#translate <str>.rfind(<sub>[, <start>[, <end>]]) => ;
    hb_RAt(<sub>, <str>, iif(<start>==NIL, 1, <start>))-1
#translate <str>.index(<sub>) => At(<sub>, <str>)-1
#translate <str>.rindex(<sub>) => hb_RAt(<sub>, <str>)-1
#translate <str>.count(<sub>) => Occurs(<sub>, <str>)
#translate <str>.startswith(<prefix>) => (Left(<str>, Len(<prefix>)) == <prefix>)
#translate <str>.endswith(<suffix>) => (Right(<str>, Len(<suffix>)) == <suffix>)
#translate <str>.center(<width>[, <fillchar>]) => ;
    PadC(<str>, <width>, iif(<fillchar>==NIL, " ", <fillchar>))
#translate <str>.ljust(<width>[, <fillchar>]) => ;
    PadL(<str>, <width>, iif(<fillchar>==NIL, " ", <fillchar>))
#translate <str>.rjust(<width>[, <fillchar>]) => ;
    PadR(<str>, <width>, iif(<fillchar>==NIL, " ", <fillchar>))
#translate <str>.zfill(<width>) => PadL(<str>, <width>, "0")
#translate <str>.isalpha() => hb_regexLike("[A-Za-z]+", <str>)
#translate <str>.isdigit() => hb_regexLike("[0-9]+", <str>)
#translate <str>.isalnum() => hb_regexLike("[A-Za-z0-9]+", <str>)
#translate <str>.isspace() => (AllTrim(<str>) == "")
#translate <str>.format(*args, **kwargs) => hb_StrFormat(<str>, args)

# Formatação de strings
#command "{0}".format(<arg>) => hb_StrFormat("%s", <arg>)
#command "{0:<10}".format(<arg>) => PadR(hb_ValToStr(<arg>), 10)
#command "{0:>10}".format(<arg>) => PadL(hb_ValToStr(<arg>), 10)
#command "{0:^10}".format(<arg>) => PadC(hb_ValToStr(<arg>), 10)
#command "{0:.2f}".format(<arg>) => Str(<arg>, 10, 2)
#command "{0:,}".format(<arg>) => Transform(<arg>, "@E 999,999,999")

# ----------------------------------------------------------------------------
# LISTAS E TUPLAS
# ----------------------------------------------------------------------------
# Literais
#command [] => {}
#command [<expr>] => {<expr>}
#command [<expr> for <var> in <iterable> if <cond>] => ;
    hb_ArrayFilter(hb_ArrayEval(<iterable>, {|<var>| <expr>}), {|<var>| <cond>})
#command (<expr>,) => {<expr>}  # tupla unitária
#command (<expr1>, <expr2>) => {<expr1>, <expr2>}

# Métodos de lista
#translate <list>.append(<item>) => AAdd(<list>, <item>)
#translate <list>.extend(<iterable>) => AEval(<iterable>, {|x| AAdd(<list>, x)})
#translate <list>.insert(<index>, <item>) => hb_AIns(<list>, <index>+1, <item>, .T.)
#translate <list>.remove(<item>) => hb_ADel(<list>, <item>, .T.)
#translate <list>.pop([<index>]) => ;
    iif(<index>==NIL, hb_APop(<list>), hb_APopAt(<list>, <index>+1))
#translate <list>.clear() => <list> := {}
#translate <list>.index(<item>[, <start>[, <end>]]) => ;
    AScan(<list>, {|x| x == <item>}, iif(<start>==NIL, 1, <start>+1), ;
    iif(<end>==NIL, Len(<list>), <end>+1))-1
#translate <list>.count(<item>) => ;
    Len(hb_ArrayFilter(<list>, {|x| x == <item>}))
#translate <list>.sort([key=<k>][, reverse=<r>]) => ;
    ASort(<list>,,, {|| <k>}, iif(<r>==NIL, .F., <r>))
#translate <list>.reverse() => <list> := hb_ArrayReverse(<list>)
#translate <list>.copy() => AClone(<list>)

# Operações com listas
#translate <list>[<start>:<stop>] => hb_ArraySlice(<list>, <start>+1, <stop>)
#translate <list>[<start>:<stop>:<step>] => // slice com step
#translate <list> + <list2> => hb_ArrayMerge(<list>, <list2>)
#translate <list> * <n> => hb_ArrayRepeat(<list>, <n>)

# ----------------------------------------------------------------------------
# DICIONÁRIOS (HASHES)
# ----------------------------------------------------------------------------
# Literais
#command {} => {=>}
#command {<key>: <value>} => { <key> => <value> }
#command dict() => {=>}
#command dict([<pairs>]) => Hash(<pairs>)

# Métodos de dicionário
#translate <dict>.get(<key>[, <default>]) => hb_HGetDef(<dict>, <key>, <default>)
#translate <dict>.setdefault(<key>[, <default>]) => ;
    iif(hb_HHasKey(<dict>, <key>), hb_HGet(<dict>, <key>), ;
    (hb_HSet(<dict>, <key>, iif(<default>==NIL, NIL, <default>)), ;
    hb_HGet(<dict>, <key>)))
#translate <dict>.update([<other>]) => hb_HMerge(<dict>, <other>)
#translate <dict>.keys() => hb_HKeys(<dict>)
#translate <dict>.values() => hb_HValues(<dict>)
#translate <dict>.items() => hb_HPairs(<dict>)
#translate <dict>.pop(<key>[, <default>]) => ;
    hb_HDel(<dict>, <key>, @<value>), iif(<value>==NIL, iif(<default>==NIL, NIL, <default>), <value>)
#translate <dict>.popitem() => // remove e retorna um par (chave, valor)
#translate <dict>.clear() => <dict> := {=>}
#translate <dict>.copy() => hb_HClone(<dict>)
#translate len(<dict>) => Len(<dict>)

# Compreensão de dicionários
#command {<key>: <value> for <var> in <iterable> if <cond>} => ;
    hb_HashFromArray(hb_ArrayFilter(<iterable>, {|<var>| <cond>}), ;
    {|<var>| <key>}, {|<var>| <value>})

# ----------------------------------------------------------------------------
# CONJUNTOS (SETS)
# ----------------------------------------------------------------------------
# Literais
#command set() => {=>}  // conjunto como hash
#command {<item>} => { <item> => .T. }
#command {<item1>, <item2>} => { <item1> => .T., <item2> => .T. }

# Operações com conjuntos
#translate <set>.add(<item>) => hb_HSet(<set>, <item>, .T.)
#translate <set>.remove(<item>) => hb_HDel(<set>, <item>)
#translate <set>.discard(<item>) => hb_HDel(<set>, <item>)
#translate <set>.pop() => hb_HPop(<set>)
#translate <set>.clear() => <set> := {=>}
#translate <set>.copy() => hb_HClone(<set>)
#translate <set>.union(<other>) => hb_HMerge(hb_HClone(<set>), <other>)
#translate <set>.intersection(<other>) => hb_HFilter(<set>, {|k| hb_HHasKey(<other>, k)})
#translate <set>.difference(<other>) => hb_HFilter(<set>, {|k| !hb_HHasKey(<other>, k)})
#translate <set>.symmetric_difference(<other>) => ;
    hb_HMerge(hb_HFilter(<set>, {|k| !hb_HHasKey(<other>, k)}), ;
    hb_HFilter(<other>, {|k| !hb_HHasKey(<set>, k)}))

# ----------------------------------------------------------------------------
# CLASSES E OBJETOS
# ----------------------------------------------------------------------------
#command class <ClassName>([<BaseClass>]): => CLASS <ClassName> [FROM <BaseClass>]
#command __init__(self[, <params>]): => METHOD New([<params>]) CLASS <ClassName>
#command def <method>(self[, <params>]): => ;
    METHOD <method>([<params>]) CLASS <ClassName>
#command @classmethod => CLASS METHOD
#command @staticmethod => STATIC METHOD
#command @property => ACCESS
#command self => ::Self
#command cls => ::Class
#command super() => ::Super

# Métodos especiais
#command __str__(self): => METHOD __Str__() CLASS <ClassName> ; RETURN hb_ValToStr(::Self)
#command __repr__(self): => METHOD __Repr__() CLASS <ClassName> ; RETURN "(" + ::ClassName + ")"
#command __len__(self): => METHOD __Len__() CLASS <ClassName> ; RETURN Len(::Self)
#command __getitem__(self, <key>): => METHOD __GetItem__(<key>) CLASS <ClassName>
#command __setitem__(self, <key>, <value>): => METHOD __SetItem__(<key>, <value>) CLASS <ClassName>
#command __delitem__(self, <key>): => METHOD __DelItem__(<key>) CLASS <ClassName>
#command __iter__(self): => METHOD __Iter__() CLASS <ClassName>
#command __next__(self): => METHOD __Next__() CLASS <ClassName>
#command __enter__(self): => METHOD __Enter__() CLASS <ClassName>
#command __exit__(self, <type>, <value>, <traceback>): => METHOD __Exit__() CLASS <ClassName>

# ----------------------------------------------------------------------------
# GERADORES E ITERADORES
# ----------------------------------------------------------------------------
#command def <gen>([<params>]): => FUNCTION <gen>([<params>])
#command yield <value> => AAdd(<yield_array>, <value>)
#command yield from <iterable> => AEval(<iterable>, {|x| AAdd(<yield_array>, x)})
#command next(<iterator>) => <iterator>:__Next__()
#command iter(<iterable>) => <iterable>:__Iter__()

# ----------------------------------------------------------------------------
# MÓDULOS E PACOTES
# ----------------------------------------------------------------------------
#command import <module> => #include "<module>.ch"
#command from <module> import * => #include "<module>.ch"
#command __all__ = [<names>] => // lista de exportações públicas
#command __version__ = "<ver>" => // versão do módulo
#command __author__ = "<name>" => // autor do módulo

# ----------------------------------------------------------------------------
# MANIPULAÇÃO DE ARQUIVOS
# ----------------------------------------------------------------------------
#command open(<file>[, <mode>]) => hb_vfOpen(<file>, <mode>)
#command <file>.read([<size>]) => hb_vfRead(<file>, iif(<size>==NIL, -1, <size>))
#command <file>.readline() => hb_vfReadLine(<file>)
#command <file>.readlines() => hb_vfReadAll(<file>, .T.)
#command <file>.write(<data>) => hb_vfWrite(<file>, <data>)
#command <file>.writelines(<lines>) => hb_vfWrite(<file>, <lines>)
#command <file>.close() => hb_vfClose(<file>)
#command with open(<file>, <mode>) as <f>: => ;
    LOCAL <f> := hb_vfOpen(<file>, <mode>) ; TRY

# Modos de abertura
#translate "r" => FO_READ
#translate "w" => FO_CREATE + FO_TRUNC + FO_WRITE
#translate "a" => FO_CREATE + FO_WRITE
#translate "r+" => FO_READWRITE
#translate "w+" => FO_CREATE + FO_TRUNC + FO_READWRITE
#translate "a+" => FO_CREATE + FO_READWRITE
#translate "b" => // modo binário
#translate "t" => // modo texto

# ----------------------------------------------------------------------------
# EXCEÇÕES
# ----------------------------------------------------------------------------
#command Exception => Error
#command ValueError => Error
#command TypeError => Error
#command IndexError => Error
#command KeyError => Error
#command AttributeError => Error
#command IOError => FError
#command OSError => Error
#command RuntimeError => Error
#command NotImplementedError => Error
#command StopIteration => Break()

# ----------------------------------------------------------------------------
# FUNÇÕES AVANÇADAS E UTILITÁRIOS
# ----------------------------------------------------------------------------
#command getattr(<obj>, <name>[, <default>]) => ;
    hb_GetMsg(<obj>, <name>, iif(<default>==NIL, NIL, <default>))
#command setattr(<obj>, <name>, <value>) => hb_SetMsg(<obj>, <name>, <value>)
#command hasattr(<obj>, <name>) => hb_HHasMsg(<obj>, <name>)
#command delattr(<obj>, <name>) => hb_DelMsg(<obj>, <name>)
#command callable(<obj>) => (ValType(<obj>) == "B" .OR. ValType(<obj>) == "O")
#command hash(<obj>) => hb_Hash(<obj>)
#command id(<obj>) => hb_Id(<obj>)
#command help([<obj>]) => // exibe ajuda
#command dir([<obj>]) => hb_Dir(<obj>)
#command locals() => __GetLocals()
#command globals() => __GetGlobals()
#command vars([<obj>]) => hb_GetVars(<obj>)
#command eval(<expr>) => &(<expr>)
#command exec(<code>) => hb_Exec(<code>)
#command compile(<source>, <filename>, <mode>) => hb_Compile(<source>)

# ----------------------------------------------------------------------------
# MÓDULOS COMUNS
# ----------------------------------------------------------------------------
# Módulo os
#command os.getcwd() => CurDir()
#command os.listdir(<path>) => Directory(<path>)
#command os.path.join(<p1>, <p2>) => (<p1> + "\" + <p2>)
#command os.path.exists(<path>) => hb_FileExists(<path>)
#command os.path.isdir(<path>) => hb_DirExists(<path>)
#command os.path.isfile(<path>) => hb_FileExists(<path>)
#command os.path.getsize(<path>) => hb_vfSize(<path>)

# Módulo sys
#command sys.argv => hb_CmdLineArg()
#command sys.exit([<code>]) => QUIT iif(<code>==NIL, 0, <code>)
#command sys.version => hb_Version()
#command sys.platform => OS()

# Módulo math
#command math.pi => 3.14159265358979
#command math.e => 2.71828182845905
#command math.sqrt(<x>) => Sqrt(<x>)
#command math.sin(<x>) => Sin(<x>)
#command math.cos(<x>) => Cos(<x>)
#command math.tan(<x>) => Tan(<x>)
#command math.log(<x>) => Log(<x>)
#command math.log10(<x>) => Log10(<x>)
#command math.exp(<x>) => Exp(<x>)
#command math.ceil(<x>) => Ceiling(<x>)
#command math.floor(<x>) => Floor(<x>)
#command math.fabs(<x>) => Abs(<x>)

# Módulo random
#command random.random() => hb_Random()
#command random.randint(<a>, <b>) => Int(hb_Random(<a>, <b>))
#command random.choice(<seq>) => <seq>[Int(hb_Random(1, Len(<seq>)))]
#command random.shuffle(<seq>) => hb_ArrayShuffle(<seq>)

# ----------------------------------------------------------------------------
# TIPAGEM (Python 3.5+)
# ----------------------------------------------------------------------------
#command def <func>(<param>: <type>) -> <ret_type>: => ;
    FUNCTION <func>(<param> AS <type>) AS <ret_type>
#command <var>: <type> => // type hint
#command from typing import * => // módulo de tipagem
#translate List[<T>] => ARRAY
#translate Dict[<K>, <V>] => HASH
#translate Tuple[<T1>, <T2>] => ARRAY
#translate Optional[<T>] => // tipo opcional
#translate Union[<T1>, <T2>] => // união de tipos
#translate Callable[[<args>], <ret>] => BLOCK

# ----------------------------------------------------------------------------
# ASYNCIO (Python 3.5+)
# ----------------------------------------------------------------------------
#command async def <func>([<params>]): => FUNCTION <func>([<params>]) ASYNC
#command await <coroutine> => <coroutine>:Result
#command async with <expr> as <var>: => // async context manager
#command async for <var> in <iterable>: => // async for loop

# ----------------------------------------------------------------------------
# EXPRESSÕES DE ATRIBUIÇÃO (Python 3.8+)
# ----------------------------------------------------------------------------
#command if <var> := <expr>: => LOCAL <var> := <expr> ; IF <var>
#command while <var> := <expr>: => LOCAL <var> := <expr> ; DO WHILE <var>

# ----------------------------------------------------------------------------
# CONTINUAÇÃO DE LINHAS
# ----------------------------------------------------------------------------
#translate \ => ; // continuação de linha em Python