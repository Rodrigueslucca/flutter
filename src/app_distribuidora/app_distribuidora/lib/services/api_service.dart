import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/bebida.dart';

class ApiService {
  final String baseUrl =
      "http://localhost:8089/bebidas"; // use IP do PC se rodar no emulador

  Future<List<Bebida>> getBebidas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Bebida.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao buscar bebidas");
    }
  }
}
