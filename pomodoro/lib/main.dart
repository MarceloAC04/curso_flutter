import 'package:flutter/material.dart';
import 'package:pomodoro/pages/Pomodoro.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(providers: [
      Provider<PomodoroStore>(
        create: (_) => PomodoroStore(),
      )
    ],
     child:  MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Pomodoro(),
      debugShowCheckedModeBanner: false,
    )
    );
  }
}

// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:pomodoro/store/contador.store.dart';
// final store = ContadorStore();
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text('Contador'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Observer(
//               builder:
//                   (_) => Text(
//                     '${store.contador}',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: store.incrementar,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

