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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromStorageJson(Map<String, dynamic> json) {
    final imageUrl = json['imageUrl']?.toString();

    return Product(
      id: (json['id'] as num).toInt(),
      name: json['name']?.toString() ?? 'Produto sem nome',
      description: json['description']?.toString() ?? 'Sem descrição',
      price: (json['price'] as num).toDouble(),
      imageUrl:
          imageUrl == null || imageUrl.trim().isEmpty
              ? 'lib/assets/images/placeholder.png'
              : imageUrl,
    );
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
