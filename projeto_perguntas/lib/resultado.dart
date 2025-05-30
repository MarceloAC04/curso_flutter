import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
final int pontuacao;
final void Function() reiniciarQuestionario;

Resultado(this.pontuacao, this.reiniciarQuestionario);

String get fraseResultado {
  if (pontuacao < 8) {
    return 'Parabéns!';
  } else if (pontuacao < 12) {
    return 'Você é bom!';
  } else if (pontuacao < 16) {
    return 'Impressionante!';
  } else {
    return 'Nível Jedi';
  }
}
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      padding: EdgeInsets.only(top: 10.0),
      textStyle: TextStyle(fontSize: 18),
      foregroundColor: Colors.blue,
      backgroundColor: Colors.white,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
            child: Text(fraseResultado,
            style: TextStyle(fontSize: 28,
                color: Colors.black,
                backgroundColor: Colors.yellowAccent,
            )),
        ),
        TextButton(onPressed: reiniciarQuestionario,
            style: style,
            child: Text('Reiniciar?'),
        )
      ],
    );
  }
}
