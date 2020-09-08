import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=b0f69c54";

void main() async {
  runApp(MaterialApp(
      theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
      home: Home()));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  print(json.decode(response.body)["results"]["currencies"]);
  print(json.decode(response.body)["results"]["currencies"]["USD"]);
  print(json.decode(response.body)["results"]["currencies"]["EUR"]);
  print(json.decode(response.body)["results"]["currencies"]["ARS"]);

  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dollar;
  double euro;
  double argentino;

  final realControle = TextEditingController();
  final dollarControle = TextEditingController();
  final euroControle = TextEditingController();
  final argentinoControle = TextEditingController();

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text ?? "0");
    dollarControle.text = (real / dollar).toStringAsFixed(2);
    euroControle.text = (real / euro).toStringAsFixed(2);
    argentinoControle.text = (real / argentino).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dollar = double.parse(text ?? "0");
    realControle.text = (dollar * this.dollar).toStringAsFixed(2);
    euroControle.text = (dollar * this.dollar / euro).toStringAsFixed(2);
    argentinoControle.text = (dollar * this.dollar / argentino).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text ?? "0");
    dollarControle.text = (euro * this.euro / dollar).toStringAsFixed(2);
    realControle.text = (euro * this.euro).toStringAsFixed(2);
    argentinoControle.text = (euro * this.euro / argentino).toStringAsFixed(2);
  }

  void _argentinoChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double argentino = double.parse(text ?? "0");
    dollarControle.text = (argentino * this.argentino / dollar).toStringAsFixed(2);
    realControle.text = (argentino * this.argentino).toStringAsFixed(2);
    euroControle.text = (argentino * this.argentino / euro).toStringAsFixed(2);

  }

  void _clearAll() {
    realControle.text = "";
    dollarControle.text = "";
    euroControle.text = "";
    argentinoControle.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$ Conversor \$"),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Carregando ...",
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao carregar os dados =(",
                      style: TextStyle(color: Colors.amber, fontSize: 25),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dollar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    argentino = snapshot.data["results"]["currencies"]["ARS"]["buy"];
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Icon(
                              Icons.monetization_on,
                              color: Colors.amber,
                              size: 100,
                            ),
                            buildTextField("BRL - Real", "R\$ ", realControle,
                                _realChanged),
                            Divider(),
                            buildTextField("USD - Dollar", "US ",
                                dollarControle, _dollarChanged),
                            Divider(),
                            buildTextField("EUR - Euro", "\€ ", euroControle,
                                _euroChanged),
                            Divider(),
                            buildTextField("ARS - Peso Argentino", "\$ ", argentinoControle,
                                _argentinoChanged),
                          ],
                        ),
                      ),
                    );
                  }
              }
            }));
  }
}

Widget buildTextField(String label, String prefix,
    TextEditingController controller, Function function) {
  return TextField(
      onChanged: function,
      controller: controller,
      decoration: InputDecoration(
          labelText: "$label",
          labelStyle: TextStyle(color: Colors.amber),
          border: OutlineInputBorder(),
          prefix: Text("$prefix")),
      style: TextStyle(color: Colors.amber, fontSize: 25),
      keyboardType: TextInputType.numberWithOptions(decimal: true));
}
