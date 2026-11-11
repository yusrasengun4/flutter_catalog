class Product {

  final int id;
  final String title;
  final String description;
  final double price;
  final String brand;
  final String category;
  final String thumbnail;
  final double rating;
  final int stock;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    this.description = "",
    this.brand = "",
    this.category = "",
    this.thumbnail = "",
    this.rating = 0,
    this.stock = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {

    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? "",
      price: (json['price'] as num).toDouble(),
      brand: json['brand'] ?? "",
      category: json['category'] ?? "",
      thumbnail: json['thumbnail'] ?? "",
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: json['stock'] ?? 0,
    );
  }
}