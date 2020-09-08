import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String _pergunta;
  final void Function() onSelecao;

  Resposta(
    this._pergunta,
    this.onSelecao,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 10, left: 10),
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.blue,
        child: Text(_pergunta),
        onPressed: onSelecao,
      ),
    );
  }
}
