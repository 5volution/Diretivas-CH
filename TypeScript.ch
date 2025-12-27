// ============================================================================
// DIRETIVAS COMPLETAS PARA TRADUÇÃO TYPESCRIPT PARA XHARBOUR
// ============================================================================

// ----------------------------------------------------------------------------
// ESTRUTURA E IMPORTS
// ----------------------------------------------------------------------------
#command // <comment> => // <comment>
#command /* <comment> */ => /* <comment> */
#command /** <doc> */ => //! <doc> - documentação
#command /// <reference path="<file>" /> => #include "<file>.ch"
#command import <import> from '<module>'; => #include "<module>.ch"
#command import * as <alias> from '<module>'; => #include "<module>.ch" AS <alias>
#command import { <items> } from '<module>'; => #include "<module>.ch"
#command export <item>; => // export <item>
#command export default <item>; => // export default <item>
#command export { <items> }; => // export { <items> }
#command declare module '<name>' { => // module <name>
#command } => // end module
#command declare global { => // global declarations
#command } => // end global

// ----------------------------------------------------------------------------
// TIPOS BÁSICOS
// ----------------------------------------------------------------------------
#translate any => // any type
#translate unknown => // unknown type
#translate never => // never type
#translate void => // void type
#translate null => NIL
#translate undefined => NIL
#translate boolean => LOGICAL
#translate number => NUMERIC
#translate string => CHARACTER
#translate symbol => // symbol type
#translate bigint => NUMERIC // big integer
#translate object => OBJECT
#translate Function => BLOCK
#translate Array => ARRAY
#translate ReadonlyArray => ARRAY // readonly array

// Tipos literais
#translate true => .T.
#translate false => .F.
#translate '<literal>' => "<literal>" // string literal type
#translate <number> => <number> // number literal type

// ----------------------------------------------------------------------------
// TIPOS AVANÇADOS
// ----------------------------------------------------------------------------
#translate <type>[] => ARRAY // array type
#translate Array<<type>> => ARRAY // generic array
#translate [<types>] => ARRAY // tuple
#translate [<type>, ...<rest>] => ARRAY // rest in tuple
#translate { <members> } => // object type
#translate (<params>) => <ret> => BLOCK // function type
#translate ()=> <ret> => BLOCK // function type sem params
#translate keyof <type> => // keyof operator
#translate typeof <expr> => hb_typeOf(<expr>)
#translate readonly <type> => // readonly modifier
#translate <type> | <type2> => // union type
#translate <type> & <type2> => // intersection type
#translate <T> extends <U> ? <X> : <Y> => // conditional type
#translate infer <T> => // infer type
#translate keyof <T> => hb_keysOf(<T>)
#translate Partial<<T>> => // partial type
#translate Required<<T>> => // required type
#translate Readonly<<T>> => // readonly type
#translate Record<<K, V>> => HASH // record type
#translate Pick<<T, K>> => // pick type
#translate Omit<<T, K>> => // omit type
#translate Exclude<<T, U>> => // exclude type
#translate Extract<<T, U>> => // extract type
#translate NonNullable<<T>> => // non-nullable type
#translate ReturnType<<T>> => // return type
#translate InstanceType<<T>> => // instance type
#translate ThisType<<T>> => // this type
#translate Uppercase<<S>> => Upper(<S>) // uppercase
#translate Lowercase<<S>> => Lower(<S>) // lowercase
#translate Capitalize<<S>> => // capitalize
#translate Uncapitalize<<S>> => // uncapitalize

// ----------------------------------------------------------------------------
// DECLARAÇÕES DE VARIÁVEIS
// ----------------------------------------------------------------------------
#command let <var>: <type> = <value>; => LOCAL <var> AS <type> := <value>
#command let <var> = <value>; => LOCAL <var> := <value>
#command const <var>: <type> = <value>; => #define <var> <value>
#command const <var> = <value>; => #define <var> <value>
#command var <var>: <type> = <value>; => STATIC <var> AS <type> := <value>
#command var <var> = <value>; => STATIC <var> := <value>

// ----------------------------------------------------------------------------
#command <var>: <type>; => // type annotation

// ----------------------------------------------------------------------------
// FUNÇÕES
// ----------------------------------------------------------------------------
#command function <name>([<params>]): <ret> { => FUNCTION <name>([<params>]) AS <ret>
#command function <name>([<params>]) { => PROCEDURE <name>([<params>])
#command const <name> = ([<params>]): <ret> => { => FUNCTION <name>([<params>]) AS <ret>
#command const <name> = ([<params>]) => { => FUNCTION <name>([<params>])
#command (<params>): <ret> => { => {|<params>| // AS <ret>
#command (<params>) => { => {|<params>|
#command return <expr>; => RETURN <expr>
#command return; => RETURN NIL
#command } => // end function
#command => <expr> => RETURN <expr> // arrow function body

// Parâmetros
#command <param>: <type> => <param> AS <type>
#command <param>: <type> = <default> => <param> AS <type> := iif(PCount() >= <pos>, <param>, <default>)
#command ...<param>: <type>[] => ... // rest parameter
#command ?: => // optional parameter

// Funções async
#command async function <name>([<params>]): Promise<<type>> { => FUNCTION <name>([<params>]) ASYNC AS <type>
#command const <name> = async ([<params>]): Promise<<type>> => { => FUNCTION <name>([<params>]) ASYNC AS <type>
#command await <expr> => <expr>:Result
#command Promise<<type>> => // Promise type

// Generator functions
#command function* <name>([<params>]) { => FUNCTION <name>([<params>]) // generator
#command yield <value>; => AAdd(<yield_array>, <value>)
#command yield* <iterable>; => AEval(<iterable>, {|x| AAdd(<yield_array>, x)})

// ----------------------------------------------------------------------------
// CLASSES
// ----------------------------------------------------------------------------
#command class <Name> { => CLASS <Name>
#command class <Name> extends <Parent> { => CLASS <Name> FROM <Parent>
#command class <Name> implements <Interface> { => CLASS <Name> // implements
#command abstract class <Name> { => CLASS <Name> // abstract
#command } => ENDCLASS

// Membros da classe
#command public <member> => EXPORTED: <member>
#command private <member> => HIDDEN: <member>
#command protected <member> => PROTECTED: <member>
#command readonly <member> => // readonly member
#command static <member> => CLASS <member>
#command abstract <method>([<params>]): <ret>; => // abstract method
#command #<privateField> => HIDDEN: <privateField> // private field

// Construtor
#command constructor([<params>]) { => METHOD New([<params>]) CLASS <Name>
#command super([<args>]); => ::Super:New([<args>])
#command this.<property> = <value>; => ::<property> := <value>

// Métodos
#command <method>([<params>]): <ret> { => METHOD <method>([<params>]) CLASS <Name> AS <ret>
#command <method>([<params>]) { => METHOD <method>([<params>]) CLASS <Name>
#command get <property>(): <type> { => ACCESS <property> CLASS <Name> AS <type> ; RETURN
#command set <property>(<value>: <type>) { => ASSIGN <property>(<value> AS <type>) CLASS <Name> ; ::<field> := <value>

// ----------------------------------------------------------------------------
// INTERFACES
// ----------------------------------------------------------------------------
#command interface <Name> { => // interface <Name>
#command } => // end interface
#command interface <Name> extends <Parent> { => // interface extends
#command <property>: <type>; => // property
#command <method>([<params>]): <ret>; => // method
#command new ([<params>]): <type>; => // constructor
#command [<key>: <type>]: <value>; => // index signature
#command readonly <property>: <type>; => // readonly property
#command ?: => // optional property

// ----------------------------------------------------------------------------
#command interface <Name><<T>> { => // generic interface

// ----------------------------------------------------------------------------
// TYPE ALIASES
// ----------------------------------------------------------------------------
#command type <Name> = <type>; => #define <Name> <type>
#command type <Name><<T>> = <type>; => // generic type alias

// ----------------------------------------------------------------------------
// ENUMS
// ----------------------------------------------------------------------------
#command enum <Name> { => // enum <Name>
#command <Key> = <Value>, => // enum member
#command <Key>, => // enum member auto-increment
#command } => // end enum
#command const enum <Name> { => // const enum
#command } => // end const enum

// ----------------------------------------------------------------------------
#command <enum>.<member> => // enum member access

// ----------------------------------------------------------------------------
// NAMESPACES
// ----------------------------------------------------------------------------
#command namespace <Name> { => // namespace <Name>
#command } => // end namespace
#command declare namespace <Name> { => // declare namespace
#command } => // end declare namespace

// ----------------------------------------------------------------------------
// MODULES
// ----------------------------------------------------------------------------
#command module '<name>' { => // module <name>
#command } => // end module

// ----------------------------------------------------------------------------
// DECLARAÇÕES
// ----------------------------------------------------------------------------
#command declare var <name>: <type>; => STATIC <name> AS <type>
#command declare let <name>: <type>; => LOCAL <name> AS <type>
#command declare const <name>: <type>; => #define <name> <type>
#command declare function <name>([<params>]): <ret>; => DECLARE FUNCTION <name>([<params>]) AS <ret>
#command declare class <Name> { => DECLARE CLASS <Name>
#command declare enum <Name> { => DECLARE // enum
#command declare interface <Name> { => // declare interface
#command declare type <Name> = <type>; => #define <Name> <type>
#command declare module '<name>' { => // declare module
#command declare global { => // declare global

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

// Atribuição
#translate = => :=
#translate += => +=
#translate -= => -=
#translate *= => *=
#translate /= => /=
#translate %= => %=
#translate **= => **=
#translate &&= => := iif(<x>, <y>, <x>)
#translate ||= => := iif(<x>, <x>, <y>)
#translate ??= => := iif(<x> == NIL .OR. <x> == NIL, <y>, <x>)

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
#translate ?? => iif(<x> != NIL .AND. <x> != NIL, <x>, <y>)

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
#translate ?. => :? // optional chaining
#translate !. => : // non-null assertion
#translate [] => // index access
#command <obj> as <type> => hb_cast(<type>, <obj>)
#command <obj> instanceof <type> => hb_isKindOf(<obj>, <type>)
#translate in => $ // in operator
#translate delete <property> => <property> := NIL
#translate typeof => hb_typeOf
#translate void => // void operator
#command new <Type>([<args>]) => <Type>:New([<args>])
#command <expr> satisfies <type> => <expr> // satisfies operator

// ----------------------------------------------------------------------------
// ESTRUTURAS DE CONTROLE
// ----------------------------------------------------------------------------
// IF/ELSE
#command if (<cond>) { => IF <cond>
#command } else if (<cond>) { => ELSEIF <cond>
#command } else { => ELSE
#command } => ENDIF

// FOR
#command for (let <var> = <init>; <cond>; <inc>) { => LOCAL <var> := <init> ; DO WHILE <cond> ; <inc>
#command } => ; ENDDO
#command for (const <var> in <obj>) { => FOR EACH <var> IN hb_HKeys(<obj>)
#command } => NEXT
#command for (const <var> of <iterable>) { => FOR EACH <var> IN <iterable>
#command } => NEXT
#command for await (const <var> of <asyncIterable>) { => FOR EACH <var> IN <asyncIterable> // async

// WHILE
#command while (<cond>) { => DO WHILE <cond>
#command } => ENDDO

// DO-WHILE
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
#command } catch (<e>: <type>) { => RECOVER USING <e> IF ValType(<e>) == "O" .AND. <e>:ClassName == "<type>"
#command } catch (<e>) { => RECOVER USING <e>
#command } finally { => ALWAYS
#command } => END SEQUENCE

#command throw <expr>; => Break(<expr>)
#command throw new Error(<msg>); => Break(ErrorNew(, , <msg>))

// ----------------------------------------------------------------------------
// TEMPLATE STRINGS
// ----------------------------------------------------------------------------
#command `<text>` => "<text>" // template string
#command `<text>${<expr>}<text2>` => "<text>" + hb_ValToStr(<expr>) + "<text2>"
#command String.raw`<text>` => "<text>" // raw template string

// ----------------------------------------------------------------------------
#command `<text>${<expr1>}${<expr2>}` => "<text>" + hb_ValToStr(<expr1>) + hb_ValToStr(<expr2>)

// ----------------------------------------------------------------------------
// ARRAYS
// ----------------------------------------------------------------------------
#command [] => {}
#command [<items>] => {<items>}
#command Array(<size>) => Array(<size>)
#command Array.from(<iterable>) => hb_ArrayFromIterable(<iterable>)
#command Array.isArray(<obj>) => (ValType(<obj>) == "A")
#command Array.of(<items>) => {<items>}

// Métodos de Array
#command <array>.length => Len(<array>)
#command <array>[<index>] => <array>[<index>+1] // TS usa 0-based
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

// ----------------------------------------------------------------------------
// OBJETOS
// ----------------------------------------------------------------------------
#command {} => {=>}
#command {<key>: <value>} => {<key> => <value>}
#command Object.assign(<target>, <sources>) => hb_HMerge(<target>, <sources>)
#command Object.create(<proto>) => hb_HClone(<proto>)
#command Object.keys(<obj>) => hb_HKeys(<obj>)
#command Object.values(<obj>) => hb_HValues(<obj>)
#command Object.entries(<obj>) => hb_HPairs(<obj>)
#command Object.fromEntries(<entries>) => hb_HashFromArray(<entries>)
#command Object.freeze(<obj>) => <obj> // readonly
#command Object.seal(<obj>) => <obj>
#command Object.is(<a>, <b>) => (<a> === <b>)
#command Object.hasOwn(<obj>, <prop>) => hb_HHasKey(<obj>, <prop>)
#command <obj>.hasOwnProperty(<prop>) => hb_HHasKey(<obj>, <prop>)

// ----------------------------------------------------------------------------
#command <obj>[<key>] => hb_HGetDef(<obj>, <key>, NIL)
#command <obj>[<key>] = <value> => hb_HSet(<obj>, <key>, <value>)
#command delete <obj>[<key>] => hb_HDel(<obj>, <key>)
#command <key> in <obj> => hb_HHasKey(<obj>, <key>)

// Spread operator
#command ...<obj> => hb_HClone(<obj>)
#command ...<array> => AClone(<array>)

// Destructuring
#command const { <props> } = <obj>; => LOCAL <props> := hb_HGet(<obj>, "<props>")
#command let { <props> } = <obj>; => LOCAL <props> := hb_HGet(<obj>, "<props>")
#command const [ <items> ] = <array>; => LOCAL <items> := <array>[1]
#command let [ <items> ] = <array>; => LOCAL <items> := <array>[1]

// ----------------------------------------------------------------------------
// SET E MAP
// ----------------------------------------------------------------------------
#command new Set([<iterable>]) => hb_ArrayToSet({<iterable>})
#command new Map([<entries>]) => hb_HashFromArray({<entries>})
#command <set>.add(<value>) => hb_HSet(<set>, <value>, .T.)
#command <set>.has(<value>) => hb_HHasKey(<set>, <value>)
#command <set>.delete(<value>) => hb_HDel(<set>, <value>)
#command <set>.size => Len(<set>)
#command <map>.set(<key>, <value>) => hb_HSet(<map>, <key>, <value>)
#command <map>.get(<key>) => hb_HGetDef(<map>, <key>, NIL)
#command <map>.has(<key>) => hb_HHasKey(<map>, <key>)
#command <map>.delete(<key>) => hb_HDel(<map>, <key>)
#command <map>.size => Len(<map>)

// ----------------------------------------------------------------------------
#command <map>.keys() => hb_HKeys(<map>)
#command <map>.values() => hb_HValues(<map>)
#command <map>.entries() => hb_HPairs(<map>)

// ----------------------------------------------------------------------------
// STRINGS
// ----------------------------------------------------------------------------
#command '<str>' => "<str>"
#command "<str>" => "<str>"
#command <str>.length => Len(<str>)
#command <str>.charAt(<index>) => SubStr(<str>, <index>+1, 1)
#command <str>.charCodeAt(<index>) => Asc(SubStr(<str>, <index>+1, 1))
#command <str>.substring(<start>[, <end>]) => SubStr(<str>, <start>+1, iif(<end>==NIL, Len(<str>)-<start>, <end>-<start>))
#command <str>.substr(<start>[, <length>]) => SubStr(<str>, <start>+1, <length>)
#command <str>.slice(<start>[, <end>]) => SubStr(<str>, <start>+1, iif(<end>==NIL, Len(<str>)-<start>, <end>-<start>))
#command <str>.split(<separator>[, <limit>]) => hb_ATokens(<str>, <separator>, <limit>)
#command <str>.toLowerCase() => Lower(<str>)
#command <str>.toUpperCase() => Upper(<str>)
#command <str>.trim() => AllTrim(<str>)
#command <str>.trimStart() => LTrim(<str>)
#command <str>.trimEnd() => RTrim(<str>)
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
#command String.fromCharCode(<codes>) => hb_StrFromArray({<codes>})

// ----------------------------------------------------------------------------
// NÚMEROS E MATH
// ----------------------------------------------------------------------------
#command Number(<value>) => Val(<value>)
#command <num>.toFixed([<digits>]) => Str(<num>, , iif(<digits>==NIL, 0, <digits>))
#command <num>.toPrecision([<precision>]) => // to precision
#command <num>.toString([<radix>]) => hb_NumToStr(<num>, <radix>)
#command parseInt(<str>[, <radix>]) => Int(Val(<str>))
#command parseFloat(<str>) => Val(<str>)
#command isNaN(<value>) => // is NaN
#command isFinite(<value>) => // is finite
#command Math.abs(<x>) => Abs(<x>)
#command Math.ceil(<x>) => Ceiling(<x>)
#command Math.floor(<x>) => Floor(<x>)
#command Math.round(<x>) => Round(<x>)
#command Math.max(<values>) => Max(<values>)
#command Math.min(<values>) => Min(<values>)
#command Math.pow(<x>, <y>) => (<x> ** <y>)
#command Math.sqrt(<x>) => Sqrt(<x>)
#command Math.random() => hb_Random()
#command Math.PI => 3.14159265358979
#command Math.E => 2.71828182845905
#command Math.sin(<x>) => Sin(<x>)
#command Math.cos(<x>) => Cos(<x>)
#command Math.tan(<x>) => Tan(<x>)
#command Math.log(<x>) => Log(<x>)
#command Math.exp(<x>) => Exp(<x>)

// ----------------------------------------------------------------------------
#command Math.asin(<x>) => Asin(<x>)
#command Math.acos(<x>) => Acos(<x>)
#command Math.atan(<x>) => Atan(<x>)
#command Math.atan2(<y>, <x>) => Atan2(<y>, <x>)

// ----------------------------------------------------------------------------
// DATE
// ----------------------------------------------------------------------------
#command new Date() => hb_DateTime()
#command new Date(<value>) => hb_StrToT(<value>)
#command Date.now() => hb_MilliSeconds()
#command Date.parse(<string>) => hb_StrToT(<string>)
#command <date>.getFullYear() => Year(<date>)
#command <date>.getMonth() => Month(<date>)-1 // TS usa 0-11
#command <date>.getDate() => Day(<date>)
#command <date>.getDay() => DoW(<date>)-1 // TS usa 0-6
#command <date>.getHours() => hb_Hour(<date>)
#command <date>.getMinutes() => hb_Minute(<date>)
#command <date>.getSeconds() => hb_Sec(<date>)
#command <date>.getMilliseconds() => 0
#command <date>.getTime() => hb_TToN(<date>)
#command <date>.toISOString() => hb_TToC(<date>)
#command <date>.toLocaleString() => DToC(<date>)
#command <date>.toString() => DToC(<date>)

// ----------------------------------------------------------------------------
// JSON
// ----------------------------------------------------------------------------
#command JSON.stringify(<obj>) => hb_JsonEncode(<obj>)
#command JSON.parse(<str>) => hb_JsonDecode(<str>)

// ----------------------------------------------------------------------------
// CONSOLE
// ----------------------------------------------------------------------------
#command console.log(<args>) => QOut(<args>)
#command console.info(<args>) => QOut("[INFO]", <args>)
#command console.warn(<args>) => QOut("[WARN]", <args>)
#command console.error(<args>) => QErr(<args>)
#command console.debug(<args>) => QOut("[DEBUG]", <args>)
#command console.trace() => // trace
#command console.time(<label>) => // start timer
#command console.timeEnd(<label>) => // end timer
#command console.assert(<cond>, <msg>) => #ifdef DEBUG ; IF !(<cond>) ; Break(ErrorNew(, , <msg>)) ; ENDIF ; #endif

// ----------------------------------------------------------------------------
// ASSERTIONS DE TIPO
// ----------------------------------------------------------------------------
#command <expr> as <type> => hb_cast(<type>, <expr>)
#command <type> <expr> => hb_cast(<type>, <expr>) // type assertion
#command <expr>! => <expr> // non-null assertion

// ----------------------------------------------------------------------------
// UTILITÁRIOS
// ----------------------------------------------------------------------------
#command typeof <expr> => hb_typeOf(<expr>)
#command keyof <type> => hb_keysOf(<type>)
#command <T> extends <U> ? <X> : <Y> => // conditional type
#command infer <T> => // infer keyword

// ----------------------------------------------------------------------------
// UTILITY TYPES
// ----------------------------------------------------------------------------
#command Partial<<T>> => // partial
#command Required<<T>> => // required
#command Readonly<<T>> => // readonly
#command Record<<K, V>> => HASH
#command Pick<<T, K>> => // pick
#command Omit<<T, K>> => // omit
#command Exclude<<T, U>> => // exclude
#command Extract<<T, U>> => // extract
#command NonNullable<<T>> => // non-nullable
#command Parameters<<T>> => // parameters
#command ConstructorParameters<<T>> => // constructor parameters
#command ReturnType<<T>> => // return type
#command InstanceType<<T>> => // instance type
#command ThisParameterType<<T>> => // this parameter type
#command OmitThisParameter<<T>> => // omit this parameter
#command ThisType<<T>> => // this type
#command Uppercase<<S>> => Upper(<S>)
#command Lowercase<<S>> => Lower(<S>)
#command Capitalize<<S>> => // capitalize
#command Uncapitalize<<S>> => // uncapitalize

// ----------------------------------------------------------------------------
// DECORATORS
// ----------------------------------------------------------------------------
#command @<decorator> => // decorator
#command @<decorator>(<args>) => // decorator with args
#command @Component({<options>}) => // Angular component
#command @Injectable() => // Angular injectable
#command @Input() => // Angular input
#command @Output() => // Angular output
#command @ViewChild(<selector>) => // Angular view child
#command @NgModule({<options>}) => // Angular module

// ----------------------------------------------------------------------------
// ANGULAR/REACT/VUE ESPECÍFICOS
// ----------------------------------------------------------------------------
// Angular
#command @Component({<options>}) class <Component> => CLASS <Component>
#command selector: '<selector>' => // selector
#command templateUrl: '<template>' => // template url
#command template: '<template>' => // template
#command styleUrls: ['<style>'] => // styles
#command providers: [<providers>] => // providers

// React
#command const <Component>: React.FC = () => { => CLASS <Component> FROM React.Component
#command return ( => // JSX return
#command <div> => // JSX div
#command </div> => // close div
#command ) => // end JSX

// Vue
#command export default Vue.extend({ => CLASS <Component> FROM Vue
#command data() { return { <data> } } => METHOD data() CLASS <Component> ; RETURN {=> <data> }
#command methods: { <methods> } => // methods
#command computed: { <computed> } => // computed properties
#command watch: { <watchers> } => // watchers

// ----------------------------------------------------------------------------
// REGEX
// ----------------------------------------------------------------------------
#command /<pattern>/<flags> => hb_regexComp("<pattern>", "<flags>")
#command <regex>.