// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'api_service.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'contagens.dart';

import 'api_service.dart';
/*classe que estende StatefulWidget, que representa a pagina de digitalização do codigo de barras.
  O campo apiService é uma instância da classe ApiService
  O campo cancelButtonText é uma string que é usada como o texto do botão Cancelar quando a digitalização é iniciada.
  */

class barcodeScannerPage extends StatefulWidget {
  final ApiObject apiObject;
  final int barcodeNumber;
  final ApiService apiService;

  final String cancelButtonText = 'Cancelar';

  barcodeScannerPage({
    Key? key,
    required this.apiService,
    required this.barcodeNumber,
    required this.apiObject,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _barcodeScannerPageState createState() => _barcodeScannerPageState();
}

class CodigoData {
  final String endereco;
  final String codigoProduto;
  final String quantidade;

  CodigoData(this.endereco, this.codigoProduto, this.quantidade);
}

class _barcodeScannerPageState extends State<barcodeScannerPage> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _codeController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _codigoProdutoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final player = AudioPlayer();

  CodigoData _codigoData = CodigoData('', '', '');

  @override
  void initState() {
    super.initState();
    _barcodeController.text = widget.barcodeNumber.toString();
    _enderecoController.addListener(updateCodigoData);
    _codigoProdutoController.addListener(updateCodigoData);
    _quantidadeController.addListener(updateCodigoData);
    _codeController.text = widget.apiObject.code;
    _descriptionController.text = widget.apiObject.description;
    _amountController.text = widget.apiObject.amount;
  }

  void updateCodigoData() {
    setState(() {
      _codigoData = CodigoData(
        _enderecoController.text,
        _codigoProdutoController.text,
        _quantidadeController.text,
      );
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _codeController.dispose();
    _barcodeController.dispose();
    _enderecoController.dispose();
    _codigoProdutoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

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
      player.setAsset('assets/audios/beep.wav');
      player.play();
      String endereco = barcodeData.substring(0, 3);
      String codigoProduto = barcodeData.substring(3, 11);
      String quantidade = barcodeData.substring(11);

      setState(() {
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

      try {
        // Call the sendContagemData method and wait for the response
        ApiObject updatedApiObject = await widget.apiService.sendContagemData(
          contagem,
          endereco,
          codigoProduto,
          quantidade,
          widget.apiObject.armazemNumber,
        );

        // Update the UI with the received data
        setState(() {
          _amountController.clear();
          _descriptionController.clear();
          _codeController.clear();
          _enderecoController.clear();
          _codigoProdutoController.clear();
          _quantidadeController.clear();

          _codeController.text = updatedApiObject.code ?? '';
          _amountController.text = updatedApiObject.amount ?? '';
          _descriptionController.text = updatedApiObject.description ?? '';
        });
      } catch (e) {
        // Handle exceptions if needed
        print('Error: $e');
      }
    }
  }

/*Usado para inicializar o valor do _barcodeController com o número do código de barras recebido como
   parâmetro no construtor da classe BarcodeScannerPage*/
  Widget _buildInfoContainer(String text, Color textColor) {
    return Container(
        height: 55,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 15.0,
            ),
          ),
        ));
  }

  String _getDescriptionText() {
    final description = _descriptionController.text;
    return description.length <= 22
        ? description
        : description.substring(0, 22);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 45, 57, 63),
        centerTitle: true,
        title: Container(
          child: CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.red,
            child: Text(
              _barcodeController.text,
              style: TextStyle(
                color: Color.fromARGB(255, 63, 70, 73),
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Último produto enviado:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 63, 70, 73),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Codigo:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          SizedBox(width: 7.8),
                          Expanded(
                            child: Text(
                              'Descrição:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          SizedBox(width: 7.8),
                          Expanded(
                            child: Text(
                              'Quantidade:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 63, 70, 73),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildInfoContainer(
                                _codeController.text,
                                Colors.red,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: _buildInfoContainer(
                                _getDescriptionText(),
                                Colors.red,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: _buildInfoContainer(
                                _amountController.text,
                                Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 33),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 63, 70, 73),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Realize a leitura:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 28),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _enderecoController,
                      decoration: InputDecoration(
                        labelText: 'Endereço',
                        border: OutlineInputBorder(),
                        counterText: '',
                      ),
                      maxLength: 3,
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
                        counterText: '',
                      ),
                      maxLength: 8,
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
                ],
              ),
            ),
            SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 86,
                  height: 86,
                  child: ElevatedButton(
                    onPressed: scanBarcode,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 63, 70, 73),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 4.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 0.0,
                          ),
                          child:
                              Icon(Icons.qr_code, color: Colors.red, size: 53),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 0.0,
                            ),
                            child: Center(
                              child: Text(
                                'Leitura',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 86,
                  height: 86,
                  child: ElevatedButton(
                    onPressed: sendDataToProtheus,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 63, 70, 73),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 4.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: Icon(Icons.arrow_upward,
                              color: Colors.red, size: 53),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 0.0,
                            ),
                            child: Center(
                              child: Text(
                                'Salvar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
