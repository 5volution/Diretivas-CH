# Exemplo Python para xHarbour

def main():
    # Variáveis
    nome = "Ana Costa"
    idade = 25
    salario = 3800.75
    ativo = True
    
    # Saída
    print("Nome:", nome)
    print("Idade:", idade)
    print("Salário:", salario)
    print("Ativo:", ativo)
    
    # If/Elif/Else
    if idade < 13:
        print("Criança")
    elif idade < 18:
        print("Adolescente")
    elif idade < 60:
        print("Adulto")
    else:
        print("Idoso")
    
    # For Loop
    for i in range(5):
        print("Contagem:", i)
    
    # Lista
    frutas = ["maçã", "banana", "laranja", "uva"]
    
    for fruta in frutas:
        print("Fruta:", fruta)
    
    # List Comprehension
    quadrados = [x**2 for x in range(1, 6)]
    print("Quadrados:", quadrados)
    
    # Dicionário
    pessoa = {
        "nome": "João",
        "idade": 30,
        "cidade": "São Paulo"
    }
    
    for chave, valor in pessoa.items():
        print(f"{chave}: {valor}")
    
    # Tupla
    coordenadas = (10.5, 20.3)
    print("Coordenadas:", coordenadas)
    
    # Função
    resultado = soma(10, 20)
    print("Soma:", resultado)
    
    # Lambda
    quadrado = lambda x: x**2
    print("Quadrado de 5:", quadrado(5))
    
    # Try/Except
    try:
        divisao = 10 / 2
        print("Divisão:", divisao)
    except ZeroDivisionError as e:
        print("Erro:", e)
    finally:
        print("Finally executado")
    
    # Gerador
    def gerador_numeros(limite):
        for i in range(limite):
            yield i
    
    for num in gerador_numeros(3):
        print("Gerador:", num)

def soma(a, b):
    return a + b

# Execução principal
if __name__ == "__main__":
    main()