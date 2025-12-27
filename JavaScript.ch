// ============================================================================
// DIRETIVAS COMPLETAS PARA TRADUÇÃO JAVASCRIPT PARA XHARBOUR
// ============================================================================

// ----------------------------------------------------------------------------
// COMENTÁRIOS E ESTRUTURA
// ----------------------------------------------------------------------------
#command // <comment> => // <comment>
#command /* <comment> */ => /* <comment> */
#command /** <doc> */ => //! <doc> - documentação
#command 'use strict'; => // modo estrito
#command 'use asm'; => // modo asm

// ----------------------------------------------------------------------------
// DECLARAÇÕES DE VARIÁVEIS
// ----------------------------------------------------------------------------
#command var <var> = <value>; => LOCAL <var> := <value>
#command var <var>; => LOCAL <var>
#command let <var> = <value>; => LOCAL <var> := <value>
#command let <var>; => LOCAL <var>
#command const <var> = <value>; => #define <var> <value>
#command const <var>; => #define <var>

// ----------------------------------------------------------------------------
// TIPOS DE DADOS
// ----------------------------------------------------------------------------
#translate undefined => NIL
#translate null => NIL
#translate true => .T.
#translate false => .F.
#translate NaN => 0/0 // Not a Number
#translate Infinity => 1/0 // Infinito

// ----------------------------------------------------------------------------
// OPERADORES
// ----------------------------------------------------------------------------
// Aritméticos
#translate + => +
#translate - => -
#translate * => *
#translate / => /
#translate % => %
#translate ++ => ++
#translate -- => --
#translate ** => **
#translate -<expr> => -<expr> // negação unária

// Atribuição
#translate = => :=
#translate += => +=
#translate -= => -=
#translate *= => *=
#translate /= => /=
#translate %= => %=
#translate **= => **=
#translate &= => := <x> .AND. <y>
#translate |= => := <x> .OR. <y>
#translate ^= => := <x> .XOR. <y>
#translate <<= => := hb_bitShift(<x>, <y>)
#translate >>= => := hb_bitShift(<x>, -<y>)
#translate >>>= => := hb_bitShift(<x>, -<y>) // unsigned

// Comparação
#translate == => ==
#translate === => ===
#translate != => !=
#translate !== => !==
#translate < => <
#translate > => >
#translate <= => <=
#translate >= => >=

// Lógicos
#translate && => .AND.
#translate || => .OR.
#translate ! => !
#translate ?? => iif(<x> != NIL .AND. <x> != undefined, <x>, <y>)
#translate ?. => :? // optional chaining
#translate !. => : // non-null assertion

// Bitwise
#translate & => .AND.
#translate | => .OR.
#translate ^ => .XOR.
#translate ~ => .NOT.
#translate << => hb_bitShift(<x>, <y>)
#translate >> => hb_bitShift(<x>, -<y>)
#translate >>> => hb_bitShift(<x>, -<y>) // unsigned right shift

// Outros
#translate . => : // property access
#translate [] => // index access
#translate ... => // spread operator
#translate in => $ // in operator
#translate instanceof => hb_isKindOf
#translate typeof => hb_typeOf
#translate void => // void operator
#command delete <property> => <property> := NIL
#command new <Constructor>([<args>]) => <Constructor>:New([<args>])
#command <expr> as <type> => hb_cast(<type>, <expr>)

// ----------------------------------------------------------------------------
// ESTRUTURAS DE CONTROLE
// ----------------------------------------------------------------------------
// IF/ELSE
#command if (<cond>) { => IF <cond>
#command } else if (<cond>) { => ELSEIF <cond>
#command } else { => ELSE
#command } => ENDIF

// FOR
#command for (var <var> = <init>; <cond>; <inc>) { => LOCAL <var> := <init> ; DO WHILE <cond> ; <inc>
#command for (let <var> = <init>; <cond>; <inc>) { => LOCAL <var> := <init> ; DO WHILE <cond> ; <inc>
#command for (const <var> = <init>; <cond>; <inc>) { => LOCAL <var> := <init> ; DO WHILE <cond> ; <inc>
#command } => ; ENDDO

// FOR/IN
#command for (var <key> in <obj>) { => FOR EACH <key> IN hb_HKeys(<obj>)
#command for (let <key> in <obj>) { => FOR EACH <key> IN hb_HKeys(<obj>)
#command for (const <key> in <obj>) { => FOR EACH <key> IN hb_HKeys(<obj>)
#command } => NEXT

// FOR/OF
#command for (var <value> of <iterable>) { => FOR EACH <value> IN <iterable>
#command for (let <value> of <iterable>) { => FOR EACH <value> IN <iterable>
#command for (const <value> of <iterable>) { => FOR EACH <value> IN <iterable>
#command } => NEXT

// FOR/AWAIT/OF
#command for await (var <value> of <asyncIterable>) { => FOR EACH <value> IN <asyncIterable> // async
#command for await (let <value> of <asyncIterable>) { => FOR EACH <value> IN <asyncIterable> // async
#command for await (const <value> of <asyncIterable>) { => FOR EACH <value> IN <asyncIterable> // async
#command } => NEXT

// WHILE
#command while (<cond>) { => DO WHILE <cond>
#command } => ENDDO

// DO/WHILE
#command do { => DO WHILE .T.
#command } while (<cond>); => ; IF !(<cond>) ; EXIT ; ENDIF ; ENDDO

// SWITCH
#command switch (<expr>) { => DO CASE
#command case <value>: => CASE <expr> == <value>
#command case <value1>:
#command case <value2>: => CASE <expr> == <value1> .OR. <expr> == <value2>
#command default: => OTHERWISE
#command break; => EXIT
#command continue; => LOOP
#command } => ENDCASE

// TRY/CATCH
#command try { => BEGIN SEQUENCE
#command } catch (<e>) { => RECOVER USING <e>
#command } finally { => ALWAYS
#command } => END SEQUENCE

#command throw <expr>; => Break(<expr>)
#command throw new Error(<msg>); => Break(ErrorNew(, , <msg>))

// WITH (deprecated mas suportado)
#command with (<obj>) { => // with statement
#command } => // end with

// ----------------------------------------------------------------------------
// FUNÇÕES
// ----------------------------------------------------------------------------
#command function <name>([<params>]) { => FUNCTION <name>([<params>])
#command function <name>([<params>]) { => PROCEDURE <name>([<params>])
#command const <name> = function([<params>]) { => FUNCTION <name>([<params>])
#command let <name> = function([<params>]) { => FUNCTION <name>([<params>])
#command var <name> = function([<params>]) { => FUNCTION <name>([<params>])
#command return <expr>; => RETURN <expr>
#command return; => RETURN NIL
#command } => // end function

// Arrow functions
#command const <name> = ([<params>]) => { => FUNCTION <name>([<params>])
#command let <name> = ([<params>]) => { => FUNCTION <name>([<params>])
#command var <name> = ([<params>]) => { => FUNCTION <name>([<params>])
#command ([<params>]) => { => {|<params>|
#command ([<params>]) => <expr> => {|<params>| <expr>}
#command <param> => <expr> => {|<param>| <expr>}
#command () => <expr> => {|| <expr>}

// Async functions
#command async function <name>([<params>]) { => FUNCTION <name>([<params>]) ASYNC
#command const <name> = async ([<params>]) => { => FUNCTION <name>([<params>]) ASYNC
#command async ([<params>]) => { => FUNCTION([<params>]) ASYNC
#command await <expr> => <expr>:Result

// Generator functions
#command function* <name>([<params>]) { => FUNCTION <name>([<params>]) // generator
#command yield <value>; => AAdd(<yield_array>, <value>)
#command yield* <iterable>; => AEval(<iterable>, {|x| AAdd(<yield_array>, x)})

// IIFE (Immediately Invoked Function Expression)
#command (function() { <code> })(); => {|| <code> }()

// Parâmetros
#command function(<param> = <default>) => FUNCTION( <param> := iif(PCount() >= <pos>, <param>, <default>) )
#command function(...<rest>) => FUNCTION(...) // rest parameter
#command function(<param1>, <param2>, ...<rest>) => FUNCTION(<param1>, <param2>, ...)

// ----------------------------------------------------------------------------
// CLASSES
// ----------------------------------------------------------------------------
#command class <Name> { => CLASS <Name>
#command class <Name> extends <Parent> { => CLASS <Name> FROM <Parent>
#command } => ENDCLASS

// Construtor
#command constructor([<params>]) { => METHOD New([<params>]) CLASS <Name>
#command super([<args>]); => ::Super:New([<args>])

// Métodos
#command <method>([<params>]) { => METHOD <method>([<params>]) CLASS <Name>
#command static <method>([<params>]) { => CLASS METHOD <method>([<params>]) CLASS <Name>
#command get <property>() { => ACCESS <property> CLASS <Name> ; RETURN
#command set <property>(<value>) { => ASSIGN <property>(<value>) CLASS <Name> ; ::<field> := <value>

// Campos
#command <field> = <value>; => VAR <field> := <value>
#command #<privateField> => HIDDEN: <privateField> // private field

// ----------------------------------------------------------------------------
// OBJETOS E LITERAIS
// ----------------------------------------------------------------------------
#command {} => {=>}
#command {<key>: <value>} => {<key> => <value>}
#command {<key>} => {<key> => <key>} // shorthand property
#command {<method>() { <code> }} => {<method> => {|| <code> }} // method shorthand
#command {[<key>]: <value>} => {hb_ValToStr(<key>) => <value>} // computed property
#command <obj>.<property> => <obj>:<property>
#command <obj>[<key>] => hb_HGetDef(<obj>, <key>, NIL)
#command <obj>.<property> = <value> => <obj>:<property> := <value>
#command <obj>[<key>] = <value> => hb_HSet(<obj>, <key>, <value>)
#command delete <obj>.<property> => <obj>:<property> := NIL
#command delete <obj>[<key>] => hb_HDel(<obj>, <key>)
#command <key> in <obj> => hb_HHasKey(<obj>, <key>)
#command Object.keys(<obj>) => hb_HKeys(<obj>)
#command Object.values(<obj>) => hb_HValues(<obj>)
#command Object.entries(<obj>) => hb_HPairs(<obj>)
#command Object.assign(<target>, <source>) => hb_HMerge(<target>, <source>)
#command Object.create(<proto>) => hb_HClone(<proto>)
#command Object.freeze(<obj>) => <obj> // readonly
#command Object.seal(<obj>) => <obj>
#command Object.is(<a>, <b>) => (<a> === <b>)
#command Object.hasOwn(<obj>, <prop>) => hb_HHasKey(<obj>, <prop>)
#command <obj>.hasOwnProperty(<prop>) => hb_HHasKey(<obj>, <prop>)

// Spread operator em objetos
#command {...<obj>} => hb_HClone(<obj>)
#command {...<obj1>, ...<obj2>} => hb_HMerge(hb_HClone(<obj1>), <obj2>)

// Destructuring
#command const { <props> } = <obj>; => LOCAL <props> := hb_HGet(<obj>, "<props>")
#command let { <props> } = <obj>; => LOCAL <props> := hb_HGet(<obj>, "<props>")
#command var { <props> } = <obj>; => LOCAL <props> := hb_HGet(<obj>, "<props>")
#command const { <prop>: <alias> } = <obj>; => LOCAL <alias> := hb_HGet(<obj>, "<prop>")
#command const [ <items> ] = <array>; => LOCAL <items> := <array>[1]
#command let [ <items> ] = <array>; => LOCAL <items> := <array>[1]
#command var [ <items> ] = <array>; => LOCAL <items> := <array>[1]

// ----------------------------------------------------------------------------
// ARRAYS
// ----------------------------------------------------------------------------
#command [] => {}
#command [<items>] => {<items>}
#command Array(<size>) => Array(<size>)
#command Array.from(<iterable>) => hb_ArrayFromIterable(<iterable>)
#command Array.isArray(<obj>) => (ValType(<obj>) == "A")
#command Array.of(<items>) => {<items>}
#command new Array(<size>) => Array(<size>)

// Métodos de Array
#command <array>.length => Len(<array>)
#command <array>[<index>] => <array>[<index>+1] // JS usa 0-based
#command <array>.push(<items>) => AEval({<items>}, {|x| AAdd(<array>, x)})
#command <array>.pop() => hb_APop(<array>)
#command <array>.shift() => hb_APopAt(<array>, 1)
#command <array>.unshift(<items>) => AEval({<items>}, {|x| hb_AIns(<array>, 1, x, .T.)})
#command <array>.slice(<start>[, <end>]) => hb_ArraySlice(<array>, <start>+1, iif(<end>==NIL, Len(<array>), <end>))
#command <array>.splice(<start>, <deleteCount>[, ...<items>]) => hb_ArraySplice(<array>, <start>+1, <deleteCount>, {<items>})
#command <array>.concat(<arrays>) => hb_ArrayMerge(<array>, <arrays>)
#command <array>.join(<separator>) => ArrayToStr(<array>, <separator>)
#command <array>.reverse() => <array> := hb_ArrayReverse(<array>)
#command <array>.sort([<compareFn>]) => ASort(<array>, , , <compareFn>)
#command <array>.map(<callback>) => hb_ArrayEval(<array>, <callback>)
#command <array>.filter(<callback>) => hb_ArrayFilter(<array>, <callback>)
#command <array>.reduce(<callback>[, <initial>]) => hb_ArrayReduce(<array>, <callback>, <initial>)
#command <array>.reduceRight(<callback>[, <initial>]) => hb_ArrayReduceRight(<array>, <callback>, <initial>)
#command <array>.forEach(<callback>) => AEval(<array>, <callback>)
#command <array>.every(<callback>) => (AScan(<array>, {|x| !<callback>(x)}) == 0)
#command <array>.some(<callback>) => (AScan(<array>, {|x| <callback>(x)}) > 0)
#command <array>.indexOf(<search>[, <from>]) => AScan(<array>, {|x| x == <search>}, iif(<from>==NIL, 1, <from>+1))-1
#command <array>.lastIndexOf(<search>[, <from>]) => hb_RScan(<array>, {|x| x == <search>}, iif(<from>==NIL, Len(<array>), <from>+1))-1
#command <array>.find(<callback>) => hb_ArrayFind(<array>, <callback>)
#command <array>.findIndex(<callback>) => AScan(<array>, {|x| <callback>(x)})-1
#command <array>.findLast(<callback>) => hb_ArrayFindLast(<array>, <callback>)
#command <array>.findLastIndex(<callback>) => hb_RScan(<array>, {|x| <callback>(x)})-1
#command <array>.includes(<search>[, <from>]) => (AScan(<array>, {|x| x == <search>}, iif(<from>==NIL, 1, <from>+1)) > 0)
#command <array>.flat([<depth>]) => hb_ArrayFlat(<array>, <depth>)
#command <array>.flatMap(<callback>) => hb_ArrayFlatMap(<array>, <callback>)
#command <array>.at(<index>) => <array>[iif(<index> >= 0, <index>+1, Len(<array>)+<index>+1)]
#command <array>.toReversed() => hb_ArrayReverse(AClone(<array>))
#command <array>.toSorted([<compareFn>]) => ASort(AClone(<array>), , , <compareFn>)
#command <array>.toSpliced(<start>, <deleteCount>[, ...<items>]) => hb_ArraySplice(AClone(<array>), <start>+1, <deleteCount>, {<items>})
#command <array>.with(<index>, <value>) => hb_ArrayWith(AClone(<array>), <index>+1, <value>)

// Spread operator em arrays
#command [...<array>] => AClone(<array>)
#command [...<array1>, ...<array2>] => hb_ArrayMerge(<array1>, <array2>)

// Destructuring de array
#command const [<first>, ...<rest>] = <array>; => LOCAL <first> := <array>[1], <rest> := hb_ArraySlice(<array>, 2)
#command let [<first>, ...<rest>] = <array>; => LOCAL <first> := <array>[1], <rest> := hb_ArraySlice(<array>, 2)

// ----------------------------------------------------------------------------
// STRINGS
// ----------------------------------------------------------------------------
#command '<str>' => "<str>"
#command "<str>" => "<str>"
#command `<template>` => "<template>" // template literal
#command `<text>${<expr>}<text2>` => "<text>" + hb_ValToStr(<expr>) + "<text2>"
#command String.raw`<template>` => "<template>" // raw template
#command <str>.length => Len(<str>)
#command <str>.charAt(<index>) => SubStr(<str>, <index>+1, 1)
#command <str>.charCodeAt(<index>) => Asc(SubStr(<str>, <index>+1, 1))
#command <str>.codePointAt(<index>) => Asc(SubStr(<str>, <index>+1, 1))
#command <str>.substring(<start>[, <end>]) => SubStr(<str>, <start>+1, iif(<end>==NIL, Len(<str>)-<start>, <end>-<start>))
#command <str>.substr(<start>[, <length>]) => SubStr(<str>, <start>+1, <length>)
#command <str>.slice(<start>[, <end>]) => SubStr(<str>, <start>+1, iif(<end>==NIL, Len(<str>)-<start>, <end>-<start>))
#command <str>.split(<separator>[, <limit>]) => hb_ATokens(<str>, <separator>, <limit>)
#command <str>.toLowerCase() => Lower(<str>)
#command <str>.toUpperCase() => Upper(<str>)
#command <str>.trim() => AllTrim(<str>)
#command <str>.trimStart() => LTrim(<str>)
#command <str>.trimEnd() => RTrim(<str>)
#command <str>.trimLeft() => LTrim(<str>)
#command <str>.trimRight() => RTrim(<str>)
#command <str>.padStart(<length>[, <pad>]) => PadL(<str>, <length>, iif(<pad>==NIL, " ", <pad>))
#command <str>.padEnd(<length>[, <pad>]) => PadR(<str>, <length>, iif(<pad>==NIL, " ", <pad>))
#command <str>.replace(<search>, <replace>) => StrTran(<str>, <search>, <replace>)
#command <str>.replaceAll(<search>, <replace>) => StrTran(<str>, <search>, <replace>)
#command <str>.includes(<search>[, <position>]) => (At(<search>, <str>, iif(<position>==NIL, 1, <position>+1)) > 0)
#command <str>.indexOf(<search>[, <position>]) => At(<search>, <str>, iif(<position>==NIL, 1, <position>+1))-1
#command <str>.lastIndexOf(<search>[, <position>]) => hb_RAt(<search>, <str>, iif(<position>==NIL, 1, <position>+1))-1
#command <str>.startsWith(<search>[, <position>]) => (Left(SubStr(<str>, iif(<position>==NIL, 1, <position>+1)), Len(<search>)) == <search>)
#command <str>.endsWith(<search>[, <length>]) => (Right(iif(<length>==NIL, <str>, Left(<str>, <length>)), Len(<search>)) == <search>)
#command <str>.match(<regexp>) => hb_regex(<regexp>, <str>)
#command <str>.matchAll(<regexp>) => hb_regexAll(<regexp>, <str>)
#command <str>.search(<regexp>) => At(hb_regex(<regexp>, <str>), <str>)-1
#command <str>.repeat(<count>) => Replicate(<str>, <count>)
#command <str>.normalize([<form>]) => <str> // normalize Unicode
#command <str>.localeCompare(<other>) => iif(<str> < <other>, -1, iif(<str> > <other>, 1, 0))
#command String.fromCharCode(<codes>) => hb_StrFromArray({<codes>})
#command String.fromCodePoint(<codes>) => hb_StrFromArray({<codes>})
#command String.raw`<template>` => "<template>"

// ----------------------------------------------------------------------------
// NÚMEROS E MATH
// ----------------------------------------------------------------------------
#command Number(<value>) => Val(<value>)
#command <num>.toFixed([<digits>]) => Str(<num>, , iif(<digits>==NIL, 0, <digits>))
#command <num>.toPrecision([<precision>]) => // to precision
#command <num>.toString([<radix>]) => hb_NumToStr(<num>, <radix>)
#command <num>.toExponential([<fractionDigits>]) => // to exponential
#command parseInt(<str>[, <radix>]) => Int(Val(<str>))
#command parseFloat(<str>) => Val(<str>)
#command isNaN(<value>) => // is NaN
#command isFinite(<value>) => // is finite
#command Number.isNaN(<value>) => // Number.isNaN
#command Number.isFinite(<value>) => // Number.isFinite
#command Number.isInteger(<value>) => (Int(<value>) == <value>)
#command Number.isSafeInteger(<value>) => (Abs(<value>) <= 9007199254740991)
#command Number.MAX_SAFE_INTEGER => 9007199254740991
#command Number.MIN_SAFE_INTEGER => -9007199254740991
#command Number.MAX_VALUE => 1.7976931348623157e+308
#command Number.MIN_VALUE => 5e-324
#command Number.EPSILON => 2.220446049250313e-16
#command Number.POSITIVE_INFINITY => 1/0
#command Number.NEGATIVE_INFINITY => -1/0
#command Math.abs(<x>) => Abs(<x>)
#command Math.ceil(<x>) => Ceiling(<x>)
#command Math.floor(<x>) => Floor(<x>)
#command Math.round(<x>) => Round(<x>)
#command Math.max(<values>) => Max(<values>)
#command Math.min(<values>) => Min(<values>)
#command Math.pow(<x>, <y>) => (<x> ** <y>)
#command Math.sqrt(<x>) => Sqrt(<x>)
#command Math.cbrt(<x>) => (<x> ** (1/3))
#command Math.hypot(<values>) => Sqrt(hb_ArraySum(hb_ArrayEval({<values>}, {|x| x*x})))
#command Math.random() => hb_Random()
#command Math.PI => 3.141592653589793
#command Math.E => 2.718281828459045
#command Math.LN2 => 0.6931471805599453
#command Math.LN10 => 2.302585092994046
#command Math.LOG2E => 1.4426950408889634
#command Math.LOG10E => 0.4342944819032518
#command Math.SQRT2 => 1.4142135623730951
#command Math.SQRT1_2 => 0.7071067811865476
#command Math.sin(<x>) => Sin(<x>)
#command Math.cos(<x>) => Cos(<x>)
#command Math.tan(<x>) => Tan(<x>)
#command Math.asin(<x>) => Asin(<x>)
#command Math.acos(<x>) => Acos(<x>)
#command Math.atan(<x>) => Atan(<x>)
#command Math.atan2(<y>, <x>) => Atan2(<y>, <x>)
#command Math.sinh(<x>) => // hyperbolic sine
#command Math.cosh(<x>) => // hyperbolic cosine
#command Math.tanh(<x>) => // hyperbolic tangent
#command Math.asinh(<x>) => // hyperbolic arcsine
#command Math.acosh(<x>) => // hyperbolic arccosine
#command Math.atanh(<x>) => // hyperbolic arctangent
#command Math.log(<x>) => Log(<x>)
#command Math.log10(<x>) => Log10(<x>)
#command Math.log2(<x>) => (Log(<x>) / Log(2))
#command Math.log1p(<x>) => Log(1 + <x>)
#command Math.exp(<x>) => Exp(<x>)
#command Math.expm1(<x>) => (Exp(<x>) - 1)
#command Math.sign(<x>) => iif(<x> > 0, 1, iif(<x> < 0, -1, 0))
#command Math.trunc(<x>) => Int(<x>)
#command Math.fround(<x>) => <x> // float round
#command Math.imul(<a>, <b>) => Int(<a> * <b>) // integer multiplication
#command Math.clz32(<x>) => hb_bitLeadingZeros(<x>) // count leading zeros

// ----------------------------------------------------------------------------
// DATES
// ----------------------------------------------------------------------------
#command new Date() => hb_DateTime()
#command new Date(<value>) => hb_StrToT(<value>)
#command new Date(<year>, <month>[, <day>[, <hour>[, <minute>[, <second>[, <ms>]]]]]) => ;
    hb_DateTime(<year>, <month>+1, iif(<day>==NIL, 1, <day>), ;
    iif(<hour>==NIL, 0, <hour>), iif(<minute>==NIL, 0, <minute>), ;
    iif(<second>==NIL, 0, <second>), iif(<ms>==NIL, 0, <ms>))
#command Date.now() => hb_MilliSeconds()
#command Date.parse(<string>) => hb_StrToT(<string>)
#command Date.UTC(<year>, <month>[, <day>[, <hour>[, <minute>[, <second>[, <ms>]]]]]) => ;
    hb_UTCDateTime(<year>, <month>+1, iif(<day>==NIL, 1, <day>), ;
    iif(<hour>==NIL, 0, <hour>), iif(<minute>==NIL, 0, <minute>), ;
    iif(<second>==NIL, 0, <second>), iif(<ms>==NIL, 0, <ms>))
#command <date>.getFullYear() => Year(<date>)
#command <date>.getMonth() => Month(<date>)-1 // JS usa 0-11
#command <date>.getDate() => Day(<date>)
#command <date>.getDay() => DoW(<date>)-1 // JS usa 0-6
#command <date>.getHours() => hb_Hour(<date>)
#command <date>.getMinutes() => hb_Minute(<date>)
#command <date>.getSeconds() => hb_Sec(<date>)
#command <date>.getMilliseconds() => 0
#command <date>.getTime() => hb_TToN(<date>)
#command <date>.getTimezoneOffset() => 0 // timezone offset
#command <date>.getUTCFullYear() => Year(hb_UTCDate(<date>))
#command <date>.getUTCMonth() => Month(hb_UTCDate(<date>))-1
#command <date>.getUTCDate() => Day(hb_UTCDate(<date>))
#command <date>.getUTCDay() => DoW(hb_UTCDate(<date>))-1
#command <date>.getUTCHours() => hb_Hour(hb_UTCDateTime(<date>))
#command <date>.getUTCMinutes() => hb_Minute(hb_UTCDateTime(<date>))
#command <date>.getUTCSeconds() => hb_Sec(hb_UTCDateTime(<date>))
#command <date>.getUTCMilliseconds() => 0
#command <date>.setFullYear(<year>[, <month>[, <date>]]) => <date> := hb_DateSet(<date>, "Y", <year>)
#command <date>.setMonth(<month>[, <date>]) => <date> := hb_DateSet(<date>, "M", <month>+1)
#command <date>.setDate(<date>) => <date> := hb_DateSet(<date>, "D", <date>)
#command <date>.setHours(<hour>[, <min>[, <sec>[, <ms>]]]) => // set hours
#command <date>.setMinutes(<min>[, <sec>[, <ms>]]) => // set minutes
#command <date>.setSeconds(<sec>[, <ms>]) => // set seconds
#command <date>.setMilliseconds(<ms>) => // set milliseconds
#command <date>.setTime(<time>) => <date> := hb_NToT(<time>)
#command <date>.setUTCFullYear(<year>[, <month>[, <date>]]) => // set UTC
#command <date>.setUTCMonth(<month>[, <date>]) => // set UTC
#command <date>.setUTCDate(<date>) => // set UTC
#command <date>.setUTCHours(<hour>[, <min>[, <sec>[, <ms>]]]) => // set UTC
#command <date>.setUTCMinutes(<min>[, <sec>[, <ms>]]) => // set UTC
#command <date>.setUTCSeconds(<sec>[, <ms>]) => // set UTC
#command <date>.setUTCMilliseconds(<ms>) => // set UTC
#command <date>.toISOString() => hb_TToC(<date>)
#command <date>.toJSON() => hb_JsonEncode(hb_TToC(<date>))
#command <date>.toString() => DToC(<date>)
#command <date>.toDateString() => DToC(<date>)
#command <date>.toTimeString() => // time string
#command <date>.toLocaleString() => DToC(<date>)
#command <date>.toLocaleDateString() => DToC(<date>)
#command <date>.toLocaleTimeString() => // locale time string
#command <date>.toUTCString() => // UTC string
#command <date>.valueOf() => hb_TToN(<date>)

// ----------------------------------------------------------------------------
// JSON
// ----------------------------------------------------------------------------
#command JSON.stringify(<obj>) => hb_JsonEncode(<obj>)
#command JSON.parse(<str>) => hb_JsonDecode(<str>)

// ----------------------------------------------------------------------------
// REGEX
// ----------------------------------------------------------------------------
#command /<pattern>/<flags> => hb_regexComp("<pattern>", "<flags>")
#command new RegExp(<pattern>[, <flags>]) => hb_regexComp(<pattern>, <flags>)
#command <regex>.exec(<str>) => hb_regex(<regex>, <str>)
#command <regex>.test(<str>) => hb_regexLike(<regex>, <str>)
#command <regex>.source => :cPattern
#command <regex>.flags => :cFlags
#command <regex>.global => :lGlobal
#command <regex>.ignoreCase => :lIgnoreCase
#command <regex>.multiline => :lMultiline
#command <regex>.dotAll => :lDotAll
#command <regex>.unicode => :lUnicode
#command <regex>.sticky => :lSticky
#command <regex>.lastIndex => :nLastIndex

// ----------------------------------------------------------------------------
// SET E MAP
// ----------------------------------------------------------------------------
#command new Set([<iterable>]) => hb_ArrayToSet({<iterable>})
#command new WeakSet([<iterable>]) => hb_ArrayToSet({<iterable>})