import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class Inventory extends StatelessWidget {
  Inventory({super.key});

  final CartController cart = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart"), backgroundColor: Colors.cyan),

      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/profile_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Obx(() {
            if (cart.cartItems.isEmpty) {
              return const Center(child: Text("Cart is empty"));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];

                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            item.product.image.trim(),
                            width: 60,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image),
                          ),

                          title: Text(item.product.name),

                          subtitle: Text(
                            "KSh ${item.product.price} x ${item.quantity}",
                          ),

                          trailing: Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => cart.increaseQuantity(index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => cart.decreaseQuantity(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Obx(
                    () => Text(
                      "TOTAL: KSh ${cart.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () => Get.toNamed("/checkout"),
                  child: const Text("Checkout"),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
