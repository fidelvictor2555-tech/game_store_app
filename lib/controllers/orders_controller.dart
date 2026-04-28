import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/database_service.dart';
import 'profile_controller.dart';

class OrdersController extends GetxController {
  var orders = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // FETCH ORDERS FROM MYSQL
  Future<void> fetchOrders() async {
    final userId = Get.find<ProfileController>().userId.value;

    if (userId.isEmpty) return;

    isLoading.value = true;

    final response = await DatabaseService.getOrders(int.parse(userId));

    isLoading.value = false;

    if (response["success"] == true) {
      orders.value = List<Map<String, dynamic>>.from(response["data"]);
    } else {
      Get.snackbar(
        "Error",
        "Failed to load orders",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // REORDER
  Future<void> reorder(Map<String, dynamic> order) async {
    final userId = Get.find<ProfileController>().userId.value;

    if (userId.isEmpty) return;

    isLoading.value = true;

    final response = await DatabaseService.placeOrder(
      userId: int.parse(userId),
      items: order["items"],
      total: order["total"].toDouble(),
    );

    isLoading.value = false;

    if (response["success"] == true) {
      Get.snackbar(
        "Success",
        "Order placed again",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      fetchOrders(); // refresh list
    } else {
      Get.snackbar(
        "Error",
        "Reorder failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // CANCEL ORDER
  Future<void> cancelOrder(int orderId) async {
    isLoading.value = true;

    final response = await DatabaseService.updateOrderStatus(
      orderId: orderId,
      status: "Cancelled",
    );

    isLoading.value = false;

    if (response["success"] == true) {
      Get.snackbar(
        "Cancelled",
        "Order cancelled successfully",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );

      fetchOrders();
    } else {
      Get.snackbar(
        "Error",
        "Failed to cancel order",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
