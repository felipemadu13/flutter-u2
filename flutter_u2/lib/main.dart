import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      ),
      home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text('Minha aplicação'),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'usuário',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'senha',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {}, child: const Text('Login')
            ),
            Text( 'Esqueceu a senha?'),
            Text('Não tem uma conta? Cadastre-se'),
          ],
        ),
      ),
     )
    );
  }
}


