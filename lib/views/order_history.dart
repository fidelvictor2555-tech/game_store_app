import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List orders = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response = await http.get(
        Uri.parse(
          "http://127.0.0.1/gaming_store_api/get_orders.php?email=testuser@gmail.com",
        ),
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        setState(() {
          orders = data["orders"];
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });

      Get.snackbar("Error", "Failed to load orders");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
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

          if (loading)
            const Center(child: CircularProgressIndicator())
          else if (orders.isEmpty)
            const Center(
              child: Text(
                "No orders yet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.all(12),

                    title: Text(
                      "Order #${order["id"]}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total: KSh ${order["total"]}"),
                        Text("Date: ${order["date"]}"),
                      ],
                    ),

                    children: [
                      const Divider(),

                      ...order["items"].map<Widget>((item) {
                        return ListTile(
                          leading: const Icon(Icons.shopping_bag),
                          title: Text(item["product_name"]),
                          subtitle: Text("Qty: ${item["quantity"]}"),
                          trailing: Text("KSh ${item["price"]}"),
                        );
                      }).toList(),

                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
