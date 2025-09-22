import 'dart:io';

void main(){
  //=======Exemplo 1: if/ else ======
stdout.write('Digite sua idade:'); //Exibe uma mensagem no console;
int idade = int.parse(stdin.readLineSync()!); //Fará a leitura da próxima entrada do usuário e converterá para inteiro se possível;

if(idade >= 18){
  print('Você é maior de idade.');

}else{
  print('você é menor de idade.');
}

}
//execute em: dart condicoes.dart