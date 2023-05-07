import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'api_service.dart';

class BarcodeScannerPage extends StatefulWidget {
  final int barcodeNumber;
  final ApiService apiService;
  final String cancelButtonText = 'Cancelar';
  BarcodeScannerPage({required this.apiService, required this.barcodeNumber});

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final _barcodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<String> scanBarcode() async => await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancelar',
        true,
        ScanMode.BARCODE,
      );

  Future<void> sendDataToProtheus(String barcodeData) async {
    await widget.apiService.sendBarcodeData(barcodeData);
  }

  @override
  void initState() {
    super.initState();
    _barcodeController.text = widget.barcodeNumber.toString();
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leitor de código de barras'),
        centerTitle: true,
        leading: Icon(Icons.bar_chart),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _barcodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Digite o código ou utilize o botão de leitura',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, digite o código de barras';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await sendDataToProtheus(_barcodeController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Dados enviados para o Protheus com sucesso!'),
                      ),
                    );
                    _barcodeController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.save,
                      size: 36,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Salvar',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    String barcodeData = await scanBarcode();
                    if (barcodeData != '-1') {
                      setState(() {
                        _barcodeController.text = barcodeData;
                      });
                    } else {
                      setState(() {
                        _barcodeController.clear();
                      });
                    }
                  },
                  icon: Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Ler código de barras',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
