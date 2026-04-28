import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
      ),

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
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];

                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              item.product.image,
                              height: 60,
                              width: 60,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text("Qty: ${item.quantity}"),

                                  Text(
                                    "KSh ${item.product.price * item.quantity}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "Total: KSh ${cart.totalPrice}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 45),
                        ),

                        onPressed: () async {
                          final response = await http.post(
                            Uri.parse(
                              "http://127.0.0.1/gaming_store_api/place_order.php",
                            ),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({
                              "email": "testuser@gmail.com",
                              "total": cart.totalPrice,
                              "items": cart.cartItems,
                            }),
                          );

                          if (response.statusCode == 200) {
                            cart.clearCart();

                            Get.snackbar(
                              "Success",
                              "Order saved to database",
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );

                            Get.offAllNamed("/homescreen");
                          } else {
                            Get.snackbar(
                              "Error",
                              "Failed to save order",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },

                        child: const Text("Confirm Purchase"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
