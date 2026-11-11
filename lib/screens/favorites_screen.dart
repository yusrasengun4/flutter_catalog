import 'package:flutter/material.dart';
import '../services/store.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Store.instance;

    return Scaffold(
      appBar: AppBar(title: const Text("Favorilerim"), centerTitle: true),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          final favorites = store.favorites;

          if (favorites.isEmpty) {
            return const Center(child: Text("Henüz favori ürününüz yok."));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(product: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}