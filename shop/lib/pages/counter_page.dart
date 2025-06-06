import 'package:flutter/material.dart';
import 'package:shop/Providers/counter.dart';

class  CounterPage extends StatefulWidget {
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo de Contador'),
      ),
      body: Column(
        children: [
          Text(CounterProvider.of(context)?.state.value.toString() ?? '0'),
          IconButton(
              onPressed: () {
                setState(() {
                CounterProvider.of(context)?.state.inc();
                print(CounterProvider.of(context)?.state.value);
                });
              },
              icon: Icon(Icons.add),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                CounterProvider.of(context)?.state.dec();
                print(CounterProvider.of(context)?.state.value);
                });
              },
              icon: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
