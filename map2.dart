void main(){
  Map usuario = {
    'nome': 'Lucas',
    'idade': 28,
    'altura': 1.78,
    'lucao.97': '@lucao.97',
  };
  print('Nome: ${usuario['nome']}');
  print('Idade: ${usuario['idade']}');
  print('Altura: ${usuario['altura']}');
  print('Instagram: ${usuario['lucao.97']}');
}