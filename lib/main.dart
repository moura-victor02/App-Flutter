// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app01/home_page.dart';
import 'package:flutter/material.dart';
import 'Inventario/contagens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor customColor = MaterialColor(0xFF4D5E66, {
      50: Color(0xFF4D5E66),
      100: Color(0xFF4D5E66),
      200: Color(0xFF4D5E66),
      300: Color(0xFF4D5E66),
      400: Color(0xFF4D5E66),
      500: Color(0xFF4D5E66),
      600: Color(0xFF4D5E66),
      700: Color(0xFF4D5E66),
      800: Color(0xFF4D5E66),
      900: Color(0xFF4D5E66),
    });

    return MaterialApp(
      title: 'Minha aplicação',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      routes: {
        '/': (context) => Homepage(),
        '/contagem': (context) => contagem(),
        /*'/exemplo1': (context) => Exemplo1(),
        '/exemplo2': (context) => Exemplo2(),
        '/exemplo3': (context) => Exemplo3(),
        '/exemplo4': (context) => Exemplo4(),
        '/exemplo5': (context) => Exemplo5(),*/
      },
    );
  }
}
