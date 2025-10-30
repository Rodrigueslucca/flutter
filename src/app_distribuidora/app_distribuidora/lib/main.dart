import 'package:flutter/material.dart';

import 'models/bebida.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Distribuidora',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const BebidasPage(),
    );
  }
}

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

  String? _assetForBebida(Bebida bebida) {
    final nome = bebida.nome.toLowerCase();
    if (nome.contains('coca')) return 'assets/images/cocacola.jpg';
    if (nome.contains('água') || nome.contains('agua')) return 'assets/images/agua_mineral.jpg';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Distribuidora de Bebidas')),
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
                final asset = _assetForBebida(bebida);
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: bebida.imagemUrl.isNotEmpty
                        ? Image.network(
                            bebida.imagemUrl,
                            width: 60,
                            fit: BoxFit.cover,
                          )
                        : (asset != null
                            ? Image.asset(
                                asset,
                                width: 60,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.local_drink, size: 40)),
                    title: Text(bebida.nome),
                    subtitle: Text('R\$ ${bebida.valor.toStringAsFixed(2)}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
