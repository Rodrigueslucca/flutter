import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bebida.dart';

class ApiService {
  final String baseUrl = "http://localhost:8080/bebidas"; // use IP do PC se rodar no emulador

  Future<List<Bebida>> listarBebidas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List lista = json.decode(response.body);
      return lista.map((e) => Bebida.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao buscar bebidas");
    }
  }

  Future<Bebida> adicionarBebida(Bebida bebida) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(bebida.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Bebida.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao adicionar bebida");
    }
  }
}
