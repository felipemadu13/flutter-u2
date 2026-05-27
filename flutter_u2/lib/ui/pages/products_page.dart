import 'package:flutter/material.dart';
import 'package:flutter_u2/ui/pages/login_page.dart';
import 'package:flutter_u2/ui/widgets/product_card.dart';
import 'package:flutter_u2/data/product_model.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const products = <Product>[
      Product(
        name: 'Notebook Gamer Acer',
        description: 'Processador rápido e tela de alta taxa de atualização.',
        price: 'R\$ 5.999,00',
        image: AssetImage('lib/assets/images/notebook.png'),
      ),
      Product(
        name: 'Smartphone',
        description: 'Câmera avançada, bateria duradoura e design premium.',
        price: 'R\$ 3.199,00',
        image: AssetImage('lib/assets/images/smartphone.png'),
      ),
      Product(
        name: 'Fone Bluetooth',
        description: 'Áudio imersivo com cancelamento de ruído.',
        price: 'R\$ 499,00',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text('Loja Online'),
        actions: [
          const Icon(Icons.shopping_cart),
          IconButton(
            tooltip: 'Sair',
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (_) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 260,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.52,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}
