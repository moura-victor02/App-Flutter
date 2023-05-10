import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'api_service.dart';

/*classe que estende StatefulWidget, que representa a pagina de digitalização do codigo de barras.
  O campo apiService é uma instância da classe ApiService
  O campo cancelButtonText é uma string que é usada como o texto do botão Cancelar quando a digitalização é iniciada.
  */
class BarcodeScannerPage extends StatefulWidget {
  final int barcodeNumber;
  final ApiService apiService;
  final String cancelButtonText = 'Cancelar';
  BarcodeScannerPage({required this.apiService, required this.barcodeNumber});

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

//  Classe que possui propriedades para o endereço, código do produto e quantidade  //
class CodigoData {
  final String endereco;
  final String codigoProduto;
  final String quantidade;

  CodigoData(this.endereco, this.codigoProduto, this.quantidade);
}

/*Ele define quatro controladores de texto para os campos de entrada de contagem, endereço, código
 do produto e quantidade*/
class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final _barcodeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _codigoProdutoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  CodigoData _codigoData = CodigoData('', '', '');

  Future<void> scanBarcode() async {
    String barcodeData = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancelar',
      true,
      ScanMode.BARCODE,
    );
/*são extraídas as substrings que representam o endereço, o código do produto e a quantidade, respectivamente.
 O método substring é usado para extrair essas informações a partir da string barcodeData*/
    if (barcodeData != '-1') {
      String endereco = barcodeData.substring(0, 3);
      String codigoProduto = barcodeData.substring(3, 11);
      String quantidade = barcodeData.substring(11);

      setState(() {
        // instância da classe CodigoData, atualiza sempre que os dados do código de barras forem lidos//
        _codigoData = CodigoData(endereco, codigoProduto, quantidade);
        _enderecoController.text = endereco;
        _codigoProdutoController.text = codigoProduto;
        _quantidadeController.text = quantidade;
      });
    }
  }

/*método assíncrono que envia os dados da contagem para o sistema Protheus usando a API fornecida.
Inicia validando o formulário atual e, se for válido, ele extrai as informações relevantes das variáveis e 
as passa para a API para enviar.*/
  Future<void> sendDataToProtheus() async {
    if (_formKey.currentState!.validate()) {
      String contagem = _barcodeController.text;
      String endereco = _codigoData.endereco;
      String codigoProduto = _codigoData.codigoProduto;
      String quantidade = _codigoData.quantidade;

      await widget.apiService
          .sendContagemData(contagem, endereco, codigoProduto, quantidade);

      setState(() {
        _enderecoController.clear();
        _codigoProdutoController.clear();
        _quantidadeController.clear();
      });
    }
  }

/*Usado para inicializar o valor do _barcodeController com o número do código de barras recebido como
   parâmetro no construtor da classe BarcodeScannerPage*/
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
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ElevatedButton(
                      onPressed: scanBarcode,
                      child: Icon(Icons.qr_code, color: Colors.white, size: 48),
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ElevatedButton(
                      onPressed: sendDataToProtheus,
                      child: Icon(Icons.save, color: Colors.white, size: 48),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
