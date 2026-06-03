import 'package:shared_preferences/shared_preferences.dart';

class SessionCredentials {
  const SessionCredentials({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class SessionService {
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';
  static const String _tokenKey = 'token';

  Future<void> saveSession({
    required String username,
    required String password,
    required String token,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_usernameKey, username);
    await preferences.setString(_passwordKey, password);
    await preferences.setString(_tokenKey, token);
  }

  Future<SessionCredentials?> getCredentials() async {
    final preferences = await SharedPreferences.getInstance();
    final username = preferences.getString(_usernameKey);
    final password = preferences.getString(_passwordKey);

    if (username == null || password == null) {
      return null;
    }

    if (username.isEmpty || password.isEmpty) {
      return null;
    }

    return SessionCredentials(
      username: username,
      password: password,
    );
  }

  Future<void> clearSession() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_usernameKey);
    await preferences.remove(_passwordKey);
    await preferences.remove(_tokenKey);
  }
}
