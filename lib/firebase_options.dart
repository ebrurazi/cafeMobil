    
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
    static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA_4Noy7d18u_qPH4ygEJpS9vp0R_SYe40',
    authDomain: 'mobil-cafe.firebaseapp.com',
    projectId: 'mobil-cafe',
    storageBucket: 'mobil-cafe.firebasestorage.app',
    messagingSenderId: '1028669845029',
    appId: '1:1028669845029:web:f2c3391177e2ea830e59cc',
    measurementId: 'G-YZDFP5W7JD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8jvnhnFUE-CzRPkHUY50qJv4nCIq7WA4',
    authDomain: 'mobil-cafe.firebaseapp.com',
    projectId: 'mobil-cafe',
    storageBucket: 'mobil-cafe.appspot.com',
    messagingSenderId: '1028669845029',
    appId: '1:1028669845029:android:16a4c688ef6e5b3c0e59cc',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDUcTnUfHwNSnBd67tEZQuDzgeDZHcs1q0',
    authDomain: 'mobil-cafe.firebaseapp.com',
    projectId: 'mobil-cafe',
    storageBucket: 'mobil-cafe.firebasestorage.app',
    messagingSenderId: '1028669845029',
    appId: '1:1028669845029:ios:acca58d99c54eed60e59cc',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'com.example.mobilCafe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_MACOS_API_KEY',
    authDomain: 'YOUR_MACOS_AUTH_DOMAIN',
    projectId: 'mobil-cafe',
    storageBucket: 'mobil-cafe.firebasestorage.app',
    messagingSenderId: '1028669845029',
    appId: 'YOUR_MACOS_APP_ID',
    iosClientId: 'YOUR_MACOS_CLIENT_ID',
    iosBundleId: 'YOUR_MACOS_BUNDLE_ID',
  );
}