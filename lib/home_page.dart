import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//Classe que define dados do botão, ou seja, strings referentes a construção//
class ButtonData {
  final String text;
  final IconData icon;
  final Color color;
  final Color textColor;
  final String route;

  ButtonData({
    required this.text,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.route,
  });
}

//Lista de strings referente as paginas que estão definas as rotas dentro do MaterialApp//
final List<String> routes = [
  '/contagem',
  '/exemplo1',
  '/exemplo2',
  '/exemplo3',
  '/exemplo4',
  '/exemplo5',
];

//Cada botão é um mapa com várias propriedades, como texto, ícone, cor de fundo, cor do texto e rota a ser navegada ao clicar no botão//
class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> buttons = [
    {
      'text': 'Contabilizador de Inventário',
      'icon': Icons.inventory,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      'route': routes[0],
    },
    {
      'text': '...',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[1],
    },
    {
      'text': '...',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[2],
    },
    {
      'text': '...',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[3],
    },
    {
      'text': '...',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[4],
    },
    {
      'text': '...',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[5],
    },
  ];

//responsável por navegar para a rota especificada no parâmetro route//
  void _navigateToRoute(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 70, 73),
        title: Text('Gerenciamento'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10),
        children: buttons.map((button) {
          return GestureDetector(
            onTap: () => {_navigateToRoute(button['route'])},
            child: Container(
              decoration: BoxDecoration(
                color: button['color'],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    button['icon'],
                    color: Colors.red,
                    size: 55,
                  ),
                  SizedBox(height: 33),
                  Text(
                    button['text'],
                    style: TextStyle(fontSize: 11, color: button['textColor']),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
