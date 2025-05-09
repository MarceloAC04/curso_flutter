import 'package:chat/components/auth_form.dart';
import 'package:chat/pages/auth_or_app_page.dart';
import 'package:chat/pages/auth_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: AuthOrAppPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
