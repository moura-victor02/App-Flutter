import 'package:flutter/material.dart';
import 'Inventario/contagens.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 70, 73),
        title: Text('Gerenciamento'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: FractionallySizedBox(
                widthFactor: 0.97,
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
                    height: 135,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 63, 70, 73),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.inventory,
                          color: Colors.red,
                          size: 53,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Contabilizador de Inventário',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: FractionallySizedBox(
                widthFactor: 0.97,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 135,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 63, 70, 73),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.help_outline,
                          color: Colors.red,
                          size: 53,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Lista de Produtos',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
