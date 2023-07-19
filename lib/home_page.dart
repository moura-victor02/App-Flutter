import 'package:flutter/material.dart';
import 'package:app01/Inventario/page_scanner.dart';
import 'Inventario/api_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class CustomListTile {
  final String title;
  final Function onTap;

  CustomListTile({required this.title, required this.onTap});
}

void sendNumber(BuildContext context, int buttonNumber) {
  int barcodeNumber = buttonNumber;
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => barcodeScannerPage(
        barcodeNumber: barcodeNumber,
        apiService: ApiService(),
        apiObject:
            ApiObject(code: '', description: '', amount: '', armazemNumber: ''),
      ),
    ),
  );
}

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
  '/agenda',
  '/exemplo2',
  '/exemplo3',
  '/exemplo4',
  '/exemplo5',
];

//Cada botão é um mapa com várias propriedades, como texto, ícone, cor de fundo, cor do texto e rota a ser navegada ao clicar no botão//
class _HomePageState extends State<Homepage> {
  String numeroArmazem = '';
  static const Color primaryColor = Color.fromARGB(255, 63, 70, 73);
  static const Color iconColor = Colors.red;
  static const TextStyle buttonTextStyle = TextStyle(fontSize: 13);
  static const Color listtilecolor = Colors.white;
  static const Color iconlisttilecolor = Colors.black;
  static const EdgeInsets paddinglisttitle = EdgeInsets.fromLTRB(18, 5, 10, 5);
  static const EdgeInsets paddingadditionaltile =
      EdgeInsets.fromLTRB(28, 2, 30, 2);
  static const EdgeInsets paddingadditionaltile3 =
      EdgeInsets.fromLTRB(38, 1, 50, 1);

  List<String> listTiles = [
    'Contabilizador de Inventário',
    'Reservas de Reuniões',
    'Under construction-3',
    'Under construction-4',
    'Under construction-5',
    'Under construction-6',
  ];
  bool showAdditionalTile = false;
  bool showAdditionalTile2 = false;
  bool showAdditionalTile3 = false;
  bool showAdditionalTile4 = false;
  bool showAdditionalTile5 = false;

  List<Map<String, dynamic>> buttons = [
    {
      'text': 'Contabilizador de Inventário',
      'icon': Icons.inventory,
      'color': primaryColor,
      'textColor': Colors.white,
      'route': routes[0],
    },
    {
      'text': 'Reservas de Reuniõe',
      'icon': Icons.calendar_today,
      'color': primaryColor,
      'textColor': Colors.white,
      //'route': routes[1],
    },
    {
      'text': 'under construction2',
      'icon': Icons.help_outline,
      'color': primaryColor,
      'textColor': Colors.white,
      //'route': routes[2],
    },
    {
      'text': 'under construction3',
      'icon': Icons.help_outline,
      'color': primaryColor,
      'textColor': Colors.white,
      //'route': routes[3],
    },
    {
      'text': 'under construction4',
      'icon': Icons.help_outline,
      'color': primaryColor,
      'textColor': Colors.white,
      //'route': routes[4],
    },
    {
      'text': 'under construction5',
      'icon': Icons.help_outline,
      'color': primaryColor,
      'textColor': Colors.white,
      //'route': routes[5],
    },
  ];

//responsável por navegar para a rota especificada no parâmetro route. Ela recebe uma string que representa o nome da rota//
  void _navigateToRoute(String route) {
    if (route == routes[0]) {
      showNumberPopup(context, (int number) {
        Navigator.pushNamed(context, route, arguments: number.toString());
      });
    } else {
      Navigator.pushNamed(context, route, arguments: numeroArmazem);
    }
  }

  Future<void> showNumberPopup(
      BuildContext context, Function(int) onConfirm) async {
    String armazemNumber = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Digite o número do armazém desejado:'),
          content: TextField(
            keyboardType: TextInputType.number,
            maxLength: 2,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  armazemNumber = value;
                });
              } else {
                setState(() {
                  numeroArmazem = '';
                });
              }
            },
            decoration: InputDecoration(
              counterText: '',
              hintText: 'Número de 2 dígitos',
            ),
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm(int.parse(armazemNumber));
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text(
          'Gerenciamento',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: primaryColor,
          child: ListView(
            children: [
              Container(
                color: primaryColor,
                height: 95,
                child: DrawerHeader(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/img/ctic.png',
                        height: 95,
                        width: 95,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.black,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                contentPadding: paddinglisttitle,
                title: Row(
                  children: [
                    Expanded(
                        child: Text(
                      listTiles[0],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: listtilecolor,
                      ),
                    )),
                    const Icon(Icons.expand_more, color: iconlisttilecolor),
                  ],
                ),
                onTap: () {
                  setState(() {
                    showAdditionalTile = !showAdditionalTile;
                    showAdditionalTile3 = false;
                    showAdditionalTile4 = false;
                    showAdditionalTile5 = false;
                  });
                },
              ),
              if (showAdditionalTile)
                ListTile(
                  contentPadding: paddingadditionaltile,
                  title: const Row(
                    children: [
                      Icon(
                        Icons.inventory,
                        color: Colors.red,
                      ),
                      SizedBox(
                          width:
                              8), // Ajuste o valor do SizedBox para controlar o espaçamento
                      Text(
                        'Contagens',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: listtilecolor,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.expand_more,
                    color: iconlisttilecolor,
                  ),
                  onTap: () {
                    setState(() {
                      showAdditionalTile3 = !showAdditionalTile3;
                      showAdditionalTile4 = !showAdditionalTile4;
                      showAdditionalTile5 = !showAdditionalTile5;
                    });
                  },
                ),
              if (showAdditionalTile3)
                ListTile(
                  contentPadding: paddingadditionaltile3,
                  title: const Row(
                    children: [
                      CircleAvatar(
                        radius: 13.0,
                        backgroundColor: Colors.red,
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Color.fromARGB(255, 63, 70, 73),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Contagem',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: listtilecolor,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sendNumber(context, 1);
                  },
                ),
              if (showAdditionalTile4)
                ListTile(
                  contentPadding: paddingadditionaltile3,
                  title: const Row(
                    children: [
                      CircleAvatar(
                        radius: 13.0,
                        backgroundColor: Colors.red,
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Color.fromARGB(255, 63, 70, 73),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Contagem',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: listtilecolor,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sendNumber(context, 2);
                  },
                ),
              if (showAdditionalTile5)
                ListTile(
                  contentPadding: paddingadditionaltile3,
                  title: const Row(
                    children: [
                      CircleAvatar(
                        radius: 13.0,
                        backgroundColor: Colors.red,
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Color.fromARGB(255, 63, 70, 73),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Contagem',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: listtilecolor,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sendNumber(context, 3);
                  },
                ),
              ListTile(
                contentPadding: paddinglisttitle,
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        listTiles[1],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: listtilecolor,
                        ),
                      ),
                    ),
                    const Icon(Icons.expand_more, color: iconlisttilecolor),
                  ],
                ),
                onTap: () {
                  setState(() {
                    showAdditionalTile2 = !showAdditionalTile2;
                  });
                },
              ),
              if (showAdditionalTile2)
                ListTile(
                  contentPadding: paddingadditionaltile,
                  title: const Text(
                    'Under construction',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: listtilecolor,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.expand_more,
                    color: iconlisttilecolor,
                  ),
                  onTap: () {
                    // Lógica para tratar o novo item
                    //Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          final button = buttons[index];
          return GestureDetector(
            onTap: () => _navigateToRoute(button['route']),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
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
                      color: iconColor,
                      size: 55,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      button['text'],
                      style: buttonTextStyle.copyWith(
                        color: button['textColor'],
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
