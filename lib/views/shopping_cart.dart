import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class shopping_cart extends StatefulWidget {
  const shopping_cart({super.key});

  @override
  State<shopping_cart> createState() => _shopping_cartState();
}

class _shopping_cartState extends State<shopping_cart> {
  final TextEditingController searchController = TextEditingController();
  final CartController cart = Get.find<CartController>();

  List<Map<String, dynamic>> allProducts = [
    {
      "name": "PS5 Console",
      "category": "Consoles",
      "price": 75000.0,
      "image": "http://10.0.2.2/gaming_store_api/images/ps5.jpg",
    },
    {
      "name": "Gaming PC Desktop",
      "category": "Video Games",
      "price": 120000.0,
      "image": "http://10.0.2.2/gaming_store_api/images/gamingpc.jpg",
    },
    {
      "name": "Gaming Headset",
      "category": "Headsets",
      "price": 25000.0,
      "image": "http://10.0.2.2/gaming_store_api/images/headset.jpg",
    },
    {
      "name": "4K Monitor",
      "category": "Consoles",
      "price": 80000.0,
      "image": "http://10.0.2.2/gaming_store_api/images/monitor.jpg",
    },
    {
      "name": "Mechanical Keyboard",
      "category": "Keyboards",
      "price": 5000.0,
      "image": "http://10.0.2.2/gaming_store_api/images/keyboard.jpg",
    },
    {
      "name": "Gaming Mouse",
      "category": "Gaming Mice",
      "price": 2000.0,
      "image": "http://10.0.2.2/gaming_store_api/images/mouse.jpg",
    },
  ];

  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();

    filteredProducts = allProducts;

    final category = Get.arguments;

    if (category != null) {
      filteredProducts = allProducts
          .where((p) => p["category"] == category)
          .toList();
    }
  }

  void searchProduct(String query) {
    setState(() {
      filteredProducts = allProducts
          .where(
            (product) =>
                product["name"].toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Marketplace"),
        centerTitle: true,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/inventory');
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/profile_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: searchController,
                  onChanged: searchProduct,
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            product["image"],
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product["name"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(product["category"]),
                          const SizedBox(height: 5),
                          Text("KSh ${product["price"]}"),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan,
                            ),
                            onPressed: () {
                              cart.addToCart(product);

                              Get.snackbar(
                                "Added to Cart",
                                product["name"],
                                snackPosition: SnackPosition.BOTTOM,
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
        ],
      ),
    );
  }
}
