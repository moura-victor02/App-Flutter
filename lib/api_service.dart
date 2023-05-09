import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiUrl = 'http://192.168.0.16:83/rest/SREST001';
  static const String failedHostLookupMessage = 'Failed host lookup';

  Future<void> sendContagemData(String contagem, String endereco,
      String codigoProduto, String quantidade) async {
    try {
      final jsonData = jsonEncode({
        'Contagem': contagem,
        'Endereco': endereco,
        'Codigo': codigoProduto,
        'Quantidade': quantidade
      });
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'basic ' +
              base64.encode(utf8.encode('Enzo Victor' + ':' + 'J#102424j'))
        },
        body: jsonData,
      );
      if (response.statusCode == 200) {
        print('Dados do código de barras enviados com sucesso.');
      } else {
        print('Erro ao enviar os dados do código de barras.');
      }
    } on SocketException catch (e) {
      print('Erro de socket: $e');
    } on HttpException catch (e) {
      print('Erro de HTTP: $e');
    } on FormatException catch (e) {
      print('Formato inválido: $e');
    } catch (e) {
      print('Erro inesperado: $e');
    }
  }
}
