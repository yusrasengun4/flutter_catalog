import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/store.dart';
class DetailScreen extends StatelessWidget {

  final Product product;

  const DetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Ürün Detayı"),
        actions: [
         ListenableBuilder(
           listenable: Store.instance,
           builder: (context, _) {
             final isFav = Store.instance.isFavorite(product);
             return IconButton(
               icon: Icon(
                 isFav ? Icons.favorite : Icons.favorite_border,
                 color: isFav ? Colors.red : null,
                ),
                 onPressed: () => Store.instance.toggleFavorite(product),
             );
          },
         ),
      ],
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Ürün görseli
            Image.network(
              product.thumbnail,
              height: 250,
              width: double.infinity,
              fit: BoxFit.contain,

              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 250,
                  child: Icon(
                    Icons.image_not_supported,
                    size: 60,
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Ürün adı
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Fiyat
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Açıklama
            const Text(
              "Ürün Açıklaması",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(product.description),

            const SizedBox(height: 20),

            // Marka
            Text("Marka: ${product.brand}"),

            const SizedBox(height: 10),

            // Kategori
            Text("Kategori: ${product.category}"),

            const SizedBox(height: 10),

            // Stok
            Text("Stok: ${product.stock}"),

            const SizedBox(height: 10),

            // Değerlendirme
            Text("Puan: ${product.rating}"),

          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: ElevatedButton.icon(
      icon: const Icon(Icons.add_shopping_cart),
      label: Text(product.stock > 0 ? "Sepete Ekle" : "Stokta Yok"),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {
        if (product.stock > 0) {
          Store.instance.addToCart(product);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ürün sepete eklendi")),
          );
        }
      },
    ),
  ),
),
    );
  }
}