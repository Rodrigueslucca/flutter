import 'package:flutter/material.dart';
import 'models/bebida.dart';
import 'services/api_service.dart';

void main() => runApp(AppDistribuidora());

class AppDistribuidora extends StatefulWidget {
  @override
  State<AppDistribuidora> createState() => _AppDistribuidoraState();
}

class _AppDistribuidoraState extends State<AppDistribuidora> {
  final ApiService api = ApiService();
  late Future<List<Bebida>> futureBebidas;

  @override
  void initState() {
    super.initState();
    futureBebidas = api.listarBebidas();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Distribuidora de Bebidas')),
        body: FutureBuilder<List<Bebida>>(
          future: futureBebidas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError)
              return Center(child: Text('Erro: ${snapshot.error}'));

            final bebidas = snapshot.data ?? [];

            return ListView.builder(
              itemCount: bebidas.length,
              itemBuilder: (context, index) {
                final b = bebidas[index];
                return ListTile(
                  leading: Image.network(b.imagem, width: 50, errorBuilder: (_, __, ___) => Icon(Icons.local_drink)),
                  title: Text(b.nome),
                  subtitle: Text('R\$ ${b.valor.toStringAsFixed(2)}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
