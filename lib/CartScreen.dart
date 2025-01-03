import 'package:flutter/material.dart';
import 'package:mobil_cafe/CartProvider.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepetim'),
      ),
      body: cartProvider.cartItems.isEmpty
          ? const Center(
              child: Text(
                'Sepetiniz boş',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return ListTile(
                  title: Text(item['name'] ?? 'Bilinmeyen Ürün'),
                  subtitle: Text('₺${item['price'] ?? 0}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      if (item['id'] != null) {
                        cartProvider.removeFromCart(item['id']);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ürün ID eksik!')),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
