# mobil_cafe

Kafe Uygulaması

### Pull Request Çalışmaları
-## Mobil videomuz Drive Linki : https://drive.google.com/drive/folders/1tQ2miTKJDAK94sMBK-VgsVYYETKbplPe?usp=sharing
- **[PR 1: UI Pages – Giriş ve Kayıt Ekranları Tasarlandı]**
  - Giriş ve kayıt işlemleri için modern ve kullanıcı dostu arayüz tasarlandı.
  - Form validasyonları eklendi.
  - Sayfalar arasında gezinmeyi sağlayan temel navigasyon yapısı kuruldu.

- **[PR 2: Firebase Bağlantısı ve Auth İşlemleri]**
  - Firebase entegrasyonu gerçekleştirildi.
  - Kullanıcı kimlik doğrulama işlemleri (kayıt, giriş, şifre sıfırlama) tamamlandı.
  - Firebase'den hata mesajlarını kullanıcı dostu mesajlara dönüştüren yapı eklendi.

- **[PR 3: Local Database ve RESTful API Çalışmaları]**
  - Local Database: Kullanıcı verilerini saklamak için SQLite veya Room Database entegrasyonu tamamlandı.
  - RESTful API: Uygulama, uzaktan veri senkronizasyonu için RESTful API ile bağlandı.
  - CRUD işlemleri başarıyla gerçekleştirildi.
  - Veri yönetimi ve senkronizasyon için repository pattern uygulandı.

- **[PR 4: Connectivity – Bağlantı Çalışmaları]**
  - WiFi, Mobil Veri ve Bluetooth bağlantı durumlarını kontrol eden altyapı eklendi.
  - Kullanıcının internet bağlantısını gerçek zamanlı olarak izleyen bir yapı kuruldu.
  - Uygulama, bağlantı kesildiğinde kullanıcıya bilgilendirme yapar ve işlem durumunu saklar.


## Özellikler

- Ürünleri listeleme
- Ürün arama
- Sepete ürün ekleme
- Sepetten ürün çıkarma
- Firebase Firestore ile senkronizasyon

## Kurulum

1. Bu projeyi klonlayın veya indirin.
    ```bash
    git clone https://github.com/kullaniciadi/mobil_kafe_uygulamasi.git
    ```

2. Proje dizinine gidin.
    ```bash
    cd mobil_kafe_uygulamasi
    ```

3. Gerekli paketleri yükleyin.
    ```bash
    flutter pub get
    ```

4. Firebase yapılandırmasını yapın.
    - Firebase Console'da yeni bir proje oluşturun.
    - Android ve iOS için Firebase yapılandırma dosyalarını indirin (`google-services.json` ve `GoogleService-Info.plist`).
    - Bu dosyaları proje dizinine ekleyin.

## Kullanım

1. Uygulamayı çalıştırın.
    ```bash
    flutter run
    ```

2. Uygulama açıldığında, ana sayfada ürünleri görüntüleyebilirsiniz.

3. Ürün aramak için arama çubuğunu kullanabilirsiniz.

4. Ürünleri sepete eklemek için ürün kartındaki alışveriş sepeti simgesine tıklayın.

5. Sepete eklenen ürünler Firebase Firestore veritabanına kaydedilir.

6. Sepetten ürün çıkarmak için sepet ekranında ürünü çıkarabilirsiniz. Bu işlem Firestore veritabanından da ürünü siler.

## Dosya Yapısı

- [lib](http://_vscodecontentref_/1)
  - `main.dart`: Uygulamanın giriş noktası.
  - [home_screen.dart](http://_vscodecontentref_/2): Ana ekranın UI ve işlevselliği.
  - `CartProvider.dart`: Sepet yönetimi ve Firestore ile senkronizasyon.
  - `CartScreen.dart`: Sepet ekranı.
  - `campaign_screen.dart`: Kampanya detay ekranı.
  - `desserts_screen.dart`: Tatlılar ekranı.
  - `coffees_screen.dart`: Kahveler ekranı.
  - `snacks_screen.dart`: Atıştırmalıklar ekranı.

## Bağımlılıklar

- `flutter`
- `provider`
- `cloud_firestore`
- `firebase_core`


