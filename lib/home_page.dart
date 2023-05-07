import 'package:flutter/material.dart';
import 'contagens.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:app01/page_scanner.dart';
import 'api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de Estoque'),
        centerTitle: true,
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor:
              0.8, // define a largura do botão como 80% da largura disponível na tela
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Contagem(),
                ),
              );
            },
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory,
                    color: Colors.white,
                    size: 47,
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contabilizador de',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      Text(
                        'Inventário',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
