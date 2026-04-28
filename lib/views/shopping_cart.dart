import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../controllers/cart_controller.dart';
import '../models/product_model.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final CartController cart = Get.put(CartController());
  final TextEditingController searchController = TextEditingController();

  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse("http://127.0.0.1/gaming_store_api/get_products.php"),
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        setState(() {
          products = (data["products"] as List)
              .map((item) => Product.fromJson(item))
              .toList();

          filteredProducts = products;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);

      Get.snackbar(
        "Error",
        "Failed to load products",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void search(String query) {
    setState(() {
      filteredProducts = products
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketplace"),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.toNamed("/inventory"),
          ),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: searchController,
                    onChanged: search,
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              product.image,
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),

                            const SizedBox(height: 10),

                            Text(
                              product.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text("KSh ${product.price.toStringAsFixed(2)}"),

                            const SizedBox(height: 10),

                            ElevatedButton(
                              onPressed: () {
                                cart.addToCart(product, 1);

                                Get.snackbar(
                                  "Added to Cart",
                                  product.name,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              },
                              child: const Text("Add to Cart"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
