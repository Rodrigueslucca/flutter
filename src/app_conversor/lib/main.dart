import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ),
  );
 }

class Home extends StatefulWidget{
  const Home ({super.key});
 
  @override
  State <Home> createState()=> _HomeState(
    
  );

  
}

  class _HomeState extends State <Home>{
      //Controladores para os campos de texto
    final TextEditingController realController = TextEditingController();
    final TextEditingController dolarController = TextEditingController();

    String _resultado = "";

     Future<void> _buscarCotacao() async{
      final url = Uri.parse('https://economia.awesomeapi.com.br/json/last/USD-BRL');
      final resposta = await http.get(url);

      if(resposta.statusCode == 200){
        final dados = json.decode(resposta.body);
        final cotacao = double.parse(dados['USDBRL']['bid']);
        setState((){
          dolarController.text = cotacao.toStringAsFixed(2);
        });
      } else{
        setState((){
          _resultado = "Erro ao buscar cotação!";
        });
      }
    }

    
    void _appConversor(){
      double real = double.tryParse(realController.text)?? 0;
      double cotacao = double.tryParse(dolarController.text)??0;
      if(real > 0 && cotacao > 0){
        double resultado = real /cotacao;
        setState((){
          _resultado = "US\$ ${resultado.toStringAsFixed(2)}";
        });
      }else{
        setState((){
          _resultado = "";
        });

        
      }
    }


    @override
    Widget build(BuildContext context){
      return Scaffold(appBar: AppBar(
        title: Text('Conversor de Moedas',
        style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions:[
          IconButton(onPressed: null,
          icon: Icon(Icons.refresh),
        )
 ],
      ),
      //inserir cor de fundo)
      backgroundColor: Colors.white,
      body: Column(
        //alinhamento centralizado
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.person_outline,
            color: Colors.green,
            size: 120,
          ),
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
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Valor em Dólar: ",
              labelStyle: TextStyle(color: Colors.green, fontSize: 25),
            ),
           ),
           //Botão
           
           ElevatedButton(
            onPressed:(){ 
              _buscarCotacao();
              _appConversor();
             }, //funcionamentoi do butão
           style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
           ),
           child: Text("Converter",
           style: TextStyle(color: Colors.white,fontSize: 50)),
           
           ),
           SizedBox(height: 20),
           Text(_resultado,
           style: TextStyle(fontSize: 25, color: Colors.green),
           ),  
           ],
      )
      );
    }
  }
