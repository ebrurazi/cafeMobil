import 'package:flutter/material.dart';
import 'package:mobil_cafe/CartProvider.dart';
import 'package:mobil_cafe/CartScreen.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore için import

import 'campaign_screen.dart'; // Kampanya detay ekranı için import
import 'desserts_screen.dart'; // Tatlılar ekranı için import
import 'coffees_screen.dart'; // Kahveler ekranı için import
import 'snacks_screen.dart'; // Atıştırmalıklar ekranı için import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allProducts = [
    {'id': '1', 'name': 'Latte', 'price': 40.0, 'image': 'assets/images/special.jpg'},
    {'id': '2', 'name': 'İce Latte', 'price': 45.0, 'image': 'assets/images/special2.jpg'},
    {'id': '3', 'name': 'Cheesecake', 'price': 30.0, 'image': 'assets/images/special.jpg'},
    {'id': '4', 'name': 'Tiramisu', 'price': 35.0, 'image': 'assets/images/special2.jpg'},
    {'id': '5', 'name': 'Çikolatalı Pasta', 'price': 40.0, 'image': 'assets/images/special.jpg'},
    {'id': '6', 'name': 'Espresso', 'price': 20.0, 'image': 'assets/images/special.jpg'},
    {'id': '7', 'name': 'Americano', 'price': 25.0, 'image': 'assets/images/special2.jpg'},
    {'id': '8', 'name': 'Patates Kızartması', 'price': 15.0, 'image': 'assets/images/special.jpg'},
    {'id': '9', 'name': 'Soğan Halkası', 'price': 20.0, 'image': 'assets/images/special2.jpg'},
    {'id': '10', 'name': 'Mozzarella Sticks', 'price': 25.0, 'image': 'assets/images/special.jpg'},
  ];
  List<Map<String, dynamic>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
    _addAllProductsToFirestore(); // Ürünleri Firestore'a eklemek için fonksiyonu çağırıyoruz
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredProducts = _allProducts;
      });
    } else {
      setState(() {
        _filteredProducts = _allProducts
            .where((product) => product['name'].toLowerCase().startsWith(query.toLowerCase()))
            .toList();
      });
    }
  }

  void _navigateToProduct(BuildContext context, String id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ürün ID: $id')),
    );
  }

  Future<void> _addAllProductsToFirestore() async {
    for (var product in _allProducts) {
      await FirebaseFirestore.instance.collection('products').add(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kafe Uygulaması'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  if (cartProvider.cartItemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cartProvider.cartItemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hoş Geldiniz!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Arama Çubuğu
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Ürün veya kategori ara...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: _filterProducts,
              ),
              const SizedBox(height: 20),

              // Arama Sonuçları
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Image.asset(product['image'], width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(product['name']),
                      subtitle: Text('₺${product['price']}'),
                      onTap: () => _navigateToProduct(context, product['id']),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false).addToCart({
                            'id': product['id'],
                            'name': product['name'],
                            'price': product['price'],
                            'image': product['image'],
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Kampanyalar ve Duyurular
              const Text(
                'Kampanyalar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    campaignCard(
                      context,
                      'Kampanya 1',
                      'assets/images/latte.jpg',
                      'Tüm ürünlerde %20 indirim! Sadece bu haftaya özel.',
                    ),
                    campaignCard(
                      context,
                      'Kampanya 2',
                      'assets/images/cappucino.jpg',
                      '2 al 1 öde fırsatı! Tatlılar ve kahvelerde geçerli.',
                    ),
                    campaignCard(
                      context,
                      'Kampanya 3',
                      'assets/images/latte.jpg',
                      'Günün kahvesi sadece ₺30! Lezzetli bir mola.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Menü Kategorileri
              const Text(
                'Kategoriler',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  categoryIcon(context, Icons.local_cafe, 'Kahveler'),
                  categoryIcon(context, Icons.cake, 'Tatlılar'),
                  categoryIcon(context, Icons.fastfood, 'Atıştırmalıklar'),
                ],
              ),
              const SizedBox(height: 20),

              // Öne Çıkan Ürünler
              const Text(
                'Öne Çıkan Ürünler',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return Column(
                    children: [
                      productCard(cartProvider, '1', 'Latte', 'assets/images/special.jpg', 40, 4.7),
                      productCard(cartProvider, '2', 'İce Latte', 'assets/images/special2.jpg', 45, 4.9),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menü',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Siparişlerim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Sayfa geçiş işlemleri
        },
      ),
    );
  }

  Widget campaignCard(BuildContext context, String title, String imagePath, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CampaignDetailScreen(
              title: title,
              imagePath: imagePath,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryIcon(BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        if (label == 'Tatlılar') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DessertsScreen(),
            ),
          );
        } else if (label == 'Kahveler') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CoffeesScreen(),
            ),
          );
        } else if (label == 'Atıştırmalıklar') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SnacksScreen(),
            ),
          );
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.brown[200],
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }

  Widget productCard(CartProvider cartProvider, String id, String name, String imagePath, double price, double rating) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(name),
        subtitle: Row(
          children: [
            Text('₺$price', style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 10),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text('$rating', style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () {
            cartProvider.addToCart({'id': id, 'name': name, 'price': price, 'image': imagePath, 'rating': rating});
          },
        ),
      ),
    );
  }
}