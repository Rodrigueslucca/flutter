//Parâmetros opcionais de uma função

void apresentar(String nome, [String? sobrenome]){

  //Verificação de nulidade
  print("Nome: $nome ${sobrenome ?? ''}");
}

void main(){
  apresentar("Lucas");
  apresentar("Lucas", "Rodrigues");
  
}