import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    )
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>(); 
    });
  }

  void calcularImc () {
    setState((){
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double result = weight / (height * height);
      if(result < 18.5) {
        _infoText = "Seu IMC é de (${result.toStringAsPrecision(3)}). Você está abaixo do peso.";
      } else if(result > 18.5 && result < 24.9) {
        _infoText = "Seu IMC é de (${result.toStringAsPrecision(3)}). Você está com peso normal.";
      } else if(result > 25.0 && result < 29.9) {
        _infoText = "Seu IMC é de (${result.toStringAsPrecision(3)}). Você está com sobrepeso.";
      } else if(result > 30.0 && result < 34.9) {
        _infoText = "Seu IMC é de (${result.toStringAsPrecision(3)}). Você está comobesidade grau 1.";
      } else if(result > 35.0 && result < 39.9) {
        _infoText = "Seu IMC é de (${result.toStringAsPrecision(3)}). Você está com obesidade grau 2.";
      } else if(result > 40.0) {
        _infoText = "Seu IMC é de (${result.toStringAsPrecision(3)}). Você está com obesidade grau 3 (mórbida).";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 117, 0, 163),
        actions: [
          IconButton(
            onPressed: () {
              _resetFields();
            }, 
            icon: Icon(Icons.refresh, color: Colors.white,),
          ),
        ],
      ),
      body: SingleChildScrollView( //Rolagem ao abrir teclado para nao bugar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 130.0, color: Color.fromARGB(255, 117, 0, 163)),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Color.fromARGB(255, 117, 0, 163)),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Insira sua altura!";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Color.fromARGB(255, 117, 0, 163)),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Insira seu peso!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25,),
                Container(
                  width: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        calcularImc();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 117, 0, 163),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    child: Text("Medir IMC", style: TextStyle( color: Colors.white, fontSize: 12.0))
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromARGB(255, 117, 0, 163), fontSize: 25.0),
                )
              ],
            ),
          ), 
        ),
      ),
    );
  }
}