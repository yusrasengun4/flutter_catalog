import 'package:flutter/material.dart';

class CategoryGroup {
  final String title;
  final IconData icon;
  final MaterialColor color;
  final List<String> slugs; 

  const CategoryGroup({
    required this.title,
    required this.icon,
    required this.color,
    required this.slugs,
  });
}

const List<CategoryGroup> categoryGroups = [
  CategoryGroup(
    title: "Manav",
    icon: Icons.local_grocery_store,
    color: Colors.green,
    slugs: ["groceries"],
  ),
  CategoryGroup(
    title: "Giyim",
    icon: Icons.checkroom,
    color: Colors.indigo,
    slugs: ["mens-shirts", "tops", "womens-dresses", "mens-shoes", "womens-shoes"],
  ),
  CategoryGroup(
    title: "Kozmetik",
    icon: Icons.face_retouching_natural,
    color: Colors.pink,
    slugs: ["beauty", "skin-care", "fragrances"],
  ),
  CategoryGroup(
    title: "Elektronik",
    icon: Icons.devices,
    color: Colors.blue,
    slugs: ["smartphones", "laptops", "tablets", "mobile-accessories"],
  ),
  CategoryGroup(
    title: "Ev & Yaşam",
    icon: Icons.chair,
    color: Colors.brown,
    slugs: ["furniture", "home-decoration", "kitchen-accessories"],
  ),
  CategoryGroup(
    title: "Aksesuar",
    icon: Icons.watch,
    color: Colors.purple,
    slugs: ["mens-watches", "womens-watches", "womens-bags", "womens-jewellery", "sunglasses"],
  ),
  CategoryGroup(
    title: "Spor & Araç",
    icon: Icons.sports_soccer,
    color: Colors.orange,
    slugs: ["sports-accessories", "motorcycle", "vehicle"],
  ),
  CategoryGroup(
    title: "Hepsi",
    icon: Icons.category,
    color: Colors.red,
    slugs: [
      "groceries",
      "mens-shirts",
      "tops",
      "womens-dresses",
      "mens-shoes",
      "womens-shoes",
      "beauty",
      "skin-care",
      "fragrances",
      "smartphones",
      "laptops",
      "tablets",
      "mobile-accessories",
      "furniture",
      "home-decoration",
      "kitchen-accessories",
      "mens-watches",
      "womens-watches",
      "womens-bags",
      "womens-jewellery",
      "sunglasses",
      "sports-accessories",
      "motorcycle",
      "vehicle"
    ],
  ),
];