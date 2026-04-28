import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../controllers/cart_controller.dart';
import '../models/gaming.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final CartController cart = Get.find<CartController>();

  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1/gaming_store_api/get_products.php"),
    );

    final data = jsonDecode(response.body);

    if (data["success"] == true) {
      setState(() {
        filteredProducts = products;
        isLoading = false;
      });
    }
  }

  void search(String value) {
    setState(() {
      filteredProducts = products
          .where((p) => p.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketplace"),
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

          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: search,
                        decoration: const InputDecoration(
                          hintText: "Search products...",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),

                    Expanded(
                      child: GridView.builder(
                        itemCount: filteredProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];

                          return Card(
                            child: Column(
                              children: [
                                Image.network(
                                  product.imagePath,
                                  height: 80,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.broken_image),
                                ),
                                Text(product.name),
                                Text("KSh ${product.price}"),
                                ElevatedButton(
                                  onPressed: () {
                                    cart.addToCart(
                                      product as Map<String, dynamic>,
                                      1,
                                    );
                                  },
                                  child: const Text("Add"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
