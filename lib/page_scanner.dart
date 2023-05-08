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
  final _enderecoController = TextEditingController();
  final _codigoProdutoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> scanBarcode() async {
    String barcodeData = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancelar',
      true,
      ScanMode.BARCODE,
    );

    if (barcodeData != '-1') {
      String endereco = barcodeData.substring(0, 3);
      String codigoProduto = barcodeData.substring(3, 11);
      String quantidade = barcodeData.substring(11);

      setState(() {
        _enderecoController.text = endereco;
        _codigoProdutoController.text = codigoProduto;
        _quantidadeController.text = quantidade;
      });
    }
  }

  Future<void> sendDataToProtheus() async {
    if (_formKey.currentState!.validate()) {
      String contagem = _barcodeController.text;
      String endereco = _enderecoController.text;
      String codigoProduto = _codigoProdutoController.text;
      String quantidade = _quantidadeController.text;

      await widget.apiService
          .sendContagemData(contagem, endereco, codigoProduto, quantidade);

      setState(() {
        _enderecoController.clear();
        _codigoProdutoController.clear();
        _quantidadeController.clear();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _barcodeController.text = widget.barcodeNumber.toString();
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _enderecoController.dispose();
    _codigoProdutoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envio de Leituras'),
        centerTitle: true,
        leading: Icon(Icons.bar_chart),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.blue,
                child: Text(
                  _barcodeController.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _enderecoController,
                  decoration: InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o endereço';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _codigoProdutoController,
                  decoration: InputDecoration(
                    labelText: 'Código do Produto',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o código do produto';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _quantidadeController,
                  decoration: InputDecoration(
                    labelText: 'Quantidade',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a quantidade';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: scanBarcode,
                child: Text('Ler código de barras'),
              ),
              ElevatedButton(
                onPressed: sendDataToProtheus,
                child: Text('Enviar dados para Protheus'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
