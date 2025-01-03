import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CartProvider.dart';

class DessertsScreen extends StatelessWidget {
  const DessertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tatlılar'),
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
                  'Tatlı Menüsü',
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
                dessertCard(context, '1', 'Cheesecake', 'assets/images/special.jpg', 30),
                dessertCard(context, '2', 'Tiramisu', 'assets/images/special2.jpg', 35),
                dessertCard(context, '3', 'Çikolatalı Pasta', 'assets/images/special.jpg', 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dessertCard(BuildContext context, String id, String name, String imagePath, double price) {
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