import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://exemplo.com/api/endpoint';

  static const String failedHostLookupMessage = 'Falha na consulta de host';
  static const String apiNotFoundMessage = 'API endpoint não encontrado';

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
    } on HttpException catch (_) {
      print(apiNotFoundMessage);
    }
  }
}
