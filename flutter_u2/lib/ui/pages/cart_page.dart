import 'package:flutter/material.dart';
import 'package:flutter_u2/data/model/cart_item_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    required this.initialItems,
    required this.onCartUpdated,
  });

  final List<CartItem> initialItems;
  final ValueChanged<List<CartItem>> onCartUpdated;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final List<CartItem> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = widget.initialItems
        .map((item) => item.copyWith())
        .toList(growable: true);
  }

  String _formatCurrency(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  void _notifyCartChange() {
    widget.onCartUpdated(
      _cartItems.map((item) => item.copyWith()).toList(growable: false),
    );
  }

  void _increaseQuantity(CartItem item) {
    final index = _cartItems.indexWhere(
      (element) => element.product.id == item.product.id,
    );

    if (index == -1) return;

    setState(() {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );
    });

    _notifyCartChange();
  }

  void _decreaseQuantity(CartItem item) {
    final index = _cartItems.indexWhere(
      (element) => element.product.id == item.product.id,
    );

    if (index == -1) return;

    final nextQuantity = _cartItems[index].quantity - 1;

    setState(() {
      if (nextQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: nextQuantity);
      }
    });

    _notifyCartChange();
  }

  void _removeItem(CartItem item) {
    setState(() {
      _cartItems.removeWhere(
        (element) => element.product.id == item.product.id,
      );
    });

    _notifyCartChange();
  }

  void _confirmPurchase() {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Seu carrinho está vazio.')),
      );
      return;
    }

    setState(() {
      _cartItems.clear();
    });

    _notifyCartChange();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Compra concluída')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = _cartItems.fold<double>(
      0,
      (sum, item) => sum + item.subtotal,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Carrinho'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child:
                  _cartItems.isEmpty
                      ? const Center(
                        child: Text('Nenhum produto adicionado ao carrinho.'),
                      )
                      : ListView.separated(
                        itemCount: _cartItems.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = _cartItems[index];

                          return Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item.product.imageUrl,
                                      width: 72,
                                      height: 72,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Image.asset(
                                          'lib/assets/images/placeholder.png',
                                          width: 72,
                                          height: 72,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          item.product.formattedPrice,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              tooltip: 'Diminuir quantidade',
                                              onPressed:
                                                  () => _decreaseQuantity(item),
                                              icon: const Icon(
                                                Icons.remove_circle_outline,
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${item.quantity}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              tooltip: 'Aumentar quantidade',
                                              onPressed:
                                                  () => _increaseQuantity(item),
                                              icon: const Icon(
                                                Icons.add_circle_outline,
                                              ),
                                            ),
                                            const Spacer(),
                                            TextButton.icon(
                                              onPressed: () => _removeItem(item),
                                              icon: const Icon(
                                                Icons.delete_outline,
                                              ),
                                              label: const Text('Remover'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
            const SizedBox(height: 12),
            Text(
              'Total: ${_formatCurrency(total)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 46,
              child: ElevatedButton(
                onPressed: _confirmPurchase,
                child: const Text('Confirmar Compra'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
