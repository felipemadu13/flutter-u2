import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.name,
    required this.description,
    required this.price,
    this.image,
  });

  final String name;
  final String description;
  final String price;
  final ImageProvider? image;
}