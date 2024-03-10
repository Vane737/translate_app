import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = 'http://192.168.0.12:3000/gpt'; // Corregido el formato de la URL

Future<String> translateText(String prompt, String lang) async {
  print('intentando conectar...');
  final url = Uri.parse('$baseUrl/translate');
  final body = jsonEncode({'prompt': prompt, 'lang': lang});

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['message'];
    } else {
      throw Exception('Failed to translate text: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Failed to connect to the server: $e');
  }
}