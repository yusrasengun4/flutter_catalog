import 'package:flutter/material.dart';
import '../services/store.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Store.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim"),
        centerTitle: true,
        actions: [
          ListenableBuilder(
            listenable: store,
            builder: (context, _) => store.cartItems.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: "Sepeti boşalt",
                    onPressed: store.clearCart,
                  ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          final items = store.cartItems;

          if (items.isEmpty) {
            return const Center(child: Text("Sepetiniz boş."));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final p = item.product;

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.network(
                        p.thumbnail,
                        width: 56,
                        height: 56,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      ),
                      title: Text(p.title, maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      subtitle: Text(
                          "\$${(p.price * item.quantity).toStringAsFixed(2)}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => store.decreaseQuantity(p),
                          ),
                          Text("${item.quantity}",
                              style: const TextStyle(fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => store.addToCart(p),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Toplam
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: const [
                    BoxShadow(blurRadius: 6, color: Colors.black12),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Toplam: \$${store.cartTotal.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          store.clearCart();
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Siparişiniz verildi!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,),),),
                          );
                        },
                        child: const Text("Sipariş Ver"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}