import 'package:flutter/material.dart';

import '../models/category_group.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../services/store.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';
import 'favorites_screen.dart';

class ProductScreen extends StatefulWidget {
  final CategoryGroup group;

  const ProductScreen({super.key, required this.group});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = apiService.getProductsByCategories(widget.group.slugs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.title),
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
      ), // AppBar burada biter

      body: FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Ürünler yüklenemedi."),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        productsFuture = apiService
                            .getProductsByCategories(widget.group.slugs);
                      });
                    },
                    child: const Text("Tekrar Dene"),
                  ),
                ],
              ),
            );
          }

          final List<Product> products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(child: Text("Bu kategoride ürün yok."));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: products[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(product: products[index]),
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