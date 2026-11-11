import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {

  final String baseUrl = "https://dummyjson.com";

  Future<List<Product>> getProducts() async {

    final response = await http.get(
      Uri.parse("$baseUrl/products"),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      final List productsJson = data['products'];

      return productsJson.map((product) {
        return Product.fromJson(product);
      }).toList();

    } else {

      throw Exception("Ürünler alınamadı");

    }
  }
    Future<List<Product>> getProductsByCategory(String slug) async {
    final response = await http.get(
      Uri.parse("$baseUrl/products/category/$slug"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List productsJson = data['products'];
      return productsJson.map((p) => Product.fromJson(p)).toList();
    } else {
      throw Exception("Ürünler alınamadı");
    }
  }

  // Bir gruptaki tüm kategorileri aynı anda çekip birleştirir
  Future<List<Product>> getProductsByCategories(List<String> slugs) async {
    final results = await Future.wait(
      slugs.map((slug) => getProductsByCategory(slug)),
    );
    return results.expand((list) => list).toList();
  }
}