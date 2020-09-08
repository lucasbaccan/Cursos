import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final void Function() onPressedReiniciar;
  final int pontuacaoTotal;

  Resultado({
    @required this.onPressedReiniciar,
    @required this.pontuacaoTotal,
  });

  String get fraseResultado {
    if (pontuacaoTotal < 8) {
      return "Parabéns!";
    } else if (pontuacaoTotal < 15) {
      return "Você eé bom!";
    } else if (pontuacaoTotal < 20) {
      return "Impressionante!";
    } else {
      return "Nivel Jedi!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Text(
          "$fraseResultado $pontuacaoTotal",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        onPressed: onPressedReiniciar,
      ),
    );
  }
}
