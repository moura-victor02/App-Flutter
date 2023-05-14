import 'package:app01/home_page.dart';
import 'package:flutter/material.dart';
import 'Inventario/contagens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha aplicação',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/contagem': (context) => Contagem(),
        /*'/exemplo1': (context) => Exemplo1(),
        '/exemplo2': (context) => Exemplo2(),
        '/exemplo3': (context) => Exemplo3(),
        '/exemplo4': (context) => Exemplo4(),
        '/exemplo5': (context) => Exemplo5(),*/
      },
    );
  }
}
