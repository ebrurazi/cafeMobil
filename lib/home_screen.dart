import 'package:flutter/material.dart';
import 'campaign_screen.dart'; // Kampanya detay ekranı için import
import 'desserts_screen.dart'; // Tatlılar ekranı için import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kafe Uygulaması'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Sepet sayfasına yönlendirme
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Hoş Geldiniz, [Kullanıcı Adı]!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Arama Çubuğu
            TextField(
              decoration: InputDecoration(
                hintText: 'Ürün veya kategori ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
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
                categoryIcon(context, Icons.cake, 'Tatlılar'), // Tatlılar sayfası
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
            Column(
              children: [
                productCard('Latte', 'assets/images/special.jpg', 40, 4.7),
                productCard('İce Latte', 'assets/images/special2.jpg', 45, 4.9),
              ],
            ),
          ],
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

  Widget campaignCard(
      BuildContext context, String title, String imagePath, String description) {
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
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
              builder: (context) => const DessertsScreen(), // Tatlılar ekranına yönlendirme
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

  Widget productCard(String name, String imagePath, double price, double rating) {
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
        trailing: const Icon(Icons.add_shopping_cart),
        onTap: () {
          // Ürün detay sayfasına yönlendirme
        },
      ),
    );
  }
}
