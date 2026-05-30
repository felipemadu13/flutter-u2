class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  String get formattedPrice {
    return 'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as num).toInt(),
      name: json['title']?.toString() ?? 'Produto sem nome',
      description: json['description']?.toString() ?? 'Sem descrição',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['thumbnail']?.toString() ?? '',
    );
  }
}
