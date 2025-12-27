<?php
// ============================================================================
// DIRETIVAS COMPLETAS PARA TRADUÇÃO DE PHP PARA XHARBOUR
// ============================================================================

// ----------------------------------------------------------------------------
// ABERTURA E TAGS PHP
// ----------------------------------------------------------------------------
#command <?php => // INÍCIO PHP
#command ?> => // FIM PHP
#command <?= <exp> ?> => QQOut(<exp>)
#command <? <code> ?> => <code>

// ----------------------------------------------------------------------------
// COMENTÁRIOS
// ----------------------------------------------------------------------------
#command // <comment> => // <comment>
#command # <comment> => // <comment>
#command /* <comment> */ => /* <comment> */

// ----------------------------------------------------------------------------
// DECLARAÇÕES DE VARIÁVEIS
// ----------------------------------------------------------------------------
#command $<var> => <var>
#command global $<var> => STATIC <var>
#command static $<var> => STATIC <var>
#command define('<name>', <value>) => #define <name> <value>
#command defined('<name>') => #ifdef <name>
#command const <name> = <value> => #define <name> <value>
#command unset($<var>) => <var> := NIL
#command isset($<var>) => (<var> != NIL)
#command empty($<var>) => Empty(<var>)
#command is_null($<var>) => (<var> == NIL)

// ----------------------------------------------------------------------------
// TIPOS DE DADOS
// ----------------------------------------------------------------------------
#translate NULL => NIL
#translate true => .T.
#translate false => .F.
#translate TRUE => .T.
#translate FALSE => .F.

// Tipos escalares
#translate int => NUMERIC
#translate integer => NUMERIC
#translate float => NUMERIC
#translate double => NUMERIC
#translate string => CHARACTER
#translate bool => LOGICAL
#translate boolean => LOGICAL

// Tipos compostos
#translate array => ARRAY
#translate object => OBJECT
#translate resource => // resource (não suportado)

// Tipos especiais
#translate callable => BLOCK
#translate iterable => ARRAY
#translate mixed => // tipo misto

// ----------------------------------------------------------------------------
// OPERADORES
// ----------------------------------------------------------------------------
// Operadores aritméticos
#translate + => +
#translate - => -
#translate * => *
#translate / => /
#translate % => %
#translate ** => **
#translate ++ => ++
#translate -- => --

// Operadores de atribuição
#translate = => :=
#translate += => +=
#translate -= => -=
#translate *= => *=
#translate /= => /=
#translate %= => %=
#translate **= => **=
#translate .= => +=  // concatenação de strings
#translate &= => := <x> .AND. <y>
#translate |= => := <x> .OR. <y>
#translate ^= => := <x> .XOR. <y>
#translate <<= => := hb_bitShift(<x>, <y>)
#translate >>= => := hb_bitShift(<x>, -<y>)

// Operadores de comparação
#translate == => ==
#translate === => ===  // identidade de tipo e valor
#translate != => !=
#translate <> => !=
#translate !== => !==  // não idêntico
#translate < => <
#translate > => >
#translate <= => <=
#translate >= => >=
#translate <=> => // spaceship operator (PHP 7+)

// Operadores lógicos
#translate and => .AND.
#translate or => .OR.
#translate xor => .XOR.
#translate ! => !
#translate && => .AND.
#translate || => .OR.

// Operadores bit a bit
#translate & => .AND.
#translate | => .OR.
#translate ^ => .XOR.
#translate ~ => .NOT.
#translate << => hb_bitShift(<x>, <y>)
#translate >> => hb_bitShift(<x>, -<y>)

// Operadores de string
#translate . => +  // concatenação
#translate .= => += // concatenação com atribuição

// Operador de execução
#command ` <command> ` => hb_ProcessRun(<command>)

// Operador de controle de erro
#command @<expr> => __ErrorBlock({|| <expr>})

// Operador ternário
#command <cond> ? <true> : <false> => iif(<cond>, <true>, <false>)
#command <cond> ?: <default> => iif(<cond>, <cond>, <default>)  // Elvis operator

// Null coalescing (PHP 7+)
#command <expr> ?? <default> => hb_default(<expr>, <default>)
#command <expr> ??= <default> => <expr> := hb_default(<expr>, <default>)

// Spaceship operator (PHP 7+)
#command <a> <=> <b> => iif(<a> < <b>, -1, iif(<a> > <b>, 1, 0))

// ----------------------------------------------------------------------------
// ESTRUTURAS DE CONTROLE
// ----------------------------------------------------------------------------
// IF/ELSEIF/ELSE
#command if (<cond>): => IF <cond>
#command elseif (<cond>): => ELSEIF <cond>
#command else: => ELSE
#command endif; => ENDIF
#command endif => ENDIF

// SWITCH/CASE
#command switch ($<var>): => DO CASE
#command case <value>: => CASE <var> == <value>
#command default: => OTHERWISE
#command endswitch; => ENDCASE
#command endswitch => ENDCASE
#command break => EXIT
#command continue => LOOP
#command break <n> => // break com nível
#command continue <n> => // continue com nível

// FOR loop
#command for ($<i> = <start>; $<i> < <end>; $<i>++): => ;
    FOR <i> := <start> TO <end>-1
#command for ($<i> = <start>; $<i> <= <end>; $<i>++): => ;
    FOR <i> := <start> TO <end>
#command for (; <cond>; <inc>): => DO WHILE <cond> ; <inc>
#command endfor; => NEXT
#command endfor => NEXT

// FOREACH loop
#command foreach ($<array> as $<value>): => ;
    FOR EACH <value> IN <array>
#command foreach ($<array> as $<key> => $<value>): => ;
    FOR EACH <key>, <value> IN <array>
#command endforeach; => NEXT
#command endforeach => NEXT

// WHILE loop
#command while (<cond>): => DO WHILE <cond>
#command endwhile; => ENDDO
#command endwhile => ENDDO

// DO-WHILE loop
#command do { => DO WHILE .T.
#command } while (<cond>); => ; ENDDO ; IF !(<cond>) ; EXIT ; ENDIF

// ----------------------------------------------------------------------------
// TRY/CATCH/FINALLY
// ----------------------------------------------------------------------------
#command try { => BEGIN SEQUENCE
#command } catch (<Exception> $<e>) { => RECOVER USING <e> IF <e>:ClassName == "<Exception>"
#command } catch (Exception $<e>) { => RECOVER USING <e>
#command } finally { => ALWAYS
#command } => END SEQUENCE

#command throw new <Exception>('<msg>') => Break(ErrorNew(, , <msg>))
#command throw new <Exception>('<msg>', <code>) => Break(ErrorNew(, <code>, <msg>))
#command throw $<exception> => Break(<exception>)

// ----------------------------------------------------------------------------
// FUNÇÕES
// ----------------------------------------------------------------------------
#command function <name>([$<params>]) { => FUNCTION <name>([<params>])
#command } => RETURN NIL
#command return <exp>; => RETURN <exp>
#command return; => RETURN NIL
#command yield <value> => AAdd(<yield_array>, <value>)
#command yield from <generator> => AEval(<generator>, {|x| AAdd(<yield_array>, x)})

// Parâmetros com tipo
#command function <name>(<type> $<param>) { => FUNCTION <name>(<param> AS <type>)
#command function <name>(<type> $<param> = <default>) { => ;
    FUNCTION <name>(<param> AS <type>) ; LOCAL <param> := iif(PCount() > 0, <param>, <default>)

// Parâmetros variáveis
#command function <name>(...$<args>) { => FUNCTION <name>(...)
#command function <name>(<type> ...$<args>) { => FUNCTION <name>(...)

// Funções anônimas (closures)
#command function ([$<params>]) use ($<vars>) { => {|<params>| LOCAL <vars> ; 
#command } => }

// Arrow functions (PHP 7.4+)
#command fn([$<params>]) => <expr> => {|<params>| <expr>}

// Funções de seta com use
#command fn([$<params>]) use ($<vars>) => <expr> => ;
    {|<params>| LOCAL <vars> ; <expr>}

// ----------------------------------------------------------------------------
// CLASSES E OBJETOS
// ----------------------------------------------------------------------------
#command class <ClassName> { => CLASS <ClassName>
#command } => ENDCLASS
#command class <ClassName> extends <Parent> { => CLASS <ClassName> FROM <Parent>
#command class <ClassName> implements <Interface> { => CLASS <ClassName> // implements <Interface>
#command abstract class <ClassName> { => CLASS <ClassName>
#command final class <ClassName> { => CLASS <ClassName>

// Modificadores de acesso
#translate public => EXPORTED:
#translate private => HIDDEN:
#translate protected => PROTECTED:
#translate static => CLASS VAR
#translate abstract => // abstract
#translate final => // final

// Métodos
#command public function __construct([$<params>]) { => METHOD New([<params>]) CLASS <ClassName>
#command public function __destruct() { => METHOD Destroy() CLASS <ClassName>
#command public function <name>([$<params>]) { => METHOD <name>([<params>]) CLASS <ClassName>
#command private function <name>([$<params>]) { => HIDDEN: METHOD <name>([<params>]) CLASS <ClassName>
#command protected function <name>([$<params>]) { => PROTECTED: METHOD <name>([<params>]) CLASS <ClassName>
#command static function <name>([$<params>]) { => CLASS METHOD <name>([<params>]) CLASS <ClassName>
#command abstract function <name>([$<params>]); => // abstract method
#command final function <name>([$<params>]) { => METHOD <name>([<params>]) CLASS <ClassName>

// Propriedades
#command public $<prop>; => EXPORTED: VAR <prop>
#command private $<prop>; => HIDDEN: VAR <prop>
#command protected $<prop>; => PROTECTED: VAR <prop>
#command public static $<prop>; => CLASS VAR <prop>
#command const <NAME> = <value>; => #define <NAME> <value>

// Objetos
#command new <Class>([$<args>]) => <Class>:New([<args>])
#command $<obj> = new <Class>([$<args>]) => LOCAL <obj> := <Class>:New([<args>])
#command $<obj>-><method>([$<args>]) => <obj>:<method>([<args>])
#command $<obj>-><property> => <obj>:<property>
#command $<obj>-><property> = <value> => <obj>:<property> := <value>
#command self => ::Self
#command $this => ::Self
#command parent => ::Super
#command static => ::Class

// Interfaces e traits
#command interface <Interface> { => CLASS <Interface>
#command trait <Trait> { => // trait <Trait>
#command use <Trait>; => // use trait <Trait>

// Namespaces
#command namespace <Name>; => // namespace <Name>
#command use <Class>; => // use <Class>
#command use <Namespace>\<Class>; => // use <Namespace>\<Class>
#command use <Namespace>\<Class> as <Alias>; => // use <Namespace>\<Class> as <Alias>

// ----------------------------------------------------------------------------
// ARRAYS
// ----------------------------------------------------------------------------
#command array() => {}
#command [] => {}
#command [$<key> => $<value>] => { <key> => <value> }
#command [$<value>] => { <value> }
#command array($<key> => $<value>) => { <key> => <value> }
#command array($<value>) => { <value> }
#command list($<vars>) = $<array> => <vars> := <array>
#command [$<vars>] = $<array> => <vars> := <array>

// Funções de array
#command count($<array>) => Len(<array>)
#command sizeof($<array>) => Len(<array>)
#command is_array($<var>) => (ValType(<var>) == "A")
#command in_array($<needle>, $<haystack>) => (AScan(<haystack>, {|x| x == <needle>}) > 0)
#command array_key_exists($<key>, $<array>) => ;
    iif(ValType(<array>) == "A", <key> >= 1 .AND. <key> <= Len(<array>), ;
    hb_HHasKey(<array>, <key>))
#command array_keys($<array>) => ;
    iif(ValType(<array>) == "A", Array(Len(<array>), {|i| i}), hb_HKeys(<array>))
#command array_values($<array>) => ;
    iif(ValType(<array>) == "A", AClone(<array>), hb_HValues(<array>))
#command array_merge($<a1>, $<a2>) => hb_ArrayMerge(<a1>, <a2>)
#command array_merge_recursive($<a1>, $<a2>) => hb_HMerge(<a1>, <a2>)
#command array_push($<array>, $<value>) => AAdd(<array>, <value>)
#command array_pop($<array>) => hb_APop(<array>)
#command array_shift($<array>) => hb_APopAt(<array>, 1)
#command array_unshift($<array>, $<value>) => hb_AIns(<array>, 1, <value>, .T.)
#command array_slice($<array>, $<offset>[, $<length>]) => ;
    hb_ArraySlice(<array>, <offset>+1, iif(<length>==NIL, Len(<array>), <length>))
#command array_splice($<array>, $<offset>[, $<length>[, $<replacement>]]) => ;
    hb_ArraySplice(<array>, <offset>+1, <length>, <replacement>)
#command array_reverse($<array>) => hb_ArrayReverse(<array>)
#command array_search($<needle>, $<haystack>) => ;
    AScan(<haystack>, {|x| x == <needle>})-1
#command array_unique($<array>) => hb_ArrayUnique(<array>)
#command array_filter($<array>[, $<callback>]) => ;
    hb_ArrayFilter(<array>, iif(<callback>==NIL, {|x| !Empty(x)}, <callback>))
#command array_map($<callback>, $<array>) => hb_ArrayEval(<array>, <callback>)
#command array_reduce($<array>, $<callback>[, $<initial>]) => ;
    hb_ArrayReduce(<array>, <callback>, <initial>)
#command array_walk($<array>, $<callback>) => AEval(<array>, <callback>)
#command array_walk_recursive($<array>, $<callback>) => // walk recursivo
#command sort($<array>) => ASort(<array>)
#command rsort($<array>) => ASort(<array>, , , , .T.)
#command asort($<array>) => // sort associativo
#command arsort($<array>) => // sort reverso associativo
#command ksort($<array>) => // sort por chaves
#command krsort($<array>) => // sort reverso por chaves
#command usort($<array>, $<callback>) => ASort(<array>, , , <callback>)
#command uasort($<array>, $<callback>) => // sort associativo com callback
#command uksort($<array>, $<callback>) => // sort por chaves com callback
#command natsort($<array>) => // natural sort
#command natcasesort($<array>) => // natural case-insensitive sort
#command array_column($<array>, $<column>) => hb_ArrayColumn(<array>, <column>)
#command array_combine($<keys>, $<values>) => hb_HashFromArray(<keys>, <values>)
#command array_fill($<start>, $<num>, $<value>) => ;
    Array(<num>, <value>)
#command array_fill_keys($<keys>, $<value>) => hb_HashFill(<keys>, <value>)
#command array_flip($<array>) => hb_HashSwap(<array>)
#command array_intersect($<a1>, $<a2>) => hb_ArrayIntersect(<a1>, <a2>)
#command array_intersect_key($<a1>, $<a2>) => hb_HashIntersect(<a1>, <a2>)
#command array_diff($<a1>, $<a2>) => hb_ArrayDiff(<a1>, <a2>)
#command array_diff_key($<a1>, $<a2>) => hb_HashDiff(<a1>, <a2>)
#command array_sum($<array>) => hb_ArraySum(<array>)
#command array_product($<array>) => hb_ArrayProduct(<array>)
#command array_rand($<array>[, $<num>]) => ;
    iif(<num>==NIL, <array>[Int(hb_Random(1, Len(<array>)))], ;
    hb_ArrayRandom(<array>, <num>))
#command shuffle($<array>) => hb_ArrayShuffle(<array>)
#command range($<start>, $<end>[, $<step>]) => ;
    Array(Int((<end>-<start>)/iif(<step>==NIL, 1, <step>))+1, ;
    {|i| <start> + (i-1)*iif(<step>==NIL, 1, <step>)})
#command compact($<vars>) => hb_GetVars(<vars>)
#command extract($<array>) => __ExtractVars(<array>)

// ----------------------------------------------------------------------------
// STRINGS
// ----------------------------------------------------------------------------
#command echo $<str> => QQOut(<str>)
#command print $<str> => QQOut(<str>)
#command printf($<format>, $<args>) => QQOut(hb_StrFormat(<format>, <args>))
#command sprintf($<format>, $<args>) => hb_StrFormat(<format>, <args>)
#command vprintf($<format>, $<array>) => QQOut(hb_StrFormat(<format>, <array>))
#command vsprintf($<format>, $<array>) => hb_StrFormat(<format>, <array>)

// Funções de string
#command strlen($<str>) => Len(<str>)
#command strrev($<str>) => hb_StrReverse(<str>)
#command strtolower($<str>) => Lower(<str>)
#command strtoupper($<str>) => Upper(<str>)
#command ucfirst($<str>) => Upper(Left(<str>, 1)) + SubStr(<str>, 2)
#command lcfirst($<str>) => Lower(Left(<str>, 1)) + SubStr(<str>, 2)
#command ucwords($<str>) => // capitalize palavras
#command trim($<str>) => AllTrim(<str>)
#command ltrim($<str>) => LTrim(<str>)
#command rtrim($<str>) => RTrim(<str>)
#command chop($<str>) => RTrim(<str>)
#command str_replace($<search>, $<replace>, $<subject>[, $<count>]) => ;
    StrTran(<subject>, <search>, <replace>, 1, iif(<count>==NIL, -1, <count>))
#command str_ireplace($<search>, $<replace>, $<subject>[, $<count>]) => ;
    // replace case-insensitive
#command substr($<str>, $<start>[, $<length>]) => ;
    SubStr(<str>, <start>+1, <length>)
#command strstr($<haystack>, $<needle>[, $<before_needle>]) => ;
    iif(<before_needle>, Left(<haystack>, At(<needle>, <haystack>)-1), ;
    SubStr(<haystack>, At(<needle>, <haystack>)))
#command stristr($<haystack>, $<needle>[, $<before_needle>]) => ;
    // strstr case-insensitive
#command strpos($<haystack>, $<needle>[, $<offset>]) => ;
    At(<needle>, <haystack>, iif(<offset>==NIL, 1, <offset>+1))-1
#command stripos($<haystack>, $<needle>[, $<offset>]) => ;
    // strpos case-insensitive
#command strrpos($<haystack>, $<needle>[, $<offset>]) => ;
    hb_RAt(<needle>, <haystack>, iif(<offset>==NIL, 1, <offset>+1))-1
#command strripos($<haystack>, $<needle>[, $<offset>]) => ;
    // strrpos case-insensitive
#command str_pad($<str>, $<length>[, $<pad_string>[, $<pad_type>]]) => ;
    iif(<pad_type> == "STR_PAD_LEFT", PadL(<str>, <length>, iif(<pad_string>==NIL, " ", <pad_string>)), ;
    iif(<pad_type> == "STR_PAD_BOTH", PadC(<str>, <length>, iif(<pad_string>==NIL, " ", <pad_string>)), ;
    PadR(<str>, <length>, iif(<pad_string>==NIL, " ", <pad_string>))))
#command str_repeat($<str>, $<multiplier>) => Replicate(<str>, <multiplier>)
#command str_shuffle($<str>) => hb_StrShuffle(<str>)
#command str_split($<str>[, $<length>]) => ;
    iif(<length>==NIL, hb_ATokens(<str>, ""), hb_StrSplit(<str>, <length>))
#command str_word_count($<str>[, $<format>[, $<charlist>]]) => ;
    iif(<format>==0 .OR. <format>==NIL, Len(hb_ATokens(<str>, " ")), ;
    iif(<format>==1, hb_ATokens(<str>, " "), // array de palavras
    hb_StrWordPositions(<str>)))
#command strcmp($<str1>, $<str2>) => iif(<str1> < <str2>, -1, iif(<str1> > <str2>, 1, 0))
#command strcasecmp($<str1>, $<str2>) => // strcmp case-insensitive
#command strnatcmp($<str1>, $<str2>) => // natural order compare
#command strnatcasecmp($<str1>, $<str2>) => // natural case-insensitive compare
#command strcoll($<str1>, $<str2>) => // locale based compare
#command strcspn($<str>, $<charlist>[, $<start>[, $<length>]]) => // length of initial segment not matching mask
#command strspn($<str>, $<mask>[, $<start>[, $<length>]]) => // length of initial segment matching mask
#command strip_tags($<str>[, $<allowable_tags>]) => hb_StripTags(<str>, <allowable_tags>)
#command htmlspecialchars($<str>) => hb_HtmlSpecialChars(<str>)
#command htmlentities($<str>) => hb_HtmlEntities(<str>)
#command htmlspecialchars_decode($<str>) => hb_HtmlSpecialCharsDecode(<str>)
#command html_entity_decode($<str>) => hb_HtmlEntityDecode(<str>)
#command addslashes($<str>) => hb_AddSlashes(<str>)
#command stripslashes($<str>) => hb_StripSlashes(<str>)
#command addcslashes($<str>, $<charlist>) => hb_AddCSlashes(<str>, <charlist>)
#command strip_cslashes($<str>) => hb_StripCSlashes(<str>)
#command quotemeta($<str>) => hb_QuoteMeta(<str>)
#command chr($<ascii>) => Chr(<ascii>)
#command ord($<char>) => Asc(<char>)
#command nl2br($<str>) => StrTran(<str>, Chr(10), "<br/>" + Chr(10))
#command wordwrap($<str>[, $<width>[, $<break>[, $<cut>]]]) => hb_WordWrap(<str>, <width>, <break>, <cut>)
#command explode($<delimiter>, $<str>[, $<limit>]) => ;
    hb_ATokens(<str>, <delimiter>, iif(<limit>==NIL, -1, <limit>))
#command implode($<glue>, $<array>) => ArrayToStr(<array>, <glue>)
#command join($<glue>, $<array>) => ArrayToStr(<array>, <glue>)
#command strtok($<str>, $<token>) => hb_StrToken(<str>, <token>)
#command parse_str($<str>, $<result>) => __ParseStr(<str>, @<result>)
#command str_getcsv($<str>[, $<delimiter>[, $<enclosure>[, $<escape>]]]) => hb_StrGetCsv(<str>, <delimiter>, <enclosure>, <escape>)

// ----------------------------------------------------------------------------
// FUNÇÕES MATEMÁTICAS
// ----------------------------------------------------------------------------
#command abs($<num>) => Abs(<num>)
#command ceil($<num>) => Ceiling(<num>)
#command floor($<num>) => Floor(<num>)
#command round($<num>[, $<precision>[, $<mode>]]) => Round(<num>, iif(<precision>==NIL, 0, <precision>))
#command sqrt($<num>) => Sqrt(<num>)
#command pow($<base>, $<exp>) => (<base> ** <exp>)
#command exp($<num>) => Exp(<num>)
#command log($<num>[, $<base>]) => iif(<base>==NIL, Log(<num>), Log(<num>)/Log(<base>))
#command log10($<num>) => Log10(<num>)
#command sin($<num>) => Sin(<num>)
#command cos($<num>) => Cos(<num>)
#command tan($<num>) => Tan(<num>)
#command asin($<num>) => Asin(<num>)
#command acos($<num>) => Acos(<num>)
#command atan($<num>) => Atan(<num>)
#command atan2($<y>, $<x>) => Atan2(<y>, <x>)
#command pi() => 3.14159265358979
#command deg2rad($<num>) => (<num> * 3.14159265358979 / 180)
#command rad2deg($<num>) => (<num> * 180 / 3.14159265358979)
#command fmod($<x>, $<y>) => (<x> % <y>)
#command intdiv($<dividend>, $<divisor>) => Int(<dividend> / <divisor>)
#command is_nan($<val>) => // is not a number
#command is_finite($<val>) => // is finite
#command is_infinite($<val>) => // is infinite
#command max($<values>) => Max(<values>)
#command min($<values>) => Min(<values>)
#command rand([$<min>, $<max>]) => ;
    iif(<min>==NIL, hb_Random(), iif(<max>==NIL, hb_Random(<min>), hb_Random(<min>, <max>)))
#command mt_rand([$<min>, $<max>]) => // Mersenne Twister random
#command srand([$<seed>]) => hb_RandomSeed(iif(<seed>==NIL, Seconds(), <seed>))
#command mt_srand([$<seed>]) => // Mersenne Twister seed
#command getrandmax() => 2147483647
#command mt_getrandmax() => 2147483647
#command number_format($<num>[, $<decimals>[, $<decimal_point>[, $<thousands_sep>]]]) => ;
    Transform(<num>, "@E " + Replicate("9", 12) + iif(<decimals>==NIL, "", "." + Replicate("9", <decimals>)))

// ----------------------------------------------------------------------------
#command base_convert($<num>, $<frombase>, $<tobase>) => hb_NumBaseConvert(<num>, <frombase>, <tobase>)
#command bindec($<binary>) => hb_BinToNum(<binary>)
#command decbin($<decimal>) => hb_NumToBin(<decimal>)
#command decoct($<decimal>) => hb_NumToOct(<decimal>)
#command dechex($<decimal>) => hb_NumToHex(<decimal>)
#command hexdec($<hex>) => hb_HexToNum(<hex>)
#command octdec($<octal>) => hb_OctToNum(<octal>)

// ----------------------------------------------------------------------------
// DATAS E HORAS
// ----------------------------------------------------------------------------
#command date($<format>[, $<timestamp>]) => DToC(iif(<timestamp>==NIL, Date(), hb_TToD(<timestamp>)), <format>)
#command time() => Seconds()
#command microtime([$<get_as_float>]) => ;
    iif(<get_as_float>, hb_MicroTime(), hb_MicroTimeStr())
#command mktime([$<hour>[, $<minute>[, $<second>[, $<month>[, $<day>[, $<year>]]]]]]) => ;
    hb_DateTime(<year>, <month>, <day>, <hour>, <minute>, <second>)
#command strtotime($<time>[, $<now>]) => hb_StrToT(<time>, <now>)
#command strftime($<format>[, $<timestamp>]) => hb_StrFormatTime(<format>, iif(<timestamp>==NIL, Date(), hb_TToD(<timestamp>)))
#command gmdate($<format>[, $<timestamp>]) => // date GMT
#command gmstrftime($<format>[, $<timestamp>]) => // strftime GMT
#command idate($<format>[, $<timestamp>]) => // integer date
#command getdate([$<timestamp>]) => hb_TToC(iif(<timestamp>==NIL, Date(), hb_TToD(<timestamp>)))
#command localtime([$<timestamp>[, $<is_assoc>]]) => // local time
#command gettimeofday([$<return_float>]) => // get time of day
#command checkdate($<month>, $<day>, $<year>) => hb_IsDate(Str(<year>,4)+Str(<month>,2)+Str(<day>,2))
#command date_add($<date>, $<interval>) => hb_DateAdd(<interval>, <date>)
#command date_sub($<date>, $<interval>) => hb_DateAdd(<interval>, <date>, -1)
#command date_diff($<datetime1>, $<datetime2>[, $<absolute>]) => hb_DateDiff(<datetime1>, <datetime2>)
#command date_format($<date>, $<format>) => DToC(<date>, <format>)
#command date_parse($<date>) => hb_DateParse(<date>)
#command date_parse_from_format($<format>, $<date>) => hb_DateParseFromFormat(<format>, <date>)
#command date_sunrise($<timestamp>[, $<format>[, $<latitude>[, $<longitude>[, $<zenith>[, $<utc_offset>]]]]]) => // sunrise
#command date_sunset($<timestamp>[, $<format>[, $<latitude>[, $<longitude>[, $<zenith>[, $<utc_offset>]]]]]) => // sunset
#command date_default_timezone_get() => // get default timezone
#command date_default_timezone_set($<timezone>) => // set default timezone

// ----------------------------------------------------------------------------
// CONSTANTES PREDEFINIDAS
// ----------------------------------------------------------------------------
#define PHP_VERSION hb_Version()
#define PHP_OS OS()
#define PHP_EOL hb_eol()
#define DIRECTORY_SEPARATOR hb_ps()
#define PATH_SEPARATOR iif(OS()=="Windows", ";", ":")
#define PHP_INT_MAX 2147483647
#define PHP_INT_MIN -2147483648
#define PHP_FLOAT_MAX 1.7976931348623e+308
#define PHP_FLOAT_MIN 2.2250738585072e-308

// Constantes de erro
#define E_ERROR 1
#define E_WARNING 2
#define E_PARSE 4
#define E_NOTICE 8
#define E_CORE_ERROR 16
#define E_CORE_WARNING 32
#define E_COMPILE_ERROR 64
#define E_COMPILE_WARNING 128
#define E_USER_ERROR 256
#define E_USER_WARNING 512
#define E_USER_NOTICE 1024
#define E_STRICT 2048
#define E_RECOVERABLE_ERROR 4096
#define E_DEPRECATED 8192
#define E_USER_DEPRECATED 16384
#define E_ALL 32767

// Constantes de diretório
#define __DIR__ hb_DirBase()
#define __FILE__ hb_ProgName()
#define __LINE__ ProcLine()

// ----------------------------------------------------------------------------
// FUNÇÕES DE ARQUIVOS E SISTEMA
// ----------------------------------------------------------------------------
#command include $<file> => #include "<file>"
#command include_once $<file> => #include "<file>" ONCE
#command require $<file> => #include "<file>" REQUIRE
#command require_once $<file> => #include "<file>" REQUIRE ONCE

// Sistema de arquivos
#command file