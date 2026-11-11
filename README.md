# Ürün Kataloğu
Flutter ile geliştirilmiş basit bir ürün kataloğu uygulaması. Ürün verileri DummyJSON API'sinden çekilir. Arayüz tamamen Flutter'ın kendi material.dart paketiyle yazılmıştır.

## Özellikler

-Kullanıcı girişi(DummyJSON auth/login)

-Ana ekranda kategori grupları(Manav,Giyim,Kozmetik,Elektronik,Ev&Yaşam,Aksesuar,Spor&Araç)

-Seçilen gruba ait ürünlerin listelenmesi

-Ürün detay sayfası(görsel,fiyat,açıklama,marka,stok,puan)

-Favorilere ekleme/çıkarma ve favoriler ekranı

-Sepet ve sipariş verme

##Kullanılan Teknolojiler

-Flutter :3.32.8

-Android Studio(Android emülatörü)

-[DummyJSON](https://dummyjson.com)

##Kurulum

1.Projeyi klonlama:
```bash
   git clone https://github.com/yusrasengun4/flutter_catalog.git
   cd flutter_catalog
```
2.Bağımlılıkları indirme:
```bash
   flutter pub get
```
3.Uygulamayı çalıştırma:
```bash
   flutter run
```
##Giriş Bilgileri

Giriş için DummyJSON daki test kullanıcılardan biri kullanılabilir:

Kullanıcı adı:emilys

Şifre:emilyspass

Diğer kullanıcılar için: https://dummyjson.com/users

##Proje Yapısı
```
lib/
├── main.dart
├── models/
│   ├── product.dart
│   └── category_group.dart
├── services/
│   ├── api_service.dart       # Ürün istekleri
    ├── auth_service.dart      #Giriş
│   └── store.dart           # Favoriler ve sepet (ChangeNotifier)
    
├── screens/
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── product_screen.dart
│   ├── detail_screen.dart
│   ├── favorites_screen.dart
│   └── cart_screen.dart
└── widgets/
    └── product_card.dart

```
##Notlar

Favoriler ve sepet bellekte tutulur; uygulama kapatılınca sıfırlanır.
