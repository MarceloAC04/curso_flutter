import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String texto;
  final void Function() quandoSelecionado;

  Resposta(this.texto, this.quandoSelecionado);
  
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          style: style,
          onPressed: quandoSelecionado,
          child: Text(texto),
      ),
    );
  }
}
