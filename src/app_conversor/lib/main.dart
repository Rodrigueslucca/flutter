// ...existing code...
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

  bool _isRealToDollar = true; // true: Real -> USD, false: USD -> Real

  double _cotacaoUsdBrl = 0.0; // 1 USD em BRL
  double _cotacaoBrlUsd = 0.0; // 1 BRL em USD (se disponível pela API)

  Future<void> _buscarCotacao() async {
    setState(() {
      _isLoading = true;
      _resultado = "";
    });

    final url = Uri.parse(
      'https://economia.awesomeapi.com.br/json/last/USD-BRL,BRL-USD',
    );
    try {
      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        final dados = json.decode(resposta.body);

        if (dados['USDBRL'] != null) {
          _cotacaoUsdBrl = double.tryParse(dados['USDBRL']['bid'].toString()) ?? 0.0;
        }
        if (dados['BRLUSD'] != null) {
          _cotacaoBrlUsd = double.tryParse(dados['BRLUSD']['bid'].toString()) ?? 0.0;
        }

        // se API não fornecer BRL-USD, calcula recíproco de USD-BRL (se disponível)
        if ((_cotacaoBrlUsd == 0.0 || _cotacaoBrlUsd.isNaN) && _cotacaoUsdBrl > 0) {
          _cotacaoBrlUsd = 1 / _cotacaoUsdBrl;
        }

        setState(() {
          // atualiza campo de cotação segundo direção atual
          dolarController.text = (_isRealToDollar ? _cotacaoUsdBrl : _cotacaoBrlUsd).toStringAsFixed(4);
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
    double valor = double.tryParse(realController.text) ?? 0;
    double cotacao = double.tryParse(dolarController.text) ?? 0;
    if (valor > 0 && cotacao > 0) {
      double resultado;
      String label;
      if (_isRealToDollar) {
        // Real -> USD: USD = BRL / (BRL por USD)
        resultado = valor / cotacao;
        label = "US\$ ${resultado.toStringAsFixed(2)}";
      } else {
        // USD -> Real: BRL = USD * (BRL por USD)
        resultado = valor * cotacao;
        label = "R\$ ${resultado.toStringAsFixed(2)}";
      }
      setState(() {
        _resultado = label;
      });
    } else {
      setState(() {
        _resultado = "Informe valores válidos.";
      });
    }
  }

  void _toggleDirecao(bool novoValor) {
    setState(() {
      _isRealToDollar = novoValor;
      // atualiza campo de cotação para a direção selecionada
      final cot = _isRealToDollar ? _cotacaoUsdBrl : _cotacaoBrlUsd;
      dolarController.text = (cot > 0 ? cot : 0).toStringAsFixed(4);
      // limpa resultado e valores para evitar confusão
      _resultado = "";
      // opcional: limpa o campo de valor
      realController.clear();
    });
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
        backgroundColor: const Color.fromARGB(255, 231, 209, 8),
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _buscarCotacao,
            icon: const Icon(Icons.refresh),
            tooltip: "Atualizar cotação",
          ),
        ],
      ),

      //inserir cor de fundo)
      backgroundColor: const Color.fromARGB(255, 38, 37, 37),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //alinhamento centralizado
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Icon(
              Icons.monetization_on,
              color: const Color.fromARGB(255, 231, 209, 8),
              size: 120,
            ),
            const SizedBox(height: 10),

            // Switch para direção
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Real → US\$",
                  style: TextStyle(color: Colors.white),
                ),
                Switch(
                  value: _isRealToDollar,
                  onChanged: _isLoading ? null : _toggleDirecao,
                  activeColor: const Color.fromARGB(255, 231, 209, 8),
                ),
                const Text(
                  "US\$ → Real",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Campo de valor (pode representar Real ou USD conforme direção)
            TextField(
              controller: realController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: _isRealToDollar ? "Valor em Real:" : "Valor em Dólar:",
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Image.asset(
                      _isRealToDollar
                          ? 'assets/images/bandeira-do-brasil.png'
                          : 'assets/images/bandeira-dos-estates.jpg',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Campo de cotação (readOnly)
            TextField(
              controller: dolarController,
              readOnly: true, //impede edição manual
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: _isRealToDollar ? "Cotação (BRL por USD):" : "Cotação (BRL por USD):",
                labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Image.asset(
                      _isRealToDollar
                          ? 'assets/images/bandeira-dos-estates.jpg'
                          : 'assets/images/bandeira-do-brasil.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            //Botão
            ElevatedButton(
              onPressed: _isLoading ? null : _appConversor,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 231, 209, 8),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Text(
                  "Converter",
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ),
            ),

            const SizedBox(height: 30),

            //resultado / loading
            _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    _resultado,
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
          ],
        ),
      ),
    );
  }
}
// ...existing code...