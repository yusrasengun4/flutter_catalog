import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Store extends ChangeNotifier {
 
  static final Store instance = Store._();
  Store._();

  final Set<int> _favoriteIds = {};
  final List<Product> _favorites = [];
  final Map<int, CartItem> _cart = {};

  // ---------- FAVORİLER ----------
  List<Product> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Product p) => _favoriteIds.contains(p.id);

  void toggleFavorite(Product p) {
    if (_favoriteIds.contains(p.id)) {
      _favoriteIds.remove(p.id);
      _favorites.removeWhere((e) => e.id == p.id);
    } else {
      _favoriteIds.add(p.id);
      _favorites.add(p);
    }
    notifyListeners();
  }

  // ---------- SEPET ----------
  List<CartItem> get cartItems => _cart.values.toList();

  int get cartCount =>
      _cart.values.fold(0, (sum, item) => sum + item.quantity);

  double get cartTotal => _cart.values
      .fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

  void addToCart(Product p) {
    if (_cart.containsKey(p.id)) {
      _cart[p.id]!.quantity++;
    } else {
      _cart[p.id] = CartItem(product: p);
    }
    notifyListeners();
  }

  void decreaseQuantity(Product p) {
    final item = _cart[p.id];
    if (item == null) return;
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _cart.remove(p.id);
    }
    notifyListeners();
  }

  void removeFromCart(Product p) {
    _cart.remove(p.id);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}