import 'package:flutter/material.dart';
import 'package:app01/Inventario/page_scanner.dart';
import 'Inventario/api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class CustomListTile {
  final String title;
  final Function onTap;

  CustomListTile({required this.title, required this.onTap});
}

void sendNumber(BuildContext context, int buttonNumber) {
  String code = '';
  String description = '';
  String amount = '';

  int barcodeNumber = buttonNumber;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BarcodeScannerPage(
        barcodeNumber: barcodeNumber,
        apiService: ApiService(),
        apiObject:
            ApiObject(code: code, description: description, amount: amount),
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
    'Under construction-2',
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
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      'route': routes[0],
    },
    {
      'text': 'under construction1',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[1],
    },
    {
      'text': 'under construction2',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[2],
    },
    {
      'text': 'under construction3',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[3],
    },
    {
      'text': 'under construction4',
      'icon': Icons.help_outline,
      'color': Color.fromARGB(255, 63, 70, 73),
      'textColor': Colors.white,
      //'route': routes[4],
    },
    {
      'text': 'under construction5',
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
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
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
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/img/ctic.png',
                        height: 95,
                        width: 95,
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.close),
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: listtilecolor,
                      ),
                    )),
                    Icon(Icons.expand_more, color: iconlisttilecolor),
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
                  title: Row(
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
                  trailing: Icon(
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
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.red,
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Color.fromARGB(255, 63, 70, 73),
                            fontSize: 15.0,
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
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.red,
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Color.fromARGB(255, 63, 70, 73),
                            fontSize: 15.0,
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
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.red,
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Color.fromARGB(255, 63, 70, 73),
                            fontSize: 15.0,
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: listtilecolor,
                        ),
                      ),
                    ),
                    Icon(Icons.expand_more, color: iconlisttilecolor),
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
                  title: Text(
                    'Under construction',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: listtilecolor,
                    ),
                  ),
                  trailing: Icon(
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
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: EdgeInsets.all(10),
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
                    SizedBox(height: 15),
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
