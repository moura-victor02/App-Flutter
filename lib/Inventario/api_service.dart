import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
//http://192.168.100.16:83/rest/SREST001

class ApiObject {
  final String code;
  final String description;
  final String amount;
  final String armazemNumber;

  ApiObject({
    required this.code,
    required this.description,
    required this.amount,
    required this.armazemNumber,
  });

  factory ApiObject.fromJson(Map<String, dynamic> json) {
    return ApiObject(
      code: json['Codigo'], // Verifique se as chaves do JSON estão corretas
      description:
          json['Descricao'], // Verifique se as chaves do JSON estão corretas
      amount: json['Valor'], // Verifique se as chaves do JSON estão corretas
      armazemNumber:
          json['Armazem'], // Verifique se as chaves do JSON estão corretas
    );
  }
}

class ApiService {
  final String apiUrl = 'http://localhost:3000/apiObjects';
  static const String failedHostLookupMessage = 'Falha na busca do host';

  Future<ApiObject> sendContagemData(
    String contagem,
    String endereco,
    String codigoProduto,
    String quantidade,
    String armazemNumber,
  ) async {
    try {
      final jsonData = jsonEncode({
        'Armazem': armazemNumber,
        'Contagem': contagem,
        'Endereco': endereco,
        'Codigo': codigoProduto,
        'Quantidade': quantidade,
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
        final jsonData = responseObject is String
            ? jsonDecode(responseObject)
            : responseObject;
        return ApiObject.fromJson(jsonData);
      } else {
        throw Exception('Erro ao enviar os dados do código de barras.');
      }
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }
}
