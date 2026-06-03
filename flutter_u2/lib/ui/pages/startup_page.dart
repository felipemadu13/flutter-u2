import 'package:flutter/material.dart';
import 'package:flutter_u2/data/services/auth_service.dart';
import 'package:flutter_u2/data/services/session_service.dart';
import 'package:flutter_u2/ui/pages/login_page.dart';
import 'package:flutter_u2/ui/pages/products_page.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  final AuthService _authService = AuthService();
  final SessionService _sessionService = SessionService();

  @override
  void initState() {
    super.initState();
    _authenticateSavedSession();
  }

  Future<void> _authenticateSavedSession() async {
    final credentials = await _sessionService.getCredentials();

    if (!mounted) return;

    if (credentials == null) {
      _goToLogin();
      return;
    }

    try {
      final token = await _authService.login(
        username: credentials.username,
        password: credentials.password,
      );

      await _sessionService.saveSession(
        username: credentials.username,
        password: credentials.password,
        token: token,
      );

      if (!mounted) return;

      _goToProducts();
    } catch (_) {
      await _sessionService.clearSession();

      if (!mounted) return;

      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  void _goToProducts() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const ProductsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
