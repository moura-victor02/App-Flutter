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
  final String padding;

  ButtonData(
      {required this.text,
      required this.icon,
      required this.color,
      required this.textColor,
      required this.route,
      required this.padding});
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
  static const Color primaryColor = Color.fromARGB(255, 63, 70, 73);
  static const Color iconColor = Colors.red;
  static const TextStyle buttonTextStyle = TextStyle(fontSize: 14);

  List<Map<String, dynamic>> buttons = [
    {
      'text': 'Contabilizador de Inventário',
      'icon': Icons.inventory,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      'route': routes[0],
      'padding': Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 50))
    },
    {
      'text': 'under construction',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[1],
    },
    {
      'text': 'under construction',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[2],
    },
    {
      'text': 'under construction',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[3],
    },
    {
      'text': 'under construction',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[4],
    },
    {
      'text': 'under construction',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[5],
    },
  ];

//responsável por navegar para a rota especificada no parâmetro route. Ela recebe uma string que representa o nome da rota//
  void _navigateToRoute(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Gerenciamento'),
        centerTitle: true,
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(), // Para uma rolagem suave
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 24,
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          final button = buttons[index];
          return GestureDetector(
            onTap: () => _navigateToRoute(button['route']),
            child: Container(
              decoration: BoxDecoration(
                color: button['color'],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Alinha os elementos verticalmente ao centro
                children: [
                  Icon(
                    button['icon'],
                    color: iconColor,
                    size: 72,
                  ),
                  SizedBox(height: 15),
                  Text(
                    button['text'],
                    style: buttonTextStyle.copyWith(color: button['textColor']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
