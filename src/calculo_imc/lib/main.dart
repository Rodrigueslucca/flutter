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
           
           ElevatedButton(onPressed: null,
           style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
           ),
           child: Text("Calcular",
           style: TextStyle(color: Colors.white,fontSize: 50))
           )  
           ],
      )
      );
    }
  }

