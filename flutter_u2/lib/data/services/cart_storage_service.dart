import 'dart:convert';

import 'package:flutter_u2/data/model/cart_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartStorageService {
  String _cartKey(String userId) => 'cart_$userId';

  Future<List<CartItem>> loadCart(String userId) async {
    final preferences = await SharedPreferences.getInstance();
    final encodedItems = preferences.getString(_cartKey(userId));

    if (encodedItems == null || encodedItems.isEmpty) {
      return [];
    }

    final decodedItems = jsonDecode(encodedItems) as List<dynamic>;

    return decodedItems
        .map(
          (item) => CartItem.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList(growable: false);
  }

  Future<void> saveCart(String userId, List<CartItem> items) async {
    final preferences = await SharedPreferences.getInstance();

    final encodedItems = jsonEncode(
      items.map((item) => item.toJson()).toList(growable: false),
    );

    await preferences.setString(_cartKey(userId), encodedItems);
  }

  Future<void> clearCart(String userId) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_cartKey(userId));
  }
}
