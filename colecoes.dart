//Exemplo de coleção(lista) em Dart

void main(){
  List<String> nomes = ["Lucas", "Evelyn", "Maria","João"];

  print(nomes);

  for(var nome in nomes){
    print(nome.toUpperCase());
  }
}