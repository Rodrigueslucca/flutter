import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bebida.dart';

class ApiService {
  final String baseUrl = "http://localhost:8089/bebidas";

  Future<List<Bebida>> getBebidas() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Bebida.fromJson(json)).toList();
      } else {
        throw Exception("Erro ao buscar bebidas: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro de conexão: $e");
      throw Exception("Falha na conexão com o servidor: $e");
    }
  }
}
