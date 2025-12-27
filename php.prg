<?php
// Exemplo PHP para xHarbour

function main() {
    // Variáveis
    $nome = "Pedro Alves";
    $idade = 40;
    $salario = 5200.80;
    $ativo = true;
    
    // Saída
    echo "Nome: " . $nome . "\n";
    echo "Idade: " . $idade . "\n";
    echo "Salário: " . $salario . "\n";
    echo "Ativo: " . ($ativo ? "Sim" : "Não") . "\n";
    
    // If/Else
    if ($idade >= 18) {
        echo "Maior de idade\n";
    } else {
        echo "Menor de idade\n";
    }
    
    // Switch
    switch (true) {
        case ($idade < 13):
            echo "Criança\n";
            break;
        case ($idade < 18):
            echo "Adolescente\n";
            break;
        case ($idade < 60):
            echo "Adulto\n";
            break;
        default:
            echo "Idoso\n";
            break;
    }
    
    // For Loop
    for ($i = 0; $i < 5; $i++) {
        echo "Contagem: " . $i . "\n";
    }
    
    // Array
    $frutas = array("maçã", "banana", "laranja");
    
    foreach ($frutas as $fruta) {
        echo "Fruta: " . $fruta . "\n";
    }
    
    // Array associativo
    $pessoa = array(
        "nome" => "Maria",
        "idade" => 28,
        "cidade" => "Rio de Janeiro"
    );
    
    foreach ($pessoa as $chave => $valor) {
        echo $chave . ": " . $valor . "\n";
    }
    
    // Função
    $resultado = soma(15, 25);
    echo "Soma: " . $resultado . "\n";
    
    // Data
    echo "Data atual: " . date("d/m/Y") . "\n";
    echo "Hora atual: " . date("H:i:s") . "\n";
    
    // Try/Catch
    try {
        $divisao = 10 / 2;
        echo "Divisão: " . $divisao . "\n";
    } catch (Exception $e) {
        echo "Erro: " . $e->getMessage() . "\n";
    } finally {
        echo "Finally executado\n";
    }
    
    // Null Coalescing (PHP 7+)
    $cor = $cor_favorita ?? "azul";
    echo "Cor favorita: " . $cor . "\n";
    
    // Spaceship Operator (PHP 7+)
    $comparacao = 5 <=> 3;
    echo "Comparação: " . $comparacao . "\n";
}

function soma($a, $b) {
    return $a + $b;
}

// Execução
main();
?>