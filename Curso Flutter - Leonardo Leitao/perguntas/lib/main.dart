import 'package:flutter/material.dart';
import 'package:perguntas/questionarioWidget.dart';
import 'package:perguntas/resultadoWidget.dart';
import './questao.dart';
import 'respostas.dart';

main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;
  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual é a sua cor favorita?',
      'respostas': [
        {'texto': 'Preto', 'pontuacao': 10},
        {'texto': 'Vermelho', 'pontuacao': 5},
        {'texto': 'Verde', 'pontuacao': 6},
        {'texto': 'Azul', 'pontuacao': 1},
      ],
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'respostas': [
        {'texto': 'Gato', 'pontuacao': 1},
        {'texto': 'Cachorro', 'pontuacao': 6},
        {'texto': 'Cobra', 'pontuacao': 5},
        {'texto': 'Peixe', 'pontuacao': 10},
      ],
    },
    {
      'texto': 'Qual é o seu instrutor favorito?',
      'respostas': [
        {'texto': 'Maria', 'pontuacao': 5},
        {'texto': 'João', 'pontuacao': 6},
        {'texto': 'Leonardo', 'pontuacao': 10},
        {'texto': 'Pedro', 'pontuacao': 1},
      ],
    }
  ];

  void _responder(int pontuacao) {
    setState(() {
      _pontuacaoTotal += pontuacao;
      _perguntaSelecionada++;
      print(_perguntaSelecionada);
      print(_pontuacaoTotal);
    });
  }

  void reiniciar() {
    return setState(() {
      _pontuacaoTotal = 0;
      _perguntaSelecionada = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
        ),
        body: temPerguntaSelecionada
            ? Questionario(
                perguntaSelecionada: _perguntaSelecionada,
                responder: _responder,
                perguntas: _perguntas,
              )
            : Resultado(
                pontuacaoTotal: _pontuacaoTotal,
                onPressedReiniciar: reiniciar,
              ),
      ),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}
