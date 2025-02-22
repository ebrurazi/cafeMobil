import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CartProvider.dart';

class SnacksScreen extends StatelessWidget {
  const SnacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atıştırmalıklar'),
      ),
      body: Stack(
        children: [
          // Arka Plan Fotoğrafı
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg2.jpg'), // Arka plan fotoğrafı
                fit: BoxFit.cover,
              ),
            ),
          ),
          // İçerik
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Text(
                  'Atıştırmalık Menüsü',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Yazının daha okunabilir olması için beyaz
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                snackCard(context, '1', 'Patates Kızartması', 'assets/images/special.jpg', 30),
                snackCard(context, '2', 'Soğan Halkası', 'assets/images/special2.jpg', 35),
                snackCard(context, '3', 'Mozzarella Sticks', 'assets/images/special.jpg', 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget snackCard(BuildContext context, String id, String name, String imagePath, double price) {
    return Card(
      color: Colors.white.withOpacity(0.8), // Kartın hafif şeffaf olması için
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(name),
        subtitle: Text('₺$price'),
        trailing: const Icon(Icons.add_shopping_cart),
        onTap: () {
          Provider.of<CartProvider>(context, listen: false).addToCart({'id': id, 'name': name, 'price': price});
        },
      ),
    );
  }
}