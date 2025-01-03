import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobil_cafe/CartProvider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart'; // Firebase yapılandırmasını import edin
import 'login_screen.dart'; // Giriş ekranı
import 'register_screen.dart'; // Kayıt ekranı
import 'home_screen.dart'; // Ana ekran

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase başlatma
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBMBQ1QRHtjB0SsiMtIWVADX0QRLVkGrBE",
        authDomain: "mobil-cafe.firebaseapp.com",
        projectId: "mobil-cafe",
        storageBucket: "mobil-cafe.firebasestorage.app",
        messagingSenderId: "1028669845029",
        appId: "1:1028669845029:web:f2c3391177e2ea830e59cc",
        measurementId: "G-YZDFP5W7JD",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Mobil platformlar için yapılandırma
    );
  }

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), // Sepet sağlayıcı
      ],
      child: MaterialApp(
        title: 'Cafe Mobil',
        initialRoute: '/', // İlk gösterilecek ekran
        routes: {
          '/': (context) => const LoginScreen(), // Giriş ekranı
          '/register': (context) => const RegisterScreen(), // Kayıt ekranı
          '/home': (context) => const HomeScreen(), // Ana ekran
        },
      ),
    );
  }
}