import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Cálculo de IMC",
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoControle = TextEditingController();
  TextEditingController alturaControle = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Color _corinfo = Color.fromRGBO(250, 0, 0, 0.4);
  String _info = "Informe seus dados";

  void _reset() {
    pesoControle.text = "";
    alturaControle.text = "";
    setState(() {
      _corinfo = Color.fromRGBO(250, 0, 0, 0.4);
      _info = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    double peso = double.parse(pesoControle.text);
    double altura = double.parse(alturaControle.text);
    double imc = peso / pow(altura, 2);
    setState(() {
      if (imc < 18.6) {
        _info = "Abaixo do peso ${imc.toStringAsPrecision(4)}";
        _corinfo = Color.fromRGBO(150, 0, 100, 0.5);
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = "Peso ideal ${imc.toStringAsPrecision(4)}";
        _corinfo = Color.fromRGBO(0, 150, 0, 0.5);
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = "Levemente acima do peso ${imc.toStringAsPrecision(4)}";
        _corinfo = Color.fromRGBO(230, 140, 0, 0.5);
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = "Obesidade grau I ${imc.toStringAsPrecision(4)}";
        _corinfo = Color.fromRGBO(250, 0, 100, 0.5);
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = "Obesidade grau II ${imc.toStringAsPrecision(4)}";
        _corinfo = Color.fromRGBO(250, 0, 100, 0.5);
      } else if (imc >= 40) {
        _info = "Obesidade grau III ${imc.toStringAsPrecision(4)}";
        _corinfo = Color.fromRGBO(255, 0, 0, 0.5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Reset formulário",
            onPressed: _reset,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 0, 10, 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.indigo,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
                validator: (texto) {
                  if (texto.isEmpty) {
                    return "Insira seu peso";
                  }
                },
                controller: pesoControle,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
                validator: (texto) {
                  if (texto.isEmpty) {
                    return "Insira uma altura";
                  }
                },
                controller: alturaControle,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  height: 30,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calcular();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(fontSize: 20),
                    ),
                    color: Colors.indigo,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: _corinfo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
