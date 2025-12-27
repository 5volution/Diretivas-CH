// Exemplo C# para xHarbour
using System;

namespace ExemploCSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            // Variáveis
            string nome = "Carlos Santos";
            int idade = 32;
            double salario = 4200.50;
            bool ativo = true;
            
            // Saída
            Console.WriteLine("Nome: " + nome);
            Console.WriteLine("Idade: " + idade);
            Console.WriteLine("Salário: " + salario);
            Console.WriteLine("Ativo: " + ativo);
            
            // If/Else
            if (idade >= 18)
            {
                Console.WriteLine("Maior de idade");
            }
            else
            {
                Console.WriteLine("Menor de idade");
            }
            
            // Switch
            switch (idade)
            {
                case < 13:
                    Console.WriteLine("Criança");
                    break;
                case < 18:
                    Console.WriteLine("Adolescente");
                    break;
                case < 60:
                    Console.WriteLine("Adulto");
                    break;
                default:
                    Console.WriteLine("Idoso");
                    break;
            }
            
            // For Loop
            for (int i = 0; i < 5; i++)
            {
                Console.WriteLine("Contagem: " + i);
            }
            
            // Array
            string[] frutas = { "maçã", "banana", "uva" };
            
            foreach (string fruta in frutas)
            {
                Console.WriteLine("Fruta: " + fruta);
            }
            
            // List
            List<int> numeros = new List<int> { 1, 2, 3, 4, 5 };
            
            foreach (int num in numeros)
            {
                Console.WriteLine("Número: " + num);
            }
            
            // Método
            int resultado = Soma(15, 25);
            Console.WriteLine("Soma: " + resultado);
            
            // DateTime
            Console.WriteLine("Data atual: " + DateTime.Now);
            
            // Try/Catch
            try
            {
                int divisao = 10 / 2;
                Console.WriteLine("Divisão: " + divisao);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Erro: " + ex.Message);
            }
            finally
            {
                Console.WriteLine("Finally executado");
            }
        }
        
        static int Soma(int a, int b)
        {
            return a + b;
        }
    }
}