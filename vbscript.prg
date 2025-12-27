' Exemplo VBScript para xHarbour
Sub Main()
    
    ' Declarações
    Dim nome, idade, salario
    Dim lista(5)
    Dim i
    
    ' Atribuições
    nome = "Maria Oliveira"
    idade = 28
    salario = 3500.75
    
    ' Saída
    MsgBox "Nome: " & nome
    MsgBox "Idade: " & idade
    MsgBox "Salário: " & salario
    
    ' If/Then/Else
    If idade >= 18 Then
        MsgBox "Maior de idade"
    Else
        MsgBox "Menor de idade"
    End If
    
    ' Select Case
    Select Case idade
        Case 0 To 12
            MsgBox "Criança"
        Case 13 To 17
            MsgBox "Adolescente"
        Case 18 To 59
            MsgBox "Adulto"
        Case Else
            MsgBox "Idoso"
    End Select
    
    ' For Loop
    For i = 1 To 5
        lista(i) = i * 10
        MsgBox "Item " & i & ": " & lista(i)
    Next
    
    ' Do While Loop
    i = 1
    Do While i <= 3
        MsgBox "Contagem: " & i
        i = i + 1
    Loop
    
    ' Array
    Dim frutas
    frutas = Array("maçã", "banana", "laranja")
    
    For Each fruta In frutas
        MsgBox "Fruta: " & fruta
    Next
    
    ' Função
    Dim resultado
    resultado = Soma(10, 20)
    MsgBox "Soma: " & resultado
    
    ' Data
    MsgBox "Data atual: " & Date()
    MsgBox "Hora atual: " & Time()
    
End Sub

Function Soma(a, b)
    Soma = a + b
End Function