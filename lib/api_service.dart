import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://api.example.com";

  // Ürünleri Listele
  Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Ürünler alınamadı');
    }
  }

  // Yeni Ürün Ekle
  Future<void> addProduct(Map<String, dynamic> product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product),
    );
    if (response.statusCode != 201) {
      throw Exception('Ürün eklenemedi');
    }
  }

  // Ürünü Güncelle
  Future<void> updateProduct(String id, Map<String, dynamic> product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product),
    );
    if (response.statusCode != 200) {
      throw Exception('Ürün güncellenemedi');
    }
  }

  // Ürün Sil
  Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode != 200) {
      throw Exception('Ürün silinemedi');
    }
  }
}
