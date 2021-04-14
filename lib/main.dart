import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //Declaração da variavel global

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {// fix para que o sistema limpe os dados
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();//Linha para limpar a mensagem de erro
    });
  }

  void _calculate() {
    setState(() { // faz com que os dados sejam atualizados em tela
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText =
        "Você está abaixo do peso ideal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Parabéns, você está no seu peso ideal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Atenção, você está levemente acima do peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.8 && imc < 39.9) {
        _infoText = "Obesidade Grau II(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III(${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //Faz a srolagem para que o teclado não fique por cima dos campos
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          //descola as bordas
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                  validator: (value){
                    if(value.isEmpty){
                     return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura(cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira sua altura!";
                    }
                  },
                ),
                Padding(
                  // inserido o pading para separar o botao da linha da altura, colocado o botao como filho
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    //Definir o tamanho do botão por meio de container, sendo o botão filho deste
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text("Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0)),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(_infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0))
              ],
            ),
          ),
        ));
  }
}
