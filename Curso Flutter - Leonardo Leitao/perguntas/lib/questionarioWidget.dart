import 'package:flutter/material.dart';
import 'package:perguntas/questao.dart';
import 'package:perguntas/respostas.dart';

class Questionario extends StatelessWidget {
  final int perguntaSelecionada;
  final List<Map<String, Object>> perguntas;
  final void Function(int) responder;

  Questionario({
    @required this.perguntaSelecionada,
    @required this.responder,
    @required this.perguntas,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas =
        perguntas[perguntaSelecionada]['respostas'];
    return Column(
      children: <Widget>[
        Questao(perguntas[perguntaSelecionada]['texto']),
        ...respostas.map((map) {
          return Resposta(
            map['texto'],
            () => responder(map['pontuacao']),
          );
        }).toList(),
      ],
    );
  }
}
