import 'package:flutter/material.dart';

import '../models/bebida.dart';
import '../services/api_service.dart';


class BebidasPage extends StatefulWidget {
  const BebidasPage({super.key});

  @override
  State<BebidasPage> createState() => _BebidasPageState();
}

class _BebidasPageState extends State<BebidasPage> {
  final ApiService _service = ApiService();
  late Future<List<Bebida>> _bebidas;

  @override
  void initState() {
    super.initState();
    _bebidas = _service.getBebidas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Bebidas')),
      body: FutureBuilder<List<Bebida>>(
        future: _bebidas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma bebida encontrada.'));
          } else {
            final bebidas = snapshot.data!;
            return ListView.builder(
              itemCount: bebidas.length,
              itemBuilder: (context, index) {
                final bebida = bebidas[index];
                return ListTile(
                  title: Text(bebida.nome),
                  subtitle: Text('R\$ ${bebida.valor.toStringAsFixed(2)}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
