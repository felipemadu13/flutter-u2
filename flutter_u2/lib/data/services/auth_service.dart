import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<String> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Usuário ou senha inválidos.');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final token = data['accessToken'] ?? data['token'];

    if (token == null || token.toString().isEmpty) {
      throw Exception('Token inválido.');
    }

    return token.toString();
  }
}
