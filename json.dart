import 'dart:convert';

void main(){

  String jsonString = '''
{
"id": 1,
"nome": "Lucas",
"email": "lucas@gmail.com",
"ativo": true,
"habilidades": ["Dart", "Flutter", "SQL"],
"endereco": {
"rua": "Av. Brasil",
"numero": 100,
"cidade": "Rio de Janeiro"
}
}
''';

Map<String, dynamic> usuario = jsonDecode(jsonString);

print("Nome: ${usuario['nome']}");
print("Email: ${usuario['email']}");
print("Habilidades: ${usuario['habilidades']}");
print("Endereço: ${usuario['endereco']['cidade']}");

String novoJson = jsonEncode(usuario);
print("\nJSON gerado novamente:");
print(novoJson);

}