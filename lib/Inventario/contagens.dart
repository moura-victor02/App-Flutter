import 'package:flutter/material.dart';
import 'package:app01/Inventario/page_scanner.dart';
import 'api_service.dart';

class Contagem extends StatefulWidget {
  @override
  _ContagemState createState() => _ContagemState();
}

class _ContagemState extends State<Contagem> {
  void sendNumber(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeScannerPage(
          barcodeNumber: index + 1, // número do botão clicado (1, 2 ou 3)
          apiService: ApiService(),
        ),
      ),
    );
  }

  final _apiService = ApiService();
  final List<Map<String, dynamic>> buttons = [
    {
      'text': 'Contagem 1',
      'icon': Icons.inventory,
      'color': Colors.blue,
      'textColor': Colors.white,
    },
    {
      'text': 'Contagem 2',
      'icon': Icons.inventory,
      'color': Colors.blue,
      'textColor': Colors.white,
    },
    {
      'text': 'Contagem 3',
      'icon': Icons.inventory,
      'color': Colors.blue,
      'textColor': Colors.white,
    },
  ];

  Future<void> sendDataToProtheus(String contagem, String endereco,
      String codigoProduto, String quantidade) async {
    await _apiService.sendContagemData(
        contagem, endereco, codigoProduto, quantidade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contagem'),
        centerTitle: true,
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  'Escolha a contagem desejada:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'Montserrat',
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      sendNumber(context, index);
                    },
                    child: Container(
                      height: 80,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: buttons[index]['color'],
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            buttons[index]['icon'],
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(width: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                buttons[index]['text'],
                                style: TextStyle(
                                  color: buttons[index]['textColor'],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  fontFamily: 'Montserrat',
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
