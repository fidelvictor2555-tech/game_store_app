import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final name = TextEditingController();
  final category = TextEditingController();
  final price = TextEditingController();
  final image = TextEditingController();

  Future<void> addProduct() async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1/gaming_store_api/add_product.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name.text,
        "category": category.text,
        "price": price.text,
        "image": image.text,
      }),
    );

    final data = jsonDecode(response.body);

    if (data["success"]) {
      Get.snackbar("Success", "Product added");
      name.clear();
      category.clear();
      price.clear();
      image.clear();
    } else {
      Get.snackbar("Error", "Failed to add product");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: category,
              decoration: const InputDecoration(labelText: "Category"),
            ),
            TextField(
              controller: price,
              decoration: const InputDecoration(labelText: "Price"),
            ),
            TextField(
              controller: image,
              decoration: const InputDecoration(labelText: "Image filename"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: addProduct,
              child: const Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }
}
