import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginResult {
  const LoginResult({
    required this.token,
    required this.userId,
  });

  final String token;
  final String userId;
}

class AuthService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<LoginResult> login({
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

    final userId = data['id']?.toString().trim();

    return LoginResult(
      token: token.toString(),
      userId: userId == null || userId.isEmpty ? username : userId,
    );
  }
}
