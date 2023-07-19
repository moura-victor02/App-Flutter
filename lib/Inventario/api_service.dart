import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
//http://192.168.100.16:83/rest/SREST001

class ApiObject {
  final String code;
  final String description;
  final String amount;
  final String armazemNumber;

  ApiObject(
      {required this.code,
      required this.description,
      required this.amount,
      required this.armazemNumber});
}

class ApiService {
  final String apiUrl = 'http://localhost:3000/apiObjects';
  static const String failedHostLookupMessage = 'Falha na busca do host';

  Future<ApiObject> sendContagemData(String contagem, String endereco,
      String codigoProduto, String quantidade, String armazemNumber) async {
    try {
      final jsonData = jsonEncode({
        'Armazem': armazemNumber,
        'Contagem': contagem,
        'Endereco': endereco,
        'Codigo': codigoProduto,
        'Quantidade': quantidade
      });

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'basic ${base64.encode(utf8.encode('Enzo Victor:J#102424e'))}'
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        final responseObject = jsonDecode(response.body);
        return ApiObject(
          code: responseObject['code'],
          description: responseObject['description'],
          amount: responseObject['amount'],
          armazemNumber: armazemNumber,
        );
      } else {
        throw Exception('Erro ao enviar os dados do código de barras.');
      }
    } on SocketException catch (e) {
      throw Exception('Erro de socket: $e');
    } on HttpException catch (e) {
      throw Exception('Erro de HTTP: $e');
    } on FormatException catch (e) {
      throw Exception('Formato inválido: $e');
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }
}
