import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class Checkout extends StatelessWidget {
  Checkout({super.key});

  final CartController cart = Get.find<CartController>();

  void placeOrder() {
    cart.clearCart();

    Get.snackbar(
      "Success",
      "Order placed successfully",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    Get.offAllNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.cyan,
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

          Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];

                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text(
                          "KSh ${item.product.price} x ${item.quantity}",
                        ),
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Obx(
                  () => Text(
                    "TOTAL: KSh ${cart.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Confirm Order"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
