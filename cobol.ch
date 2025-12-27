// Diretivas para tradução de COBOL para xHarbour

#command IDENTIFICATION DIVISION => 
#command DATA DIVISION =>
#command PROCEDURE DIVISION =>
#command WORKING-STORAGE SECTION =>
#command LOCAL-STORAGE SECTION =>
#command LINKAGE SECTION =>

#command 01 <level1> => Static <level1>
#command 05 <level2> => Static <level2>
#command 10 <level3> => Static <level3>
#command 15 <level4> => Static <level4>
#command 77 <var> => Static <var>

#command PIC <picture> => 
#command VALUE <value> => := <value>
#command COMP-3 => // Conversão BCD necessária
#command COMP => // Campo numérico binário

#command MOVE <exp> TO <var> => <var> := <exp>
#command ADD <exp1> TO <var> => <var> += <exp1>
#command SUBTRACT <exp1> FROM <var> => <var> -= <exp1>
#command MULTIPLY <exp1> BY <var> => <var> *= <exp1>
#command DIVIDE <exp1> INTO <var> => <var> /= <exp1>
#command COMPUTE <var> = <exp> => <var> := <exp>

#command DISPLAY <exp,...> => QOut( <exp> )
#command ACCEPT <var> => <var> := Inkey(0)
#command ACCEPT <var> FROM CONSOLE => <var> := __Accept( "" )

#command IF <cond> => IF <cond>
#command THEN => 
#command ELSE => ELSE
#command END-IF => ENDIF

#command PERFORM <para> => <para>()
#command PERFORM UNTIL <cond> => DO WHILE !(<cond>)
#command PERFORM VARYING <var> FROM <start> BY <inc> UNTIL <cond> => ;
    FOR <var> := <start> TO <end> STEP <inc>

#command EVALUATE TRUE => DO CASE
#command WHEN <cond> => CASE <cond>
#command WHEN OTHER => OTHERWISE
#command END-EVALUATE => ENDCASE

#command CALL <program> USING <params,...> => <program>( <params> )
#command EXIT PROGRAM => RETURN
#command STOP RUN => QUIT

#command STRING <src,...> INTO <dest> => <dest> := <src>
#command UNSTRING <src> INTO <vars,...> => ;
    <vars> := hb_tokenGet( <src>, 1, " " ) ; // Simplificado

#command INSPECT <str> TALLYING <count> FOR CHARACTERS => ;
    <count> := Len( <str> )
#command INSPECT <str> REPLACING ALL <old> BY <new> => ;
    <str> := StrTran( <str>, <old>, <new> )

#command INITIALIZE <var> => <var> := ""
#command SET <var> TO TRUE => <var> := .T.
#command SET <var> TO FALSE => <var> := .F.

#command READ <file> NEXT RECORD => ;
    READ <file>
#command WRITE <record> => ;
    APPEND BLANK ; REPLACE FIELD1 WITH <record>

// Traduções para operadores e funções COBOL
#translate .AND. => .AND.
#translate .OR. => .OR.
#translate .NOT. => .NOT.
#translate = => ==
#translate EQUAL => ==
#translate GREATER => >
#translate LESS => <
#translate NOT EQUAL => !=
#translate NOT GREATER => <=
#translate NOT LESS => >=

#translate NUMERIC(<exp>) => (ValType(<exp>) == "N")
#translate ALPHABETIC(<exp>) => (ValType(<exp>) == "C")
#translate LENGTH(<exp>) => Len(<exp>)
#translate REVERSE(<exp>) => hb_StrReverse(<exp>)
#translate UPPER-CASE(<exp>) => Upper(<exp>)
#translate LOWER-CASE(<exp>) => Lower(<exp>)
#translate FUNCTION RANDOM => hb_Random()
#translate CURRENT-DATE => Date()
#translate FUNCTION SUM(<args,...>) => (<args>)

// Tratamento de campos numéricos COBOL
#translate PIC 9(<n>) => // Campo numérico de <n> dígitos
#translate PIC 9(<n>)V9(<m>) => // Campo numérico com <m> decimais
#translate PIC X(<n>) => // Campo alfanumérico de <n> caracteres

// Comandos de arquivo COBOL
#command OPEN INPUT <file> => USE <file> ALIAS <file> NEW
#command OPEN OUTPUT <file> => CREATE <file>
#command CLOSE <file> => CLOSE <file>
#command READ <file> AT END => IF Eof(); SET PROCEDURE TO ...

#command START <file> KEY IS <key> => SEEK <key> IN <file>
#command REWRITE <record> => REPLACE IN <file>
#command DELETE <file> => DELETE IN <file>

// Comandos de tabela (OCURs em COBOL)
#command OCCURS <n> TIMES => // Array de <n> elementos
#command SEARCH ALL => AScan()
#command SET <index> TO 1 => <index> := 1

// Comandos de relatório (simplificado)
#command INITIATE <report> => // Inicializar relatório
#command GENERATE <detail> => // Processar linha de detalhe
#command TERMINATE <report> => // Finalizar relatório