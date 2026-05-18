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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text('Minha aplicação', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 30.0),
            
            TextFormField(
              decoration: InputDecoration(
                label: Row(
                  children: [
                    Icon(Icons.person, color: Colors.grey),
                    SizedBox(width: 5),
                    Text('Usuário'),
                  ],
                ),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                                label: Row(
                  children: [
                    Icon(Icons.lock, color: Colors.grey),
                    SizedBox(width: 5),
                    Text('Senha'),
                  ],
                ),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 167, 22, 53),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // borda arredondada
                ),
              ),
              onPressed: () {}, child: const Text('Login')
            ),
            SizedBox(height: 20.0),
            Text( 'Esqueceu a senha?', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 5.0),
            Text('Não tem uma conta? Cadastre-se', style: TextStyle(color: Colors.grey)),
          ],
        ),


        ),
        
      ),
     )
    );
  }
}


