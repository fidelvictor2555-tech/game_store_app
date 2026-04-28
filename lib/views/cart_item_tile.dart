import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/cart_controller.dart';

class CartItemTile extends StatelessWidget {
  final Map<String, dynamic> product;

  const CartItemTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
      ),

      child: ListTile(
        contentPadding: EdgeInsets.zero,

        // IMAGE
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            product['image'] ?? '',
            width: 55,
            height: 55,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 55,
              height: 55,
              color: Colors.grey[300],
              child: const Icon(Icons.image),
            ),
          ),
        ),

        // NAME
        title: Text(
          product['name'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        // PRICE × QTY
        subtitle: Text("KSh ${product['price']} × ${product['quantity']}"),

        // DELETE BUTTON
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            cartController.removeFromCart(product);
          },
        ),
      ),
    );
  }
}
