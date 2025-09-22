import 'dart:io';

void main (){
  //======= Exemplo 2: if / else/ else if ====

  stdout.write('Digite uma nota de 0 a 10: ');

  double nota = double.parse(stdin.readLineSync()!);
  if (nota >= 9){
    print('Conceito A');
  }else if (nota >= 7){
    print('Conceito B');
  }else if(nota >= 5 ){
    print('Conceito C');
  }else {
    print('Conceito D');
  }
}