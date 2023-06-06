import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
//http://192.168.0.16:83/rest/SREST001

class ApiObject {
  final String code;
  final String description;
  final String amount;

  ApiObject({
    required this.code,
    required this.description,
    required this.amount,
  });
}

class ApiObject2 {
  final String code;
  final String description;
  final String amount;

  ApiObject2({
    required this.code,
    required this.description,
    required this.amount,
  });
}

class ApiService {
  final String apiUrl = 'http://localhost:3000/apiObjects';
  static const String failedHostLookupMessage = 'Falha na busca do host';

  Future<ApiObject2> sendContagemData(
    String contagem,
    String endereco,
    String codigoProduto,
    String quantidade,
  ) async {
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
        final responseObject = jsonDecode(response.body);
        return ApiObject2(
          code: responseObject['code'],
          description: responseObject['description'],
          amount: responseObject['amount'],
        ); // Chama a função getLastValue
      } else {
        print('Erro ao enviar os dados do código de barras.');
        throw Exception('Erro ao enviar os dados do código de barras.');
      }
    } on SocketException catch (e) {
      print('Erro de socket: $e');
      throw Exception('Erro de socket: $e');
    } on HttpException catch (e) {
      print('Erro de HTTP: $e');
      throw Exception('Erro de HTTP: $e');
    } on FormatException catch (e) {
      print('Formato inválido: $e');
      throw Exception('Formato inválido: $e');
    } catch (e) {
      print('Erro inesperado: $e');
      throw Exception('Erro inesperado: $e');
    }
  }

  Future<ApiObject> _getLastValue() async {
    final baseUrl = 'http://localhost:3000';
    final response = await http.get(Uri.parse('$baseUrl/apiObjects/lastValue'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final code = jsonResponse['code'] ?? '';
      final description = jsonResponse['description'] ?? '';
      final amount = jsonResponse['amount']?.toString() ?? '0';

      return ApiObject(
        code: code,
        description: description,
        amount: amount,
      );
    } else {
      throw Exception('Falha ao obter o último valor');
    }
  }
}
