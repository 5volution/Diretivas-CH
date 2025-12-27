// Exemplo Delphi/Pascal para xHarbour
program ExemploDelphi;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  nome: String;
  idade: Integer;
  salario: Double;
  ativo: Boolean;
  i: Integer;
  
procedure ExibirDados;
begin
  WriteLn('Nome: ', nome);
  WriteLn('Idade: ', idade);
  WriteLn('Salário: ', FormatFloat('0.00', salario));
  WriteLn('Ativo: ', BoolToStr(ativo, True));
end;

function Soma(a, b: Integer): Integer;
begin
  Result := a + b;
end;

procedure ProcessarIdade(idade: Integer);
begin
  case idade of
    0..12: WriteLn('Criança');
    13..17: WriteLn('Adolescente');
    18..59: WriteLn('Adulto');
  else
    WriteLn('Idoso');
  end;
end;

// Classe exemplo
type
  TPessoa = class
  private
    FNome: String;
    FIdade: Integer;
  public
    constructor Create(Nome: String; Idade: Integer);
    procedure ExibirInfo;
    property Nome: String read FNome write FNome;
    property Idade: Integer read FIdade write FIdade;
  end;

constructor TPessoa.Create(Nome: String; Idade: Integer);
begin
  inherited Create;
  Self.Nome := Nome;
  Self.Idade := Idade;
end;

procedure TPessoa.ExibirInfo;
begin
  WriteLn('Pessoa: ', FNome, ', ', FIdade, ' anos');
end;

// Programa principal
begin
  try
    // Atribuições
    nome := 'Roberto Lima';
    idade := 45;
    salario := 5800.75;
    ativo := True;
    
    // Exibir dados
    ExibirDados;
    
    // If/Then/Else
    if idade >= 18 then
      WriteLn('Maior de idade')
    else
      WriteLn('Menor de idade');
    
    // Case
    ProcessarIdade(idade);
    
    // For Loop
    for i := 1 to 5 do
      WriteLn('Contagem: ', i);
    
    // While Loop
    i := 1;
    while i <= 3 do
    begin
      WriteLn('While: ', i);
      Inc(i);
    end;
    
    // Repeat/Until
    i := 1;
    repeat
      WriteLn('Repeat: ', i);
      Inc(i);
    until i > 3;
    
    // Array
    var frutas: array[0..2] of String = ('maçã', 'banana', 'laranja');
    
    for i := Low(frutas) to High(frutas) do
      WriteLn('Fruta: ', frutas[i]);
    
    // Função
    var resultado: Integer;
    resultado := Soma(20, 30);
    WriteLn('Soma: ', resultado);
    
    // Objeto
    var pessoa: TPessoa;
    pessoa := TPessoa.Create('Carlos', 35);
    try
      pessoa.ExibirInfo;
    finally
      pessoa.Free;
    end;
    
    // Data/Hora
    WriteLn('Data atual: ', DateToStr(Date));
    WriteLn('Hora atual: ', TimeToStr(Time));
    WriteLn('Data/Hora atual: ', DateTimeToStr(Now));
    
    // Formatação
    WriteLn('Salário formatado: ', FormatFloat('R$ #,##0.00', salario));
    
    // String functions
    WriteLn('Nome em maiúsculo: ', UpperCase(nome));
    WriteLn('Nome em minúsculo: ', LowerCase(nome));
    WriteLn('Posição do espaço: ', Pos(' ', nome));
    
  except
    on E: Exception do
      WriteLn('Erro: ', E.Message);
  end;
  
  WriteLn('Pressione Enter para sair...');
  ReadLn;
end.