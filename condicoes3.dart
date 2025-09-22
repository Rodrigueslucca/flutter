import 'dart:io';

void main(){
  // ===Exemplo 3: switch/ case =========

  stdout.write('Digite uma letra(a, b ou c): ');

  String letra = stdin.readLineSync()!.toLowerCase();

  switch(letra){
    case 'a':
    print('Você digitou A. ');
    break;
    case 'b':
    print('Você digitou B.');
    break;
    case 'c':
    print('Você digitou C');
    break;
    default:
    print('Opção iválida');
  }
}