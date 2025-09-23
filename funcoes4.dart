//Parâmetros nomeados {}

void cadastrar({required String nome, int idade = 18}) {
  print("Nome $nome, Idade: $idade");
}

void main() {
  cadastrar(idade: 28, nome: "Lucas");
}
