import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
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
            if (cart.cartItems.isEmpty) {
              return const Center(
                child: Text(
                  "Your cart is empty",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return Column(
              children: [
                // CART LIST
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              item["image"],
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["name"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text("KSh ${item["price"]}"),

                                  const SizedBox(height: 10),

                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (item["quantity"] > 1) {
                                            item["quantity"]--;
                                            cart.cartItems.refresh();
                                          }
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),

                                      Text(
                                        "${item["quantity"]}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          item["quantity"]++;
                                          cart.cartItems.refresh();
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                cart.cartItems.removeAt(index);
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // TOTAL + CHECKOUT SECTION
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Obx(() {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Total: KSh ${cart.totalPrice}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            minimumSize: const Size(double.infinity, 45),
                          ),
                          onPressed: () {
                            Get.toNamed("/checkout");
                          },
                          child: const Text("Proceed to Checkout"),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
