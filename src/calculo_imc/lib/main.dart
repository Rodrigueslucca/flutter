import 'package:flutter/material.dart';

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
  State <Home> createState()=> _HomeState();
}

  class _HomeState extends State <Home>{
      //Controladores para os campos de texto
    final TextEditingController pesoController = TextEditingController();
    final TextEditingController alturaController = TextEditingController();

    String _resultado = "";
    
    void _calcularIMC(){
      double peso = double.tryParse(pesoController.text)?? 0;
      double altura = double.tryParse(alturaController.text)??0;
      if(peso > 0 && altura > 0){
        altura = altura /100; //converter cm para m
        double imc = peso / (altura * altura);
        setState(() {
        _resultado = "IMC: ${imc.toStringAsFixed(2)}";
      });
      }else{
        setState((){
          _resultado = "Preeencha os campos corretamente!";
        });
      }
    }
    @override
    Widget build(BuildContext context){
      return Scaffold(appBar: AppBar(
        title: Text('Calculadora IMC'),
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
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Peso Kg",
              labelStyle: TextStyle(color: Colors.green, fontSize: 25),
            ),
           ),
           TextField(
            //definir o tipo de entrada
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Altura cm",
              labelStyle: TextStyle(color: Colors.green, fontSize: 25),
            ),
           ),
           //Botão
           
           ElevatedButton(onPressed: _calcularIMC, //funcionamentoi do butão
           style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
           ),
           child: Text("Calcular",
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
