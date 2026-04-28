import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/orders_controller.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "Processing":
        return Colors.orange;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Delivered":
        return Icons.check_circle;
      case "Processing":
        return Icons.access_time;
      case "Cancelled":
        return Icons.cancel;
      default:
        return Icons.shopping_bag;
    }
  }

  @override
  Widget build(BuildContext context) {
    final OrdersController controller = Get.find<OrdersController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // BACKGROUND
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/profile_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.orders.isEmpty) {
              return const Center(
                child: Text(
                  "No orders yet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: controller.orders.length,
              itemBuilder: (context, index) {
                final order = controller.orders[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ORDER HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order #${order["id"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(order["status"]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  getStatusIcon(order["status"]),
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  order["status"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      const Divider(),

                      const SizedBox(height: 10),

                      // ITEMS
                      ...order["items"].map<Widget>((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${item["name"]} x${item["quantity"]}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                "KSh ${item["price"] * item["quantity"]}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),

                      const SizedBox(height: 10),

                      const Divider(),

                      const SizedBox(height: 10),

                      // TOTAL
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            "KSh ${order["total"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.cyan,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
