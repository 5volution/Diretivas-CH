// ============================================================================
// DIRETIVAS COMPLETAS PARA TRADUÇÃO DE VBSCRIPT PARA XHARBOUR
// ============================================================================

// ----------------------------------------------------------------------------
// DECLARAÇÕES DE VARIÁVEIS
// ----------------------------------------------------------------------------
#command Dim <vars,...>               => Local <vars>
#command Private <vars,...>           => Private <vars>
#command Public <vars,...>            => Public <vars>
#command Const <id> = <exp>           => #define <id> <exp>
#command ReDim <var>[<size>]          => <var> := Array(<size>)
#command ReDim Preserve <var>[<size>] => ASize(<var>, <size>)

// ----------------------------------------------------------------------------
// ESTRUTURAS DE CONTROLE
// ----------------------------------------------------------------------------
#command If <cond> Then          => IF <cond>
#command ElseIf <cond> Then      => ELSEIF <cond>
#command Else                    => ELSE
#command End If                  => ENDIF

#command Select Case <exp>       => DO CASE
#command Case <value1>           => CASE <exp> == <value1>
#command Case <value1>,<value2>  => CASE <exp> == <value1> .OR. <exp> == <value2>
#command Case <value1> To <value2> => CASE <exp> >= <value1> .AND. <exp> <= <value2>
#command Case Else               => OTHERWISE
#command End Select              => ENDCASE

#command For <var> = <start> To <end>          => FOR <var> := <start> TO <end>
#command For <var> = <start> To <end> Step <s> => FOR <var> := <start> TO <end> STEP <s>
#command Next                                   => NEXT
#command Exit For                               => EXIT

#command For Each <elem> In <collection>       => ;
    AEval(<collection>, {|<elem>| 
#command Next                                  => })

#command Do While <cond>         => DO WHILE <cond>
#command Do Until <cond>         => DO WHILE !(<cond>)
#command Loop                    => ENDDO
#command Exit Do                 => EXIT

#command While <cond>            => DO WHILE <cond>
#command Wend                    => ENDDO

// ----------------------------------------------------------------------------
// PROCEDIMENTOS E FUNÇÕES
// ----------------------------------------------------------------------------
#command Sub <name>[([<params,...>])] => PROCEDURE <name>[([<params,...>])]
#command End Sub                      => RETURN // ENDPROCEDURE
#command Function <name>[([<params,...>])] => FUNCTION <name>[([<params,...>])]
#command End Function                 => RETURN NIL

#command Call <proc>[([<args,...>])] => <proc>( [<args>] )
#command Exit Sub                     => RETURN
#command Exit Function                => RETURN NIL

#command ByVal <param>                => <param>
#command ByRef <param>                => @<param>

// ----------------------------------------------------------------------------
// OPERADORES E EXPRESSÕES
// ----------------------------------------------------------------------------
#command <var> = <exp>                => <var> := <exp>
#command Set <obj> = <exp>            => <obj> := <exp>
#command Let <var> = <exp>            => <var> := <exp>
#command Set <obj> = New <class>      => <obj> := <class>:New()
#command Set <obj> = Nothing          => <obj> := NIL

#translate Not <exp>                  => !(<exp>)
#translate And                        => .AND.
#translate Or                         => .OR.
#translate Xor                        => .XOR.
#translate Eqv                        => .EQV.
#translate Imp                        => .IMP.
#translate Mod                        => %
#translate &                          => +
#translate ^                          => **
#translate \                          => Int(<x>/<y>)
#translate =                          => ==
#translate <>                         => !=

#translate Is                         => ==
#translate Like                       => hb_WildMatch

// ----------------------------------------------------------------------------
// FUNÇÕES DE STRING E DATA
// ----------------------------------------------------------------------------
#command MsgBox <msg>[,<type>[,<title>]] => ;
    MessageBox(0, <msg>, iif(<title> == NIL, "Aplicação", <title>), ;
    iif(<type> == NIL, 0, <type>))

#command InputBox(<prompt>[,<title>[,<default>]]) => ;
    __InputBox(iif(<title> == NIL, "Entrada", <title>), ;
    <prompt>, iif(<default> == NIL, "", <default>))

#translate Len(<str>)                  => Len(<str>)
#translate Left(<str>, <n>)            => Left(<str>, <n>)
#translate Right(<str>, <n>)           => Right(<str>, <n>)
#translate Mid(<str>, <start>[,<n>])   => SubStr(<str>, <start>, <n>)
#translate InStr([<start>,]<str1>,<str2>) => At(<str2>, <str1>, <start>)
#translate InStrRev(<str1>,<str2>[,<start>]) => hb_RAt(<str2>, <str1>, <start>)
#translate LCase(<str>)                => Lower(<str>)
#translate UCase(<str>)                => Upper(<str>)
#translate Trim(<str>)                 => AllTrim(<str>)
#translate LTrim(<str>)                => LTrim(<str>)
#translate RTrim(<str>)                => RTrim(<str>)
#translate StrReverse(<str>)           => hb_StrReverse(<str>)
#translate Replace(<str>,<find>,<replace>[,<start>[,<count>[,<compare>]]]) => ;
    StrTran(<str>, <find>, <replace>, <start>, <count>)
#translate Split(<str>[,<delim>[,<count>[,<compare>]]]) => ;
    hb_ATokens(<str>, iif(<delim>==NIL, ",", <delim>))
#translate Join(<array>[,<delim>])     => ArrayToStr(<array>, iif(<delim>==NIL, ",", <delim>))
#translate StrComp(<str1>,<str2>[,<compare>]) => iif(Upper(<str1>) == Upper(<str2>), 0, 1)

#translate Date()                      => Date()
#translate Now()                       => hb_DateTime()
#translate DateAdd(<interval>, <n>, <date>) => ;
    hb_DateAdd(iif(<interval> == "d", "D", <interval>), <n>, <date>)
#translate DateDiff(<interval>, <date1>, <date2>) => ;
    hb_DateDiff(iif(<interval> == "d", "D", <interval>), <date1>, <date2>)
#translate DatePart(<interval>, <date>) => ;
    hb_DatePart(iif(<interval> == "d", "D", <interval>), <date>)
#translate FormatDateTime(<date>[,<format>]) => ;
    DToC(<date>, iif(<format>==NIL, 1, <format>))
#translate Year(<date>)                => Year(<date>)
#translate Month(<date>)               => Month(<date>)
#translate Day(<date>)                 => Day(<date>)
#translate Weekday(<date>[,<firstday>]) => DoW(<date>)
#translate Hour(<time>)                => hb_Hour(<time>)
#translate Minute(<time>)              => hb_Minute(<time>)
#translate Second(<time>)              => hb_Sec(<time>)

// ----------------------------------------------------------------------------
// FUNÇÕES MATEMÁTICAS
// ----------------------------------------------------------------------------
#translate Abs(<n>)                    => Abs(<n>)
#translate Int(<n>)                    => Int(<n>)
#translate Fix(<n>)                    => Int(<n>)
#translate Round(<n>[,<decimals>])     => Round(<n>, iif(<decimals>==NIL, 0, <decimals>))
#translate Sqr(<n>)                    => Sqrt(<n>)
#translate Rnd([<n>])                  => hb_Random(iif(<n>==NIL, 1, <n>))
#translate Randomize([<seed>])         => hb_RandomSeed(iif(<seed>==NIL, Seconds(), <seed>))
#translate Log(<n>)                    => Log(<n>)
#translate Exp(<n>)                    => Exp(<n>)
#translate Sin(<n>)                    => Sin(<n>)
#translate Cos(<n>)                    => Cos(<n>)
#translate Tan(<n>)                    => Tan(<n>)
#translate Atn(<n>)                    => Atan(<n>)

// ----------------------------------------------------------------------------
// FUNÇÕES DE CONVERSÃO
// ----------------------------------------------------------------------------
#translate CStr(<exp>)                 => hb_ValToStr(<exp>)
#translate CInt(<exp>)                 => Int(Val(<exp>))
#translate CLng(<exp>)                 => Int(Val(<exp>))
#translate CDbl(<exp>)                 => Val(<exp>)
#translate CCur(<exp>)                 => Val(<exp>)
#translate CBool(<exp>)                => iif(<exp>, .T., .F.)
#translate CDate(<exp>)                => CToD(<exp>)
#translate CByte(<exp>)                => Val(<exp>)
#translate Hex(<n>)                    => hb_NumToHex(<n>)
#translate Oct(<n>)                    => hb_NumToOct(<n>)
#translate Asc(<str>)                  => Asc(<str>)
#translate Chr(<code>)                 => Chr(<code>)
#translate Val(<str>)                  => Val(<str>)
#translate Str(<n>)                    => Str(<n>)

// ----------------------------------------------------------------------------
// FUNÇÕES DE ARRAY E COLETÂNEA
// ----------------------------------------------------------------------------
#command Array(<size>)                 => Array(<size>)
#translate LBound(<array>)             => 1
#translate UBound(<array>)             => Len(<array>)
#translate Filter(<array>,<value>[,<include>[,<compare>]]) => ;
    hb_ADel(<array>, <value>, iif(<include>==NIL, .T., <include>))
#translate IsArray(<var>)              => (ValType(<var>) == "A")
#translate Join(<array>[,<delim>])     => ArrayToStr(<array>, iif(<delim>==NIL, ",", <delim>))
#translate Split(<str>[,<delim>])      => hb_ATokens(<str>, iif(<delim>==NIL, " ", <delim>))

// ----------------------------------------------------------------------------
// FUNÇÕES DE VERIFICAÇÃO
// ----------------------------------------------------------------------------
#translate IsDate(<exp>)               => hb_IsDate(<exp>)
#translate IsNumeric(<exp>)            => (ValType(<exp>) == "N")
#translate IsNull(<exp>)               => (<exp> == NIL)
#translate IsEmpty(<exp>)              => (Empty(<exp>))
#translate IsObject(<exp>)             => (ValType(<exp>) == "O")
#translate TypeName(<var>)             => ValType(<var>)
#translate VarType(<var>)              => ValType(<var>)

// ----------------------------------------------------------------------------
// FUNÇÕES DE ARQUIVO E SISTEMA
// ----------------------------------------------------------------------------
#command CreateObject(<class>)         => WIN_OLE_CREATEOBJECT(<class>)
#command GetObject([<file>[,<class>]]) => WIN_OLE_GETOBJECT(iif(<file>==NIL, "", <file>), ;
    iif(<class>==NIL, "", <class>))

#translate FileSystemObject            => CreateObject("Scripting.FileSystemObject")
#translate WScript                     => CreateObject("WScript.Shell")
#translate Shell(<command>[,<style>])  => hb_Run(<command>)

#command OpenTextFile(<file>[,<mode>[,<create>[,<format>]]]) => ;
    hb_vfOpen(<file>, iif(<mode>==NIL, 0, <mode>))

#translate CreateTextFile(<file>[,<overwrite>]) => ;
    hb_vfCreate(<file>, iif(<overwrite>==NIL, .T., <overwrite>))

// ----------------------------------------------------------------------------
// OBJETOS E CLASSES
// ----------------------------------------------------------------------------
#command Class <name>                  => CLASS <name>
#command End Class                     => ENDCLASS
#command Property Get <name>           => ACCESS <name>
#command Property Let <name>           => ASSIGN <name>
#command Property Set <name>           => ASSIGN <name>
#command With <object>                 => 
#command End With                      => 

#translate .<!id!>                     => :<id>
#translate !<!id!>                     => :<id>
#translate Me                          => ::Self

// ----------------------------------------------------------------------------
// TRATAMENTO DE ERROS
// ----------------------------------------------------------------------------
#command On Error Resume Next          => BEGIN SEQUENCE WITH {|oErr| Break(oErr)}
#command On Error Goto <label>         => 
#command Err                           => ErrorNew()
#command Err.Number                    => Error():Code
#command Err.Description               => Error():Description
#command Err.Source                    => Error():Operation
#command Clear                         => Error():Clear()
#command Raise <number>                => hb_Throw(<number>)

// ----------------------------------------------------------------------------
// FUNÇÕES ADICIONAIS
// ----------------------------------------------------------------------------
#translate DoEvents()                  => hb_IdleSleep(0.01)
#translate Sleep(<ms>)                 => hb_IdleSleep(<ms>/1000)
#translate Timer()                     => Seconds()
#translate Environ(<name>)             => GetEnv(<name>)
#translate ScriptFullName              => hb_ProgName()
#translate ScriptName                  => hb_FNameName(hb_ProgName())
#translate CreateShortcut(<path>)      => // Implementação específica
#translate SendKeys(<keys>)            => // Implementação específica
#translate AppActivate(<title>)        => // Implementação específica

// ----------------------------------------------------------------------------
// CONSTANTES PREDEFINIDAS
// ----------------------------------------------------------------------------
#define vbCrLf     Chr(13) + Chr(10)
#define vbCr       Chr(13)
#define vbLf       Chr(10)
#define vbTab      Chr(9)
#define vbBack     Chr(8)
#define vbFormFeed Chr(12)
#define vbVerticalTab Chr(11)
#define vbNullChar Chr(0)
#define vbNullString ""

// Constantes para MsgBox
#define vbOKOnly           0
#define vbOKCancel         1
#define vbAbortRetryIgnore 2
#define vbYesNoCancel      3
#define vbYesNo            4
#define vbRetryCancel      5
#define vbCritical         16
#define vbQuestion         32
#define vbExclamation      48
#define vbInformation      64
#define vbDefaultButton1   0
#define vbDefaultButton2   256
#define vbDefaultButton3   512
#define vbDefaultButton4   768
#define vbApplicationModal 0
#define vbSystemModal      4096
#define vbOK               1
#define vbCancel           2
#define vbAbort            3
#define vbRetry            4
#define vbIgnore           5
#define vbYes              6
#define vbNo               7

// Constantes para comparação de strings
#define vbBinaryCompare    0
#define vbTextCompare      1
#define vbDatabaseCompare  2

// Constantes para datas
#define vbSunday       1
#define vbMonday       2
#define vbTuesday      3
#define vbWednesday    4
#define vbThursday     5
#define vbFriday       6
#define vbSaturday     7
#define vbUseSystem    0
#define vbUseSystemDayOfWeek 0
#define vbFirstJan1    1
#define vbFirstFourDays 2
#define vbFirstFullWeek 3

// ----------------------------------------------------------------------------
// OPERADORES ESPECIAIS
// ----------------------------------------------------------------------------
#translate ( <exp1> \ <exp2> )      => Int( (<exp1>) / (<exp2>) )
#translate ( <exp1> Mod <exp2> )    => ( (<exp1>) % (<exp2>) )
#translate ( <exp1> ^ <exp2> )      => ( (<exp1>) ** (<exp2>) )
#translate ( <exp1> & <exp2> )      => ( hb_ValToStr(<exp1>) + hb_ValToStr(<exp2>) )
#translate ( <exp1> Eqv <exp2> )    => ( !((<exp1>) .XOR. (<exp2>)) )
#translate ( <exp1> Imp <exp2> )    => ( (!(<exp1>)) .OR. (<exp2>) )
#translate ( <exp1> Xor <exp2> )    => ( (<exp1>) .XOR. (<exp2>) )

// ----------------------------------------------------------------------------
// FUNÇÕES REGEX (EXPRESSÕES REGULARES)
// ----------------------------------------------------------------------------
#command CreateObject("VBScript.RegExp") => hb_regexComp("")
#translate .Pattern                    => :cPattern
#translate .IgnoreCase                 => :lIgnoreCase
#translate .Global                     => :lGlobal
#translate .Test(<str>)                => hb_regexLike(:cPattern, <str>)
#translate .Execute(<str>)             => hb_regexAll(:cPattern, <str>,, .T.)
#translate .Replace(<str>, <replace>)  => hb_regexReplace(:cPattern, <str>, <replace>)

// ----------------------------------------------------------------------------
// SINÔNIMOS E ALTERNATIVAS
// ----------------------------------------------------------------------------
#command WScript.Echo <exp,...>       => QOut( <exp> )
#command Echo <exp,...>               => QOut( <exp> )
#command Print <exp,...>              => QQOut( <exp> )
#command Write <exp,...>              => QQOut( <exp> )
#command Debug.Print <exp,...>        => // Comentário: Debug.Print
#command Nothing                      => NIL
#command Null                         => NIL
#command Empty                        => ""
#command True                         => .T.
#command False                        => .F.

// ----------------------------------------------------------------------------
// CONTINUAÇÃO DE LINHA (VBScript usa _ no final da linha)
// ----------------------------------------------------------------------------
#translate _ => ;