import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(home: Home(), debugShowCheckedModeBanner: false));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Controladores para os campos de texto
  final TextEditingController realController = TextEditingController();
  final TextEditingController dolarController = TextEditingController();

  String _resultado = "";
  bool _isLoading = false; //controla se está carregando a cotação

  Future<void> _buscarCotacao() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
      'https://economia.awesomeapi.com.br/json/last/USD-BRL',
    );
    try {
      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        final dados = json.decode(resposta.body);
        final cotacao = double.parse(dados['USDBRL']['bid']);
        setState(() {
          dolarController.text = cotacao.toStringAsFixed(2);
        });
      } else {
        setState(() {
          _resultado = "Erro ao buscar cotação(${resposta.statusCode})";
        });
      }
    } catch (e) {
      setState(() {
        _resultado = "Erro na conexão: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _buscarCotacao(); //busca ao iniciar
  }

  void _appConversor() {
    double real = double.tryParse(realController.text) ?? 0;
    double cotacao = double.tryParse(dolarController.text) ?? 0;
    if (real > 0 && cotacao > 0) {
      double resultado = real / cotacao;
      setState(() {
        _resultado = "US\$ ${resultado.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        _resultado = "Informe valores válidos.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conversor de Moedas',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _buscarCotacao,
            icon: Icon(Icons.refresh),
            tooltip: "Atualizar cotação",
          ),
        ],
      ),

      //inserir cor de fundo)
      backgroundColor: Colors.white,
      body: Column(
        //alinhamento centralizado
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.monetization_on, color: Colors.green, size: 120),
          const SizedBox(height: 10),
          TextField(
            //definir o tipo de entrada
            controller: realController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Valor em Real: ",
              labelStyle: TextStyle(color: Colors.green, fontSize: 25),
            ),
          ),
          TextField(
            //definir o tipo de entrada
            controller: dolarController,
            readOnly: true, //impede edição manual
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Cotação do Dólar: ",
              labelStyle: TextStyle(color: Colors.green, fontSize: 25),
            ),
          ),
          const SizedBox(height:20),
          
          //Botão
          ElevatedButton(
            onPressed: _isLoading ? null : _appConversor,

            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              "Converter",
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
          ),

         const SizedBox(height: 30),

         //resultado
          _isLoading ? const CircularProgressIndicator(color: Colors.green)
          : Text(
            _resultado,
            style: const TextStyle(fontSize: 25, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
