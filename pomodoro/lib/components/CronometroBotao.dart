import 'package:flutter/material.dart';

class Cronometrobotao extends StatelessWidget {
  final String texto;
  final IconData icone;
  final void Function()? click;

  const Cronometrobotao({
    required this.texto,
    required this.icone,
    required this.click
});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        textStyle: TextStyle(
          fontSize: 25
        ),
      ),
        onPressed: click,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(icone, size: 35, ),
            ),
            Text(texto)
          ],
        )
    );
  }
}
