import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/database_service.dart';
import 'package:flutter_application_1/controllers/profile_controller.dart';
import 'package:flutter_application_1/controllers/orders_controller.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) {
      final price = (item["price"] ?? 0) as num;
      final qty = (item["quantity"] ?? 1) as num;
      return sum + (price * qty);
    });
  }

  String get formattedTotal => 'KSh ${totalPrice.toStringAsFixed(0)}';
  int get itemCount => cartItems.length;

  void addToCart(Map<String, dynamic> product) {
    final index = cartItems.indexWhere((i) => i["id"] == product["id"]);

    if (index >= 0) {
      cartItems[index]["quantity"] = (cartItems[index]["quantity"] ?? 1) + 1;
      cartItems.refresh();
    } else {
      cartItems.add({...product, "quantity": 1});
    }

    Get.snackbar(
      "Added to Cart",
      "${product["name"]} added",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.cyan[100],
      colorText: Colors.cyan[800],
    );
  }

  void removeFromCart(Map<String, dynamic> item) {
    cartItems.removeWhere((i) => i["id"] == item["id"]);
  }

  void increaseQuantity(Map<String, dynamic> item) {
    final index = cartItems.indexWhere((i) => i["id"] == item["id"]);

    if (index != -1) {
      cartItems[index]["quantity"] = (cartItems[index]["quantity"] ?? 1) + 1;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(Map<String, dynamic> item) {
    final index = cartItems.indexWhere((i) => i["id"] == item["id"]);

    if (index != -1) {
      final qty = cartItems[index]["quantity"] ?? 1;

      if (qty > 1) {
        cartItems[index]["quantity"] = qty - 1;
      } else {
        cartItems.removeAt(index);
      }

      cartItems.refresh();
    }
  }

  void clearCart() => cartItems.clear();

  Future<bool> checkout() async {
    if (cartItems.isEmpty) {
      Get.snackbar(
        "Cart Empty",
        "Add products before checkout",
        backgroundColor: Colors.orange[100],
        colorText: Colors.orange[800],
      );
      return false;
    }

    final userId = Get.find<ProfileController>().userId.value;

    if (userId.isEmpty) {
      Get.snackbar(
        "Login Required",
        "Please login first",
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
      return false;
    }

    isLoading.value = true;

    try {
      final response = await DatabaseService.placeOrder(
        userId: int.parse(userId),
        items: cartItems.map((item) {
          return {
            "product_id": item["id"],
            "quantity": item["quantity"],
            "unit_price": item["price"],
          };
        }).toList(),
        total: totalPrice,
      );

      if (response["success"] == true) {
        clearCart();
        Get.find<OrdersController>().fetchOrders();

        Get.snackbar(
          "Order Successful",
          "Your items are being processed",
          backgroundColor: Colors.green[100],
          colorText: Colors.green[800],
        );

        return true;
      } else {
        Get.snackbar(
          "Checkout Failed",
          response["message"] ?? "Try again",
          backgroundColor: Colors.red[100],
          colorText: Colors.red[800],
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Network issue occurred",
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
