import 'package:flutter/material.dart';

import '../models/category_group.dart';
import '../services/store.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'product_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Kataloğu"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
          ListenableBuilder(
            listenable: Store.instance,
            builder: (context, _) {
              return IconButton(
                icon: Badge(
                  isLabelVisible: Store.instance.cartCount > 0,
                  label: Text("${Store.instance.cartCount}"),
                  child: const Icon(Icons.shopping_cart),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: categoryGroups.length,
        itemBuilder: (context, index) {
          final group = categoryGroups[index];

          return Card(
            elevation: 3,
            color: group.color.shade50,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductScreen(group: group),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: group.color.shade100,
                    child: Icon(group.icon, size: 36, color: group.color),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    group.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}