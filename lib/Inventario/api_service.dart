import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
//http://192.168.100.16:83/rest/SREST001

class ApiObject {
  final String code;
  String description;
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
      code: json['Codigo'] ??
          '', // Provide a default value if the key is not present
      description: json['Descricao'] ??
          '', // Provide a default value if the key is not present
      amount: json['Quantidade']?.toString() ??
          '', // Provide a default value if the key is not present
      armazemNumber: json['Armazem'] ??
          '', // Provide a default value if the key is not present
    );
  }
}

class ApiService {
  final String apiUrl = 'http://192.168.100.16:83/rest/SREST001';

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

        // Create an ApiObject with the response data, providing default values for missing keys
        ApiObject apiObject = ApiObject.fromJson({
          'Codigo': responseObject['Codigo'] ?? '',
          'Descricao': responseObject['Descricao'] ?? '',
          'Quantidade': responseObject['Quantidade']?.toString() ?? '',
          'Armazem': responseObject['Armazem'] ?? '',
        });

        return apiObject;
      } else {
        throw Exception('Erro ao enviar os dados do código de barras.');
      }
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }
}
