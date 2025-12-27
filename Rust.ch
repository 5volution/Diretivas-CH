// ============================================================================
// DIRETIVAS COMPLETAS PARA TRADUÇÃO DE RUST PARA XHARBOUR
// ============================================================================

// ----------------------------------------------------------------------------
// ESTRUTURA DO PROGRAMA
// ----------------------------------------------------------------------------
#command fn main() { => PROCEDURE Main()
#command } => RETURN
#command mod <name> { => // módulo <name>
#command pub => EXPORTED:
#command use <path>::<item>; => // use <path>::<item>
#command use <path>::*; => // importa tudo do módulo
#command use <path> as <alias>; => // alias de módulo
#command crate => // crate raiz
#command super => // módulo pai
#command self => // módulo atual

// ----------------------------------------------------------------------------
// COMENTÁRIOS
// ----------------------------------------------------------------------------
#command // <comment> => // <comment>
#command /* <comment> */ => /* <comment> */
#command /// <doc> => //! <doc> - documentação
#command //! <doc> => //! <doc> - documentação de módulo

// ----------------------------------------------------------------------------
// DECLARAÇÕES DE VARIÁVEIS
// ----------------------------------------------------------------------------
#command let <var> = <value>; => LOCAL <var> := <value>
#command let mut <var> = <value>; => LOCAL <var> := <value>
#command let <var>: <type> = <value>; => LOCAL <var> AS <type> := <value>
#command let mut <var>: <type> = <value>; => LOCAL <var> AS <type> := <value>
#command const <NAME>: <type> = <value>; => #define <NAME> <value>
#command static <NAME>: <type> = <value>; => STATIC <NAME> := <value>
#command static mut <NAME>: <type> = <value>; => STATIC <NAME> := <value>
#command _ => // placeholder (ignorado)

// ----------------------------------------------------------------------------
// TIPOS DE DADOS
// ----------------------------------------------------------------------------
// Tipos escalares
#translate i8 => NUMERIC
#translate i16 => NUMERIC
#translate i32 => NUMERIC
#translate i64 => NUMERIC
#translate i128 => NUMERIC
#translate isize => NUMERIC
#translate u8 => NUMERIC
#translate u16 => NUMERIC
#translate u32 => NUMERIC
#translate u64 => NUMERIC
#translate u128 => NUMERIC
#translate usize => NUMERIC
#translate f32 => NUMERIC
#translate f64 => NUMERIC
#translate bool => LOGICAL
#translate char => CHARACTER // Unicode scalar value
#translate &str => CHARACTER // string slice
#translate String => CHARACTER // owned string
#translate () => // unit type
#translate ! => // never type

// Tipos compostos
#translate [<type>; <size>] => ARRAY
#translate [<type>] => ARRAY // slice
#translate &[<type>] => ARRAY // slice reference
#translate Vec<<type>> => ARRAY // vetor
#translate (<types>) => // tuple
#translate &<type> => // reference
#translate &mut <type> => // mutable reference
#translate *const <type> => // raw const pointer
#translate *mut <type> => // raw mut pointer
#translate Option<<T>> => // Option type
#translate Result<<T>, <E>> => // Result type
#translate Box<<T>> => // heap allocation
#translate Rc<<T>> => // reference counting
#translate Arc<<T>> => // atomic reference counting
#translate Cell<<T>> => // interior mutability
#translate RefCell<<T>> => // runtime borrow checking
#translate Ref<<T>> => // borrowed reference
#translate RefMut<<T>> => // mutable borrowed reference

// ----------------------------------------------------------------------------
// TYPE ALIASES E GENERICS
// ----------------------------------------------------------------------------
#command type <Alias> = <type>; => #define <Alias> <type>
#command struct <Name><<T>> { => CLASS <Name>
#command impl<<T>> <Name><<T>> { => // implementação genérica
#command where <constraints> => // constraints de tipo
#command dyn <Trait> => // trait object

// ----------------------------------------------------------------------------
// STRUCTS E ENUMS
// ----------------------------------------------------------------------------
#command struct <Name> { => CLASS <Name>
#command } => ENDCLASS
#command pub struct <Name> { => CLASS <Name>
#command #[derive(<traits>)] => // derive traits

#command enum <Name> { => // enum <Name>
#command <Variant>, => // variante sem dados
#command <Variant>(<type>), => // variante tuple
#command <Variant> { <fields> }, => // variante struct
#command } => // fim do enum

// Tuple structs
#command struct <Name>(<types>); => CLASS <Name>

// Unit structs
#command struct <Name>; => CLASS <Name>

// ----------------------------------------------------------------------------
// FUNÇÕES E MÉTODOS
// ----------------------------------------------------------------------------
#command fn <name>([<params>]) -> <rettype> { => FUNCTION <name>([<params>]) AS <rettype>
#command fn <name>([<params>]) { => PROCEDURE <name>([<params>])
#command pub fn <name>([<params>]) -> <rettype> { => EXPORTED: FUNCTION <name>([<params>]) AS <rettype>
#command unsafe fn <name>([<params>]) { => FUNCTION <name>([<params>]) // unsafe
#command extern "<ABI>" fn <name>([<params>]) { => EXTERN FUNCTION <name>([<params>])
#command return <expr>; => RETURN <expr>
#command return; => RETURN NIL

// Parâmetros
#command <param>: <type> => <param> AS <type>
#command &<param> => <param> // reference
#command &mut <param> => @<param> // mutable reference
#command mut <param>: <type> => @<param> AS <type>

// Expressões de retorno implícito
#command <expr> => // última expressão é retornada implicitamente

// ----------------------------------------------------------------------------
// IMPLEMENTAÇÕES (impl)
// ----------------------------------------------------------------------------
#command impl <Type> { => // implementação para <Type>
#command } => // fim da implementação
#command impl <Trait> for <Type> { => // implementação de trait
#command impl<<T>> <Type><<T>> { => // implementação genérica

// Métodos
#command fn <method>(&self[, <params>]) -> <rettype> { => METHOD <method>([<params>]) CLASS <Type> AS <rettype>
#command fn <method>(&mut self[, <params>]) -> <rettype> { => METHOD <method>([<params>]) CLASS <Type> AS <rettype>
#command fn <method>(self[, <params>]) -> <rettype> { => METHOD <method>([<params>]) CLASS <Type> AS <rettype>
#command fn <method>([<params>]) -> <rettype> { => CLASS METHOD <method>([<params>]) CLASS <Type> AS <rettype>

// Associated functions (sem self)
#command fn <function>([<params>]) -> <rettype> { => CLASS METHOD <function>([<params>]) CLASS <Type> AS <rettype>

// ----------------------------------------------------------------------------
// TRAITS
// ----------------------------------------------------------------------------
#command trait <Trait> { => // trait <Trait>
#command fn <method>([<params>]) -> <rettype>; => // método do trait
#command type <Type>; => // associated type
#command const <NAME>: <type>; => // associated constant
#command } => // fim do trait

// Trait bounds
#command <T>: <Trait> => // trait bound
#command <T>: <Trait> + <Trait2> => // multiple trait bounds
#command where <T>: <Trait> => // where clause

// ----------------------------------------------------------------------------
// MACROS
// ----------------------------------------------------------------------------
#command macro_rules! <name> { => // macro <name>
#command ($($pat:tt)*) => { $($body)* }; => // regra de macro
#command } => // fim da macro
#command println!(<fmt>[, <args>]) => QOut(hb_StrFormat(<fmt>, <args>))
#command print!(<fmt>[, <args>]) => QQOut(hb_StrFormat(<fmt>, <args>))
#command format!(<fmt>[, <args>]) => hb_StrFormat(<fmt>, <args>)
#command eprintln!(<fmt>[, <args>]) => QErr(hb_StrFormat(<fmt>, <args>))
#command eprint!(<fmt>[, <args>]) => QQErr(hb_StrFormat(<fmt>, <args>))
#command write!(<writer>, <fmt>[, <args>]) => hb_vfWrite(<writer>, hb_StrFormat(<fmt>, <args>))
#command writeln!(<writer>, <fmt>[, <args>]) => hb_vfWrite(<writer>, hb_StrFormat(<fmt>, <args>) + hb_eol())
#command panic!(<msg>) => Break(ErrorNew(, , <msg>))
#command assert!(<cond>[, <msg>]) => #ifdef DEBUG ; IF !(<cond>) ; Break(ErrorNew(, , <msg>)) ; ENDIF ; #endif
#command assert_eq!(<a>, <b>[, <msg>]) => #ifdef DEBUG ; IF (<a>) != (<b>) ; Break(ErrorNew(, , <msg>)) ; ENDIF ; #endif
#command assert_ne!(<a>, <b>[, <msg>]) => #ifdef DEBUG ; IF (<a>) == (<b>) ; Break(ErrorNew(, , <msg>)) ; ENDIF ; #endif
#command unreachable!() => Break(ErrorNew(, , "unreachable code"))
#command unimplemented!() => Break(ErrorNew(, , "not implemented"))
#command todo!() => Break(ErrorNew(, , "TODO"))
#command vec![<values>] => { <values> }
#command vec![<value>; <count>] => Array(<count>, <value>)

// ----------------------------------------------------------------------------
#command dbg!(<expr>) => QOut(#<expr> + " = " + hb_ValToStr(<expr>)), <expr>

// ----------------------------------------------------------------------------
// OPERADORES
// ----------------------------------------------------------------------------
// Aritméticos
#translate + => +
#translate - => -
#translate * => *
#translate / => /
#translate % => %
#translate & => .AND. // bitwise AND
#translate | => .OR. // bitwise OR
#translate ^ => .XOR. // bitwise XOR
#translate << => hb_bitShift(<x>, <y>)
#translate >> => hb_bitShift(<x>, -<y>)

// Atribuição
#translate = => :=
#translate += => +=
#translate -= => -=
#translate *= => *=
#translate /= => /=
#translate %= => %=
#translate &= => := <x> .AND. <y>
#translate |= => := <x> .OR. <y>
#translate ^= => := <x> .XOR. <y>
#translate <<= => := hb_bitShift(<x>, <y>)
#translate >>= => := hb_bitShift(<x>, -<y>)

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

// Outros operadores
#translate .. => // range
#translate ..= => // inclusive range
#translate | => // closure parameter
#translate ? => // error propagation
#translate @ => // pattern binding
#translate -> => AS // tipo de retorno
#translate => => // match arm ou closure retorno
#translate :: => // path separator
#translate . => : // method/field access
#translate & => // reference
#translate * => // dereference
#translate .. => // rest pattern

// ----------------------------------------------------------------------------
#command as => hb_cast // type cast
#command await => // async/await
#command break => EXIT
#command continue => LOOP
#command dyn => // dynamic dispatch
#command else => ELSE
#command enum => // enum
#command extern => EXTERN
#command false => .F.
#command for => FOR
#command if => IF
#command impl => // implementation
#command in => IN
#command let => LOCAL
#command loop => DO WHILE .T.
#command match => DO CASE
#command mod => // module
#command move => // closure move semantics
#command mut => // mutable
#command pub => EXPORTED:
#command ref => // reference pattern
#command return => RETURN
#command Self => ::Class // type alias for self type
#command self => ::Self // self parameter
#command static => STATIC
#command struct => CLASS
#command super => ::Super // parent module
#command trait => // trait
#command true => .T.
#command type => // type alias
#command unsafe => // unsafe block
#command use => // use declaration
#command where => // where clause
#command while => DO WHILE

// ----------------------------------------------------------------------------
// ESTRUTURAS DE CONTROLE
// ----------------------------------------------------------------------------
// IF/ELSE
#command if <cond> { => IF <cond>
#command } else if <cond> { => ELSEIF <cond>
#command } else { => ELSE
#command } => ENDIF

// IF LET
#command if let <pat> = <expr> { => LOCAL <temp> := <expr> ; IF <pat>Matches(<temp>)

// WHILE
#command while <cond> { => DO WHILE <cond>
#command } => ENDDO

// WHILE LET
#command while let <pat> = <expr> { => DO WHILE .T. ; LOCAL <temp> := <expr> ; IF !<pat>Matches(<temp>) ; EXIT ; ENDIF

// LOOP
#command loop { => DO WHILE .T.
#command } => ENDDO

// FOR
#command for <pat> in <expr> { => LOCAL <iter> := <expr>:into_iter() ; DO WHILE .T. ; LOCAL <next> := <iter>:next() ; IF <next>:is_none() ; EXIT ; ENDIF ; LOCAL <pat> := <next>:unwrap()
#command } => ; ENDDO

// MATCH (switch avançado)
#command match <expr> { => LOCAL <match_val> := <expr> ; DO CASE
#command <pat> => <expr>, => CASE <pat>Matches(<match_val>) ; <expr>
#command <pat> if <guard> => <expr>, => CASE <pat>Matches(<match_val>) .AND. <guard> ; <expr>
#command _ => <expr>, => OTHERWISE ; <expr>
#command } => ENDCASE

// Pattern matching em let
#command let <pat> = <expr>; => LOCAL <temp> := <expr> ; IF <pat>Matches(<temp>)

// ----------------------------------------------------------------------------
// BLOCOS E ESCOPO
// ----------------------------------------------------------------------------
#command { => 
#command } => 
#command unsafe { => // unsafe block
#command } => 
#command async { => // async block
#command } => 

// Expressões de bloco
#command { <stmts> <expr> } => <stmts> <expr> // bloco retorna última expressão

// ----------------------------------------------------------------------------
// TRATAMENTO DE ERROS
// ----------------------------------------------------------------------------
// Result type
#translate Ok(<value>) => <value>
#translate Err(<error>) => Break(<error>)

// Option type
#translate Some(<value>) => <value>
#translate None => NIL

// Error propagation
#command <expr>? => LOCAL <temp> := <expr> ; IF ValType(<temp>) == "O" .AND. <temp>:ClassName == "Error" ; Break(<temp>) ; ENDIF

// Métodos de Result/Option
#command <result>.unwrap() => <result>:unwrap()
#command <result>.unwrap_or(<default>) => <result>:unwrap_or(<default>)
#command <result>.unwrap_or_else(<closure>) => <result>:unwrap_or_else(<closure>)
#command <result>.expect(<msg>) => <result>:expect(<msg>)
#command <result>.is_ok() => <result>:is_ok()
#command <result>.is_err() => <result>:is_err()
#command <option>.unwrap() => <option>:unwrap()
#command <option>.unwrap_or(<default>) => <option>:unwrap_or(<default>)
#command <option>.is_some() => <option> != NIL
#command <option>.is_none() => <option> == NIL

// Combinators
#command <result>.and_then(<closure>) => <result>:and_then(<closure>)
#command <result>.map(<closure>) => <result>:map(<closure>)
#command <result>.map_err(<closure>) => <result>:map_err(<closure>)
#command <option>.and_then(<closure>) => <option>:and_then(<closure>)
#command <option>.map(<closure>) => <option>:map(<closure>)

// try! macro (legado)
#command try!(<expr>) => LOCAL <temp> := <expr> ; IF ValType(<temp>) == "O" .AND. <temp>:ClassName == "Error" ; Break(<temp>) ; ENDIF ; <temp>

// ----------------------------------------------------------------------------
// CLOSURES (FUNÇÕES ANÔNIMAS)
// ----------------------------------------------------------------------------
#command |<params>| <expr> => {|<params>| <expr>}
#command |<params>| { <body> } => {|<params>| <body> }
#command move |<params>| <expr> => {|<params>| <expr> } // captures by move
#command || <expr> => {|| <expr>} // sem parâmetros

// Tipos de closure
#translate Fn(<params>) -> <ret> => BLOCK
#translate FnMut(<params>) -> <ret> => BLOCK
#translate FnOnce(<params>) -> <ret> => BLOCK

// ----------------------------------------------------------------------------
// ITERATORS
// ----------------------------------------------------------------------------
#command for <item> in <iter>.iter() { => FOR EACH <item> IN <iter>
#command for <item> in <iter>.iter_mut() { => FOR EACH <item> IN <iter> ; // mutable
#command for <item> in <iter>.into_iter() { => FOR EACH <item> IN <iter> ; // consumes

// Métodos de iterador
#command <iter>.next() => <iter>:next()
#command <iter>.map(<closure>) => <iter>:map(<closure>)
#command <iter>.filter(<closure>) => <iter>:filter(<closure>)
#command <iter>.filter_map(<closure>) => <iter>:filter_map(<closure>)
#command <iter>.fold(<init>, <closure>) => <iter>:fold(<init>, <closure>)
#command <iter>.collect::<<type>>() => <iter>:collect()
#command <iter>.enumerate() => <iter>:enumerate()
#command <iter>.zip(<other>) => <iter>:zip(<other>)
#command <iter>.chain(<other>) => <iter>:chain(<other>)
#command <iter>.take(<n>) => <iter>:take(<n>)
#command <iter>.skip(<n>) => <iter>:skip(<n>)
#command <iter>.take_while(<closure>) => <iter>:take_while(<closure>)
#command <iter>.skip_while(<closure>) => <iter>:skip_while(<closure>)
#command <iter>.all(<closure>) => <iter>:all(<closure>)
#command <iter>.any(<closure>) => <iter>:any(<closure>)
#command <iter>.find(<closure>) => <iter>:find(<closure>)
#command <iter>.position(<closure>) => <iter>:position(<closure>)
#command <iter>.max() => <iter>:max()
#command <iter>.min() => <iter>:min()
#command <iter>.sum() => <iter>:sum()
#command <iter>.product() => <iter>:product()
#command <iter>.count() => <iter>:count()
#command <iter>.last() => <iter>:last()
#command <iter>.nth(<n>) => <iter>:nth(<n>)

// ----------------------------------------------------------------------------
// STRINGS E SLICES
// ----------------------------------------------------------------------------
// Literais de string
#translate "<str>" => "<str>"
#translate r#"<str>"# => "<str>" // raw string
#translate b"<bytes>" => // byte string literal

// Métodos de String
#command <str>.len() => Len(<str>)
#command <str>.is_empty() => Empty(<str>)
#command <str>.to_string() => <str>
#command <str>.to_owned() => <str>
#command <str>.as_str() => <str>
#command <str>.as_bytes() => <str> // como bytes
#command <str>.chars() => hb_ATokens(<str>, "") // iterator de chars
#command <str>.bytes() => // iterator de bytes
#command <str>.contains(<pat>) => (<pat> $ <str>)
#command <str>.starts_with(<prefix>) => (Left(<str>, Len(<prefix>)) == <prefix>)
#command <str>.ends_with(<suffix>) => (Right(<str>, Len(<suffix>)) == <suffix>)
#command <str>.find(<pat>) => At(<pat>, <str>)-1
#command <str>.rfind(<pat>) => hb_RAt(<pat>, <str>)-1
#command <str>.split(<delim>) => hb_ATokens(<str>, <delim>)
#command <str>.split_whitespace() => hb_ATokens(<str>, " ")
#command <str>.lines() => hb_ATokens(<str>, hb_eol())
#command <str>.trim() => AllTrim(<str>)
#command <str>.trim_start() => LTrim(<str>)
#command <str>.trim_end() => RTrim(<str>)
#command <str>.to_lowercase() => Lower(<str>)
#command <str>.to_uppercase() => Upper(<str>)
#command <str>.replace(<from>, <to>) => StrTran(<str>, <from>, <to>)
#command <str>.replacen(<from>, <to>, <count>) => StrTran(<str>, <from>, <to>, 1, <count>)
#command <str>.parse::<<type>>() => hb_cast(<type>, <str>)
#command String::from(<str>) => <str>
#command <str>.to_string() => <str>
#command format!("{}", <value>) => hb_ValToStr(<value>)

// Slices (&str)
#command <slice>[<start>..<end>] => SubStr(<slice>, <start>+1, <end>-<start>)
#command <slice>[..<end>] => Left(<slice>, <end>)
#command <slice>[<start>..] => SubStr(<slice>, <start>+1)
#command <slice>[..] => <slice>

// ----------------------------------------------------------------------------
// VETORES E ARRAYS
// ----------------------------------------------------------------------------
// Vec
#command Vec::new() => {}
#command Vec::with_capacity(<cap>) => Array(<cap>)
#command <vec>.push(<value>) => AAdd(<vec>, <value>)
#command <vec>.pop() => hb_APop(<vec>)
#command <vec>.len() => Len(<vec>)
#command <vec>.is_empty() => (Len(<vec>) == 0)
#command <vec>.capacity() => // capacidade alocada
#command <vec>.get(<index>) => iif(<index> >= 0 .AND. <index> < Len(<vec>), <vec>[<index>+1], NIL)
#command <vec>[<index>] => <vec>[<index>+1] // Rust usa 0-based
#command <vec>.insert(<index>, <value>) => hb_AIns(<vec>, <index>+1, <value>, .T.)
#command <vec>.remove(<index>) => hb_ADel(<vec>, <index>+1, 1, .T.)
#command <vec>.clear() => <vec> := {}
#command <vec>.contains(<value>) => (AScan(<vec>, {|x| x == <value>}) > 0)
#command <vec>.sort() => ASort(<vec>)
#command <vec>.sort_by(<closure>) => ASort(<vec>, , , <closure>)
#command <vec>.reverse() => <vec> := hb_ArrayReverse(<vec>)
#command <vec>.iter() => <vec>:__Iter__()
#command <vec>.iter_mut() => <vec>:__IterMut__()
#command <vec>.into_iter() => <vec>:__IntoIter__()

// Arrays
#command [<value>; <size>] => Array(<size>, <value>)
#command <array>.len() => Len(<array>)
#command <array>[<index>] => <array>[<index>+1]

// Slices de array
#command <array>[<start>..<end>] => hb_ArraySlice(<array>, <start>+1, <end>)
#command <array>[..<end>] => hb_ArraySlice(<array>, 1, <end>)
#command <array>[<start>..] => hb_ArraySlice(<array>, <start>+1, Len(<array>))
#command <array>[..] => AClone(<array>)

// ----------------------------------------------------------------------------
// HASHMAPS E COLECÕES
// ----------------------------------------------------------------------------
#command HashMap::new() => {=>}
#command BTreeMap::new() => {=>} // mapa ordenado
#command HashSet::new() => {=>} // conjunto
#command BTreeSet::new() => {=>} // conjunto ordenado

// HashMap métodos
#command <map>.insert(<key>, <value>) => hb_HSet(<map>, <key>, <value>)
#command <map>.get(<key>) => hb_HGetDef(<map>, <key>, NIL)
#command <map>.get_mut(<key>) => @hb_HGetDef(<map>, <key>, NIL)
#command <map>.contains_key(<key>) => hb_HHasKey(<map>, <key>)
#command <map>.remove(<key>) => hb_HDel(<map>, <key>)
#command <map>.len() => Len(<map>)
#command <map>.is_empty() => (Len(<map>) == 0)
#command <map>.keys() => hb_HKeys(<map>)
#command <map>.values() => hb_HValues(<map>)
#command <map>.iter() => <map>:__Iter__()
#command <map>.iter_mut() => <map>:__IterMut__()

// HashSet métodos
#command <set>.insert(<value>) => hb_HSet(<set>, <value>, .T.)
#command <set>.contains(<value>) => hb_HHasKey(<set>, <value>)
#command <set>.remove(<value>) => hb_HDel(<set>, <value>)
#command <set>.len() => Len(<set>)

// ----------------------------------------------------------------------------
// THREADS E CONCORRÊNCIA
// ----------------------------------------------------------------------------
#command thread::spawn(<closure>) => hb_threadStart(<closure>)
#command thread::sleep(<dur>) => hb_IdleSleep(<dur>.as_secs_f64())
#command thread::current() => // thread atual
#command thread::park() => // bloqueia thread
#command thread::yield_now() => hb_IdleSleep(0)

// Arc (Atomic Reference Counting)
#command Arc::new(<value>) => <value> // simulação
#command <arc>.clone() => <arc>
#command Arc::strong_count(<arc>) => 1 // contagem de referências

// Mutex
#command Mutex::new(<value>) => <value>
#command <mutex>.lock() => hb_mutexLock(<mutex>)
#command <mutex>.try_lock() => hb_mutexTryLock(<mutex>)

// Channel
#command mpsc::channel() => {=>} // channel simples
#command let (tx, rx) = mpsc::channel(); => LOCAL tx := {}, rx := {}
#command tx.send(<value>) => AAdd(tx, <value>)
#command rx.recv() => iif(Len(rx) > 0, hb_APop(rx), NIL)
#command rx.try_recv() => iif(Len(rx) > 0, hb_APop(rx), Err("WouldBlock"))

// ----------------------------------------------------------------------------
// IO E ARQUIVOS
// ----------------------------------------------------------------------------
#command File::open(<path>) => hb_vfOpen(<path>, FO_READ)
#command File::create(<path>) => hb_vfOpen(<path>, FO_CREATE + FO_WRITE)
#command File::open(<path>, <options>) => hb_vfOpen(<path>, <options>)
#command <file>.read_to_string(&mut <string>) => <string> := hb_vfRead(<file>, -1)
#command <file>.read_to_end(&mut <buffer>) => <buffer> := hb_vfRead(<file>, -1)
#command <file>.read(<buffer>) => hb_vfRead(<file>, Len(<buffer>))
#command <file>.write(<data>) => hb_vfWrite(<file>, <data>)
#command <file>.flush() => hb_vfFlush(<file>)
#command <file>.seek(<pos>) => hb_vfSeek(<file>, <pos>, FS_SET)
#command fs::read_to_string(<path>) => MemoRead(<path>)
#command fs::write(<path>, <data>) => MemoWrit(<path>, <data>)
#command fs::read(<path>) => hb_MemoRead(<path>)
#command fs::read_dir(<path>) => Directory(<path>)
#command fs::metadata(<path>) => hb_vfStat(<path>)
#command fs::remove_file(<path>) => hb_FileDelete(<path>)
#command fs::remove_dir(<path>) => hb_DirDelete(<path>)
#command fs::create_dir(<path>) => hb_DirCreate(<path>)
#command fs::create_dir_all(<path>) => hb_DirCreateAll(<path>)

// Path
#command Path::new(<str>) => <str>
#command <path>.exists() => hb_FileExists(<path>) .OR. hb_DirExists(<path>)
#command <path>.is_file() => hb_FileExists(<path>)
#command <path>.is_dir() => hb_DirExists(<path>)
#command <path>.file_name() => hb_FNameNameExt(<path>)
#command <path>.extension() => hb_FNameExt(<path>)
#command <path>.parent() => hb_FNameDir(<path>)

// ----------------------------------------------------------------------------
// TIME
// ----------------------------------------------------------------------------
#command Instant::now() => hb_MilliSeconds()
#command SystemTime::now() => hb_DateTime()
#command Duration::from_secs(<secs>) => <secs>
#command Duration::from_millis(<ms>) => <ms> / 1000
#command Duration::from_micros(<us>) => <us> / 1000000
#command Duration::from_nanos(<ns>) => <ns> / 1000000000
#command <dur>.as_secs() => Int(<dur>)
#command <dur>.as_millis() => Int(<dur> * 1000)
#command <dur>.as_micros() => Int(<dur> * 1000000)
#command <dur>.as_nanos() => Int(<dur> * 1000000000)

// ----------------------------------------------------------------------------
// RANDOM
// ----------------------------------------------------------------------------
#command rand::random() => hb_Random()
#command rand::thread_rng() => // RNG da thread
#command <rng>.gen() => hb_Random()
#command <rng>.gen_range(<start>..<end>) => hb_Random(<start>, <end>)

// ----------------------------------------------------------------------------
// MATEMÁTICA
// ----------------------------------------------------------------------------
// Funções numéricas
#command <num>.abs() => Abs(<num>)
#command <num>.pow(<exp>) => (<num> ** <exp>)
#command <num>.sqrt() => Sqrt(<num>)
#command <num>.cbrt() => (<num> ** (1/3))
#command <num>.exp() => Exp(<num>)
#command <num>.ln() => Log(<num>)
#command <num>.log10() => Log10(<num>)
#command <num>.log2() => (Log(<num>) / Log(2))
#command <num>.sin() => Sin(<num>)
#command <num>.cos() => Cos(<num>)
#command <num>.tan() => Tan(<num>)
#command <num>.asin() => Asin(<num>)
#command <num>.acos() => Acos(<num>)
#command <num>.atan() => Atan(<num>)
#command <num>.sinh() => // hyperbolic sine
#command <num>.cosh() => // hyperbolic cosine
#command <num>.tanh() => // hyperbolic tangent
#command <num>.floor() => Floor(<num>)
#command <num>.ceil() => Ceiling(<num>)
#command <num>.round() => Round(<num>)
#command <num>.trunc() => Int(<num>)
#command <num>.fract() => (<num> - Int(<num>))
#command <num>.signum() => iif(<num> > 0, 1, iif(<num> < 0, -1, 0))
#command <num>.is_nan() => // is NaN
#command <num>.is_infinite() => // is infinite
#command <num>.is_finite() => // is finite
#command <num>.is_normal() => // is normal
#command <num>.max(<other>) => Max(<num>, <other>)
#command <num>.min(<other>) => Min(<num>, <other>)
#command <num>.clamp(<min>, <max>) => iif(<num> < <min>, <min>, iif(<num> > <max>, <max>, <num>))

// Operações bit a bit
#command <num>.count_ones() => hb_bitCount(<num>)
#command <num>.count_zeros() => (hb_bitSize(<num>) - hb_bitCount(<num>))
#command <num>.leading_zeros() => hb_bitLeadingZeros(<num>)
#command <num>.trailing_zeros() => hb_bitTrailingZeros(<num>)
#command <num>.rotate_left(<n>) => hb_bitRotateLeft(<num>, <n>)
#command <num>.rotate_right(<n>) => hb_bitRotateRight(<num>, <n>)
#command <num>.swap_bytes() => hb_bitSwapBytes(<num>)
#command <num>.reverse_bits() => hb_bitReverse(<num>)

// ----------------------------------------------------------------------------
// CASTING E CONVERSÕES
//