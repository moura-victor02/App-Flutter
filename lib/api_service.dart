import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';

class ApiService {
  final String apiUrl = 'http://www.example.com/d%C3%A9monstration.html';
  static const String failedHostLookupMessage = 'Failed host lookup';

  Future<void> sendBarcodeData(String barcodeData) async {
    try {
      final jsonData = jsonEncode({'barcode': barcodeData});
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );
      if (response.statusCode == 200) {
        print('Dados do código de barras enviados com sucesso.');
      } else {
        print('Erro ao enviar os dados do código de barras.');
      }
    } on SocketException catch (_) {
      print(failedHostLookupMessage);
    }
  }
}
