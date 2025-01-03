import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = []; // Sepetteki ürünler

  List<Map<String, dynamic>> get cartItems => _cartItems; // Sepet ürünleri

  int get cartItemCount => _cartItems.length; // Sepetteki toplam ürün sayısı

  // Sepete ürün ekleme
  void addToCart(Map<String, dynamic> product) {
    print('Ürün Ekleniyor: $product');

    if (product['id'] == null || product['name'] == null || product['price'] == null) {
      throw Exception('Ürün bilgileri eksik!');
    }

    if (!_cartItems.any((item) => item['id'] == product['id'])) {
      _cartItems.add(product);
      _addProductToFirestore(product); // Firestore'a ekleme
      notifyListeners();
    }
  }

  // Sepetten ürün çıkarma
  void removeFromCart(String id) {
    _cartItems.removeWhere((item) => item['id'] == id);
    _deleteProductFromFirestore(id); // Firestore'dan silme
    notifyListeners();
  }

  Future<void> _addProductToFirestore(Map<String, dynamic> product) async {
    await FirebaseFirestore.instance.collection('cart').add(product);
  }

  Future<void> _deleteProductFromFirestore(String id) async {
    var collection = FirebaseFirestore.instance.collection('cart');
    var snapshot = await collection.where('id', isEqualTo: id).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}