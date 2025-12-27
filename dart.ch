// ============================================================================
// DIRETIVAS COMPLETAS PARA TRADUÇÃO FLUTTER/DART PARA XHARBOUR
// ============================================================================

// ----------------------------------------------------------------------------
// ESTRUTURA DO PROGRAMA E IMPORTS
// ----------------------------------------------------------------------------
#command import '<package>' => #include "<package>.ch"
#command import 'dart:<lib>' => // biblioteca Dart: <lib>
#command import 'package:<pkg>/<file>.dart' => #include "<pkg>\<file>.ch"
#command export '<file>' => // exporta arquivo
#command part '<file>' => // parte do arquivo
#command part of '<main>' => // parte do arquivo principal

// ----------------------------------------------------------------------------
// COMENTÁRIOS
// ----------------------------------------------------------------------------
#command // <comment> => // <comment>
#command /// <doc> => // <doc> - documentação
#command /* <comment> */ => /* <comment> */

// ----------------------------------------------------------------------------
// DECLARAÇÕES DE VARIÁVEIS
// ----------------------------------------------------------------------------
#command var <var> = <value>; => LOCAL <var> := <value>
#command final <var> = <value>; => LOCAL <var> := <value>
#command const <var> = <value>; => #define <var> <value>
#command late final <var>; => LOCAL <var>
#command late var <var>; => LOCAL <var>
#command dynamic <var>; => LOCAL <var>
#command <type> <var>; => LOCAL <var> AS <type>
#command <type>? <var>; => LOCAL <var> AS <type> // nullable
#command void => // tipo void

// ----------------------------------------------------------------------------
// TIPOS DE DADOS DART
// ----------------------------------------------------------------------------
// Tipos básicos
#translate int => NUMERIC
#translate double => NUMERIC
#translate num => NUMERIC
#translate bool => LOGICAL
#translate String => CHARACTER
#translate List => ARRAY
#translate Map => HASH
#translate Set => HASH // como hash sem valores
#translate Runes => // iterable de Unicode code points
#translate Symbol => // símbolo

// Tipos de coleções
#translate List<<type>> => ARRAY
#translate Map<<K>, <V>> => HASH
#translate Set<<type>> => HASH
#translate Iterable<<type>> => ARRAY
#translate Future<<type>> => // futuro/promessa
#translate Stream<<type>> => // stream

// Tipos especiais
#translate dynamic => // tipo dinâmico
#translate var => LOCAL
#translate Object => // objeto base
#translate Null => NIL
#translate void => // sem retorno
#translate Never => // tipo never (semelhante ao ! do Rust)

// ----------------------------------------------------------------------------
// CLASSES E WIDGETS
// ----------------------------------------------------------------------------
#command class <Name> { => CLASS <Name>
#command abstract class <Name> { => CLASS <Name> // abstract
#command class <Name> extends <Parent> { => CLASS <Name> FROM <Parent>
#command class <Name> with <Mixin> { => CLASS <Name> // with mixin
#command class <Name> implements <Interface> { => CLASS <Name> // implements
#command } => ENDCLASS

// Widgets Flutter
#command class <Widget> extends StatelessWidget { => CLASS <Widget> FROM StatelessWidget
#command class <Widget> extends StatefulWidget { => CLASS <Widget> FROM StatefulWidget
#command class _<State> extends State<<Widget>> { => CLASS <State> FROM State

// ----------------------------------------------------------------------------
// CONSTRUTORES
// ----------------------------------------------------------------------------
#command <Name>({<params>}) : <initializers> { => METHOD New({<params>}) CLASS <Name> ; <initializers>
#command <Name>.<constructor>({<params>}) => METHOD <constructor>({<params>}) CLASS <Name>
#command super(<args>) => ::Super:New(<args>)
#command this.<field> => ::<field>
#command required this.<field> => ::<field> // campo requerido

// Initializers
#command : <field> = <value> => ::<field> := <value>
#command : <field> = <value>, => ::<field> := <value>,
#command : assert(<cond>) => #ifdef DEBUG ; IF !(<cond>) ; Break(ErrorNew()) ; ENDIF ; #endif

// Named parameters
#command {<params>} => // parâmetros nomeados
#command [<params>] => // parâmetros opcionais posicionais

// ----------------------------------------------------------------------------
// MÉTODOS E FUNÇÕES
// ----------------------------------------------------------------------------
#command <type> <name>([<params>]) { => METHOD <name>([<params>]) CLASS <ClassName> AS <type>
#command void <name>([<params>]) { => METHOD <name>([<params>]) CLASS <ClassName>
#command @override => // sobrescrita
#command @protected => PROTECTED:
#command @visibleForTesting => // visível para testes

// Funções de top-level
#command <type> <name>([<params>]) { => FUNCTION <name>([<params>]) AS <type>
#command void <name>([<params>]) { => PROCEDURE <name>([<params>])

// Funções arrow
#command <type> <name>([<params>]) => <expr>; => FUNCTION <name>([<params>]) AS <type> ; RETURN <expr>
#command <name>([<params>]) => <expr>; => FUNCTION <name>([<params>]) ; RETURN <expr>

// Async/await
#command Future<<type>> <name>([<params>]) async { => FUNCTION <name>([<params>]) ASYNC AS <type>
#command await <expression> => <expression>:Result
#command async => ASYNC
#command async* => // async generator
#command sync* => // sync generator
#command yield <value> => AAdd(<yield_array>, <value>)
#command yield* <stream> => AEval(<stream>, {|x| AAdd(<yield_array>, x)})

// ----------------------------------------------------------------------------
// GETTERS E SETTERS
// ----------------------------------------------------------------------------
#command <type> get <name> { => ACCESS <name> CLASS <ClassName> AS <type> ; RETURN
#command set <name>(<value>) { => ASSIGN <name>(<value>) CLASS <ClassName> ; ::<field> := <value>
#command } => // fim do getter/setter

// ----------------------------------------------------------------------------
// OPERADORES
// ----------------------------------------------------------------------------
// Aritméticos
#translate + => +
#translate - => -
#translate * => *
#translate / => /
#translate % => %
#translate ~/ => Int(<x> / <y>) // divisão inteira
#translate ++ => ++
#translate -- => --
#translate -<expr> => -<expr> // negação unária

// Atribuição
#translate = => :=
#translate += => +=
#translate -= => -=
#translate *= => *=
#translate /= => /=
#translate %= => %=
#translate ~/= => := Int(<x> / <y>)
#translate ??= => := iif(<x> == NIL, <y>, <x>)

// Comparação
#translate == => ==
#translate != => !=
#translate < => <
#translate > => >
#translate <= => <=
#translate >= => >=

// Lógicos
#translate && => .AND.
#translate || => .OR.
#translate ! => !
#translate ?? => iif(<x> != NIL, <x>, <y>) // null-coalescing

// Bitwise
#translate & => .AND.
#translate | => .OR.
#translate ^ => .XOR.
#translate ~ => .NOT.
#translate << => hb_bitShift(<x>, <y>)
#translate >> => hb_bitShift(<x>, -<y>)

// Outros
#translate is => hb_isKindOf
#translate is! => !hb_isKindOf
#translate as => hb_cast
#translate .. => // cascade operator
#translate ?. => :? // conditional access
#translate ?[ => :?[ // conditional index
#translate ..< => // range exclusive
#translate ... => // range inclusive

// ----------------------------------------------------------------------------
// ESTRUTURAS DE CONTROLE
// ----------------------------------------------------------------------------
// IF/ELSE
#command if (<cond>) { => IF <cond>
#command } else if (<cond>) { => ELSEIF <cond>
#command } else { => ELSE
#command } => ENDIF

// FOR LOOPS
#command for (var <var> = <start>; <cond>; <inc>) { => LOCAL <var> := <start> ; DO WHILE <cond> ; <inc>
#command } => ; ENDDO
#command for (final <var> in <iterable>) { => FOR EACH <var> IN <iterable>
#command } => NEXT
#command for (var <var> in <iterable>) { => FOR EACH <var> IN <iterable>
#command } => NEXT

// WHILE
#command while (<cond>) { => DO WHILE <cond>
#command } => ENDDO

// DO-WHILE
#command do { => DO WHILE .T.
#command } while (<cond>); => ; IF !(<cond>) ; EXIT ; ENDIF ; ENDDO

// SWITCH/CASE
#command switch (<expr>) { => DO CASE
#command case <value>: => CASE <expr> == <value>
#command case <value1> || <value2>: => CASE <expr> == <value1> .OR. <expr> == <value2>
#command default: => OTHERWISE
#command break; => EXIT
#command continue <label>; => LOOP
#command } => ENDCASE

// ASSERT
#command assert(<cond>[, <msg>]) => #ifdef DEBUG ; IF !(<cond>) ; Break(ErrorNew(, , <msg>)) ; ENDIF ; #endif

// TRY/CATCH/FINALLY
#command try { => BEGIN SEQUENCE
#command } on <Exception> catch (<e>) { => RECOVER USING <e> IF <e>:ClassName == "<Exception>"
#command } catch (<e>) { => RECOVER USING <e>
#command } finally { => ALWAYS
#command } => END SEQUENCE

#command throw <Exception>(<msg>) => Break(ErrorNew(, , <msg>))
#command throw => Break()
#command rethrow => Break(Error()) // re-lança erro atual

// ----------------------------------------------------------------------------
// WIDGETS FLUTTER
// ----------------------------------------------------------------------------
#command @override Widget build(BuildContext context) { => ;
    METHOD build(context) CLASS <Widget> ; RETURN
#command return MaterialApp( => MaterialApp:New(
#command return Scaffold( => Scaffold:New(
#command return Container( => Container:New(
#command return Column( => Column:New(
#command return Row( => Row:New(
#command return Text( => Text:New(
#command return ElevatedButton( => ElevatedButton:New(
#command return ListView( => ListView:New(
#command return AppBar( => AppBar:New(

// Propriedades de widgets
#command home: <widget>, => :home := <widget>,
#command title: <text>, => :title := <text>,
#command body: <widget>, => :body := <widget>,
#command children: [<widgets>], => :children := {<widgets>},
#command onPressed: () { <code> }, => :onPressed := {|| <code> },
#command child: <widget>, => :child := <widget>,

// Widget tree
#command child: Text(<text>), => :child := Text:New(<text>),
#command children: [ => :children := {
#command ], => },
#command ), => ), // fecha widget

// ----------------------------------------------------------------------------
// BUILD CONTEXT E THEME
// ----------------------------------------------------------------------------
#command context => ::oContext
#command Theme.of(context) => Theme:of(::oContext)
#command MediaQuery.of(context) => MediaQuery:of(::oContext)
#command Navigator.of(context) => Navigator:of(::oContext)

// ----------------------------------------------------------------------------
// STATE MANAGEMENT
// ----------------------------------------------------------------------------
#command setState(() { <code> }) => ::setState({|| <code> })
#command initState() => METHOD initState() CLASS <State>
#command dispose() => METHOD Destroy() CLASS <State>
#command didChangeDependencies() => METHOD didChangeDependencies() CLASS <State>
#command didUpdateWidget(<Widget> oldWidget) => METHOD didUpdateWidget(oldWidget) CLASS <State>

// Provider
#command Provider.of<<T>>(context) => Provider:of<<T>>(::oContext)
#command Consumer<<T>>( => Consumer:New<<T>>(
#command builder: (context, <value>, child) => <widget> => ;
    :builder := {|context, <value>, child| <widget> },

// Bloc
#command BlocProvider.of<<Bloc>>(context) => BlocProvider:of<<Bloc>>(::oContext)
#command BlocBuilder<<Bloc>, <State>>( => BlocBuilder:New<<Bloc>, <State>>(

// GetX
#command Get.put(<controller>) => Get:put(<controller>)
#command Get.find<<Controller>>() => Get:find<<Controller>>()
#command Obx(() => <widget>) => Obx:New({|| <widget>})

// Riverpod
#command ref.watch(<provider>) => ref:watch(<provider>)
#command ref.read(<provider>) => ref:read(<provider>)
#command ConsumerWidget => CLASS ConsumerWidget

// ----------------------------------------------------------------------------
// FUNÇÕES DE STRING
// ----------------------------------------------------------------------------
#command '<str>' => "<str>" // string literal
#command "<str>" => "<str>" // string com interpolação
#command '${<expr>}' => hb_ValToStr(<expr>) // interpolação
#command r'<str>' => "<str>" // raw string
#command '''<multiline>''' => "<multiline>" // string multi-linha
#command """<multiline>""" => "<multiline>" // string multi-linha

// Métodos de String
#command <str>.length => Len(<str>)
#command <str>.isEmpty => Empty(<str>)
#command <str>.isNotEmpty => !Empty(<str>)
#command <str>.toLowerCase() => Lower(<str>)
#command <str>.toUpperCase() => Upper(<str>)
#command <str>.trim() => AllTrim(<str>)
#command <str>.trimLeft() => LTrim(<str>)
#command <str>.trimRight() => RTrim(<str>)
#command <str>.contains(<sub>) => (<sub> $ <str>)
#command <str>.startsWith(<prefix>) => (Left(<str>, Len(<prefix>)) == <prefix>)
#command <str>.endsWith(<suffix>) => (Right(<str>, Len(<suffix>)) == <suffix>)
#command <str>.indexOf(<sub>[, <start>]) => At(<sub>, <str>, iif(<start>==NIL, 1, <start>+1))-1
#command <str>.lastIndexOf(<sub>[, <start>]) => hb_RAt(<sub>, <str>, iif(<start>==NIL, 1, <start>+1))-1
#command <str>.substring(<start>[, <end>]) => SubStr(<str>, <start>+1, iif(<end>==NIL, Len(<str>)-<start>, <end>-<start>))
#command <str>.split(<delim>) => hb_ATokens(<str>, <delim>)
#command <str>.splitMapJoin(<pattern>) => // split, map e join
#command <str>.replaceAll(<from>, <to>) => StrTran(<str>, <from>, <to>)
#command <str>.replaceFirst(<from>, <to>[, <start>]) => StrTran(<str>, <from>, <to>, iif(<start>==NIL, 1, <start>+1), 1)
#command <str>.replaceRange(<start>, <end>, <replacement>) => Stuff(<str>, <start>+1, <end>-<start>, <replacement>)
#command <str>.padLeft(<width>[, <padding>]) => PadL(<str>, <width>, iif(<padding>==NIL, " ", <padding>))
#command <str>.padRight(<width>[, <padding>]) => PadR(<str>, <width>, iif(<padding>==NIL, " ", <padding>))
#command <str>.compareTo(<other>) => iif(<str> < <other>, -1, iif(<str> > <other>, 1, 0))
#command int.parse(<str>) => Val(<str>)
#command double.parse(<str>) => Val(<str>)
#command <num>.toString() => hb_ValToStr(<num>)
#command String.fromCharCode(<code>) => Chr(<code>)
#command String.fromCharCodes(<codes>) => hb_StrFromArray(<codes>)

// StringBuffer
#command StringBuffer() => {}
#command <sb>.write(<str>) => AAdd(<sb>, <str>)
#command <sb>.writeln([<str>]) => AAdd(<sb>, iif(<str>==NIL, "", <str>) + hb_eol())
#command <sb>.clear() => <sb> := {}
#command <sb>.toString() => ArrayToStr(<sb>, "")

// ----------------------------------------------------------------------------
// LISTAS E COLEÇÕES
// ----------------------------------------------------------------------------
#command [] => {}
#command [<values>] => {<values>}
#command <type>[<size>] => Array(<size>)
#command List.filled(<size>, <value>) => Array(<size>, <value>)
#command List.generate(<size>, <generator>) => Array(<size>, {|i| <generator>(i-1)})
#command List.from(<iterable>) => hb_ArrayFromIterable(<iterable>)
#command List.of(<iterable>) => hb_ArrayFromIterable(<iterable>)
#command List.unmodifiable(<iterable>) => hb_ArrayFromIterable(<iterable>) // readonly

// Métodos de List
#command <list>.length => Len(<list>)
#command <list>.isEmpty => (Len(<list>) == 0)
#command <list>.isNotEmpty => (Len(<list>) > 0)
#command <list>.add(<value>) => AAdd(<list>, <value>)
#command <list>.addAll(<iterable>) => AEval(<iterable>, {|x| AAdd(<list>, x)})
#command <list>.insert(<index>, <value>) => hb_AIns(<list>, <index>+1, <value>, .T.)
#command <list>.insertAll(<index>, <iterable>) => // insere múltiplos
#command <list>.remove(<value>) => hb_ADel(<list>, <value>, .T.)
#command <list>.removeAt(<index>) => hb_ADel(<list>, <index>+1, 1, .T.)
#command <list>.removeLast() => hb_APop(<list>)
#command <list>.removeRange(<start>, <end>) => hb_ADel(<list>, <start>+1, <end>-<start>, .T.)
#command <list>.removeWhere(<test>) => hb_ArrayFilter(<list>, {|x| !<test>(x)})
#command <list>.retainWhere(<test>) => hb_ArrayFilter(<list>, {|x| <test>(x)})
#command <list>.clear() => <list> := {}
#command <list>.indexOf(<value>[, <start>]) => AScan(<list>, {|x| x == <value>}, iif(<start>==NIL, 1, <start>+1))-1
#command <list>.lastIndexOf(<value>[, <start>]) => hb_RScan(<list>, {|x| x == <value>}, iif(<start>==NIL, Len(<list>), <start>+1))-1
#command <list>.contains(<value>) => (AScan(<list>, {|x| x == <value>}) > 0)
#command <list>.elementAt(<index>) => <list>[<index>+1]
#command <list>[<index>] => <list>[<index>+1] // Dart usa 0-based
#command <list>.setRange(<start>, <end>, <iterable>) => // define range
#command <list>.fillRange(<start>, <end>[, <value>]) => hb_ArrayFill(<list>, <start>+1, <end>-<start>, iif(<value>==NIL, NIL, <value>))
#command <list>.getRange(<start>, <end>) => hb_ArraySlice(<list>, <start>+1, <end>-<start>)
#command <list>.sublist(<start>[, <end>]) => hb_ArraySlice(<list>, <start>+1, iif(<end>==NIL, Len(<list>)-<start>, <end>-<start>))
#command <list>.asMap() => hb_ArrayToMap(<list>)
#command <list>.forEach(<action>) => AEval(<list>, <action>)
#command <list>.map(<transform>) => hb_ArrayEval(<list>, <transform>)
#command <list>.where(<test>) => hb_ArrayFilter(<list>, <test>)
#command <list>.firstWhere(<test>[, orElse]) => hb_ArrayFirstWhere(<list>, <test>, <orElse>)
#command <list>.lastWhere(<test>[, orElse]) => hb_ArrayLastWhere(<list>, <test>, <orElse>)
#command <list>.singleWhere(<test>[, orElse]) => hb_ArraySingleWhere(<list>, <test>, <orElse>)
#command <list>.any(<test>) => (AScan(<list>, {|x| <test>(x)}) > 0)
#command <list>.every(<test>) => (AScan(<list>, {|x| !<test>(x)}) == 0)
#command <list>.fold(<initial>, <combine>) => hb_ArrayFold(<list>, <initial>, <combine>)
#command <list>.reduce(<combine>) => hb_ArrayReduce(<list>, <combine>)
#command <list>.toList() => AClone(<list>)
#command <list>.toSet() => hb_ArrayToSet(<list>)
#command <list>.join(<separator>) => ArrayToStr(<list>, <separator>)
#command <list>.sort([<compare>]) => ASort(<list>, , , iif(<compare>==NIL, NIL, <compare>))
#command <list>.shuffle() => hb_ArrayShuffle(<list>)
#command <list>.reversed => hb_ArrayReverse(AClone(<list>))
#command <list>.cast<<R>>() => <list> // cast de tipo

// Iterable
#command <iterable>.iterator => <iterable>:__iterator__()
#command <iterable>.toList() => hb_IterableToList(<iterable>)
#command <iterable>.toSet() => hb_IterableToSet(<iterable>)
#command <iterable>.isEmpty => (hb_IterableCount(<iterable>) == 0)
#command <iterable>.isNotEmpty => (hb_IterableCount(<iterable>) > 0)
#command <iterable>.length => hb_IterableCount(<iterable>)
#command <iterable>.first => hb_IterableFirst(<iterable>)
#command <iterable>.last => hb_IterableLast(<iterable>)
#command <iterable>.single => hb_IterableSingle(<iterable>)

// ----------------------------------------------------------------------------
// MAPS
// ----------------------------------------------------------------------------
#command {} => {=>}
#command {<key>: <value>} => { <key> => <value> }
#command Map() => {=>}
#command Map.from(<other>) => hb_HClone(<other>)
#command Map.of(<other>) => hb_HClone(<other>)
#command Map.fromIterable(<iterable>) => hb_HashFromIterable(<iterable>)
#command Map.fromIterables(<keys>, <values>) => hb_HashFromArrays(<keys>, <values>)
#command Map.unmodifiable(<other>) => hb_HClone(<other>) // readonly

// Métodos de Map
#command <map>.length => Len(<map>)
#command <map>.isEmpty => (Len(<map>) == 0)
#command <map>.isNotEmpty => (Len(<map>) > 0)
#command <map>.keys => hb_HKeys(<map>)
#command <map>.values => hb_HValues(<map>)
#command <map>.entries => hb_HPairs(<map>)
#command <map>[<key>] => hb_HGetDef(<map>, <key>, NIL)
#command <map>[<key>] = <value> => hb_HSet(<map>, <key>, <value>)
#command <map>.containsKey(<key>) => hb_HHasKey(<map>, <key>)
#command <map>.containsValue(<value>) => (AScan(hb_HValues(<map>), {|v| v == <value>}) > 0)
#command <map>.putIfAbsent(<key>, <ifAbsent>) => ;
    iif(!hb_HHasKey(<map>, <key>), hb_HSet(<map>, <key>, <ifAbsent>()), hb_HGet(<map>, <key>))
#command <map>.addAll(<other>) => hb_HMerge(<map>, <other>)
#command <map>.remove(<key>) => hb_HDel(<map>, <key>)
#command <map>.clear() => <map> := {=>}
#command <map>.forEach(<action>) => hb_HForEach(<map>, <action>)
#command <map>.map<<K>, <V>>(<transform>) => hb_HMap(<map>, <transform>)
#command <map>.update(<key>, <update>[, ifAbsent]) => ;
    iif(hb_HHasKey(<map>, <key>), hb_HSet(<map>, <key>, <update>(hb_HGet(<map>, <key>))), ;
    iif(<ifAbsent>==NIL, NIL, hb_HSet(<map>, <key>, <ifAbsent>())))
#command <map>.updateAll(<update>) => hb_HUpdateAll(<map>, <update>)

// ----------------------------------------------------------------------------
#command <map>.cast<<RK>, <RV>>() => <map> // cast de tipo

// ----------------------------------------------------------------------------
// SETS
// ----------------------------------------------------------------------------
#command Set() => {=>} // como hash
#command {<values>} => hb_ArrayToSet({<values>})
#command Set.from(<iterable>) => hb_IterableToSet(<iterable>)
#command Set.of(<iterable>) => hb_IterableToSet(<iterable>)

// Métodos de Set
#command <set>.length => Len(<set>)
#command <set>.isEmpty => (Len(<set>) == 0)
#command <set>.isNotEmpty => (Len(<set>) > 0)
#command <set>.contains(<value>) => hb_HHasKey(<set>, <value>)
#command <set>.add(<value>) => hb_HSet(<set>, <value>, .T.)
#command <set>.addAll(<iterable>) => AEval(<iterable>, {|x| hb_HSet(<set>, x, .T.)})
#command <set>.remove(<value>) => hb_HDel(<set>, <value>)
#command <set>.removeAll(<iterable>) => AEval(<iterable>, {|x| hb_HDel(<set>, x)})
#command <set>.retainAll(<iterable>) => // mantém apenas os especificados
#command <set>.removeWhere(<test>) => hb_HFilter(<set>, {|k| !<test>(k)})
#command <set>.retainWhere(<test>) => hb_HFilter(<set>, {|k| <test>(k)})
#command <set>.containsAll(<iterable>) => hb_SetContainsAll(<set>, <iterable>)
#command <set>.union(<other>) => hb_SetUnion(<set>, <other>)
#command <set>.intersection(<other>) => hb_SetIntersection(<set>, <other>)
#command <set>.difference(<other>) => hb_SetDifference(<set>, <other>)
#command <set>.clear() => <set> := {=>}
#command <set>.toSet() => hb_HClone(<set>)
#command <set>.toList() => hb_HKeys(<set>)
#command <set>.forEach(<action>) => hb_HForEachKey(<set>, <action>)
#command <set>.map<<R>>(<transform>) => hb_SetMap(<set>, <transform>)
#command <set>.where(<test>) => hb_SetWhere(<set>, <test>)
#command <set>.any(<test>) => (hb_HScanKey(<set>, {|k| <test>(k)}) > 0)
#command <set>.every(<test>) => (hb_HScanKey(<set>, {|k| !<test>(k)}) == 0)
#command <set>.cast<<R>>() => <set> // cast de tipo

// ----------------------------------------------------------------------------
// FUTURES E ASYNC
// ----------------------------------------------------------------------------
#command Future<<type>> => // futuro
#command Future.value(<value>) => <value>
#command Future.error(<error>) => Break(<error>)
#command Future.delayed(<duration>, <computation>) => hb_asyncDelay(<duration>, <computation>)
#command Future.microtask(<computation>) => <computation>()
#command Future.sync(<computation>) => <computation>()
#command <future>.then(<onValue>[, onError]) => <future>:then(<onValue>, <onError>)
#command <future>.catchError(<onError>[, test]) => <future>:catchError(<onError>)
#command <future>.whenComplete(<action>) => <future>:whenComplete(<action>)
#command <future>.timeout(<duration>[, onTimeout]) => <future>:timeout(<duration>, <onTimeout>)
#command Future.wait(<futures>) => hb_FutureWait(<futures>)
#command Future.forEach(<iterable>, <action>) => hb_FutureForEach(<iterable>, <action>)

// Completer
#command Completer<<type>>() => // completer
#command <completer>.complete(<value>) => <completer>:complete(<value>)
#command <completer>.completeError(<error>) => <completer>:completeError(<error>)
#command <completer>.future => <completer>:future

// Stream
#command Stream<<type>> => // stream
#command Stream.fromIterable(<iterable>) => hb_StreamFromIterable(<iterable>)
#command Stream.fromFuture(<future>) => hb_StreamFromFuture(<future>)
#command Stream.periodic(<duration>, <computation>) => hb_StreamPeriodic(<duration>, <computation>)
#command <stream>.listen(<onData>[, onError][, onDone][, cancelOnError]) => <stream>:listen(<onData>, <onError>, <onDone>, <cancelOnError>)
#command <stream>.map(<transform>) => <stream>:map(<transform>)
#command <stream>.where(<test>) => <stream>:where(<test>)
#command <stream>.take(<count>) => <stream>:take(<count>)
#command <stream>.takeWhile(<test>) => <stream>:takeWhile(<test>)
#command <stream>.skip(<count>) => <stream>:skip(<count>)
#command <stream>.skipWhile(<test>) => <stream>:skipWhile(<test>)
#command <stream>.distinct([<equals>]) => <stream>:distinct(<equals>)
#command <stream>.forEach(<action>) => <stream>:forEach(<action>)
#command <stream>.drain([<futureValue>]) => <stream>:drain(<futureValue>)

// StreamController
#command StreamController<<type>>() => // stream controller
#command <controller>.stream => <controller>:stream
#command <controller>.sink => <controller>:sink
#command <controller>.add(<data>) => <controller>:add(<data>)
#command <controller>.addError(<error>) => <controller>:addError(<error>)
#command <controller>.close() => <controller>:close()

// ----------------------------------------------------------------------------
// NULL SAFETY E OPERADORES
// ----------------------------------------------------------------------------
#command <expr>! => <expr> // non-null assertion
#command <expr>? => iif(<expr> == NIL, NIL, // safe navigation
#command <expr>!.<property> => <expr>:<property> // non-null property access
#command <expr>?.<property> => iif(<expr> == NIL, NIL, <expr>:<property>)
#command <expr>!.<method>() => <expr>:<method>() // non-null method call
#command <expr>?.<method>() => iif(<expr> == NIL, NIL, <expr>:<method>())
#command <expr>![<index>] => <expr>[<index>] // non-null index
#command <expr>?[<index>] => iif(<expr> == NIL, NIL, <expr>[<index>])
#command <var> ??= <value> => <var> := iif(<var> == NIL, <value>, <var>)

// ----------------------------------------------------------------------------
// EXTENSIONS
// ----------------------------------------------------------------------------
#command extension <Name> on <Type> { => // extension <Name> para <Type>
#command } => // fim da extension
#command <type>.<extension_method> => // método de extension

// ----------------------------------------------------------------------------
// ENUMS
// ----------------------------------------------------------------------------
#command enum <Name> { => // enum <Name>
#command <value>, => // valor do enum
#command } => // fim do enum
#command <Name>.<value> => // valor do enum
#command <Name>.values => // todos os valores
#command <Name>.valueOf(<str>) => // valor do enum por nome

// ----------------------------------------------------------------------------
// MIXINS
// ----------------------------------------------------------------------------
#command mixin <Name> { => // mixin <Name>
#command } => // fim do mixin
#command on <Type> => // mixin constraint

// ----------------------------------------------------------------------------
// ANNOTATIONS
// ----------------------------------------------------------------------------
#command @<annotation> => // annotation
#command @<annotation>(<args>) => // annotation com argumentos
#command @override => // sobrescrita
#command @deprecated(<msg>) => // deprecated
#command @required => // required
#command @protected => PROTECTED:
#command @visibleForTesting => // visible for testing

// ----------------------------------------------------------------------------
// UI E WIDGETS ESPECÍFICOS
// ----------------------------------------------------------------------------
#command Text('<text>') => Text:New('<text>')
#command Text('<text>', style: TextStyle()) => Text:New('<text>'):style(TextStyle:New())
#command TextStyle() => TextStyle:New()
#command TextStyle(fontSize: <size>) => TextStyle:New(:fontSize := <size>)
#command Colors.<color> => //