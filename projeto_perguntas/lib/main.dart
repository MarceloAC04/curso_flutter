// Contem stateless, build e etc.
import 'package:flutter/material.dart';
import 'questionario.dart';
import 'resultado.dart';

main()  => runApp(PerguntaApp());

// 1º PARTE de conexão entre um compenente Stateful e estado
// PerguntaAppState é a classe que gerencia o estado
class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;
  final _perguntas = const [
    {
      'texto': 'Qual é a sua cor favorita ?',
      'respostas': [
        {'texto': 'Preto', 'pontuacao': 10},
        {'texto': 'Vermelho', 'pontuacao': 5},
        {'texto': 'Verde', 'pontuacao': 3},
        {'texto': 'Branco', 'pontuacao': 1},
      ],
    },
    {
      'texto': 'Qual é a sua animal favorito ?',
      'respostas': [
        {'texto': 'Coelho', 'pontuacao': 10},
        {'texto': 'Cobra', 'pontuacao': 5},
        {'texto': 'Elefante', 'pontuacao': 3},
        {'texto': 'Leão', 'pontuacao': 1},
      ],
    },
    {
      'texto': 'Qual é a seu instrutor favorito ?',
      'respostas': [
        {'texto': 'Maria', 'pontuacao': 10},
        {'texto': 'João', 'pontuacao': 5},
        {'texto': 'Leo', 'pontuacao': 3},
        {'texto': 'Pedro', 'pontuacao': 1},
      ],
    }
  ];

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada) {
    // O monitora o estado a ser mudado.
    setState(() {
      _perguntaSelecionada++;
      _pontuacaoTotal += pontuacao;
    });
    }
    print(_pontuacaoTotal);
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  void _reiniciarQuestionario() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Perguntas'),
              centerTitle: true,
              backgroundColor: Colors.blueAccent,
            ),
            body: temPerguntaSelecionada ?
              Questionario(perguntas: _perguntas,
                  perguntaSelecionada: _perguntaSelecionada,
                  quandoResponder: _responder)
            : Resultado(_pontuacaoTotal, _reiniciarQuestionario),
        ),
    );
  }
}

// Classe componente statful, agora herda de StatefulWidget
class PerguntaApp extends StatefulWidget {

  // 2º PARTE de conexão entre componente e estado
  // createState retorna o estado
  State<PerguntaApp> createState() {
    return _PerguntaAppState();
  }
}

