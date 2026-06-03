import 'dart:convert';
import 'package:flutter_u2/data/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/products'),
    );

    if (response.statusCode != 200) {
      throw Exception('Não foi possível carregar os produtos.');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final products = data['products'] as List<dynamic>;

    return products
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
