import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;
  final VoidCallback onTap;

  const ProductTile({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10),
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 10),

          // NAME
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 5),

          // PRICE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "KSh $price",
              style: const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ADD BUTTON
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: const Icon(Icons.add_shopping_cart, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
