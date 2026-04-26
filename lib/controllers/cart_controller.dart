import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  void addToCart(Map<String, dynamic> product, int quantity) {
    int index = cartItems.indexWhere((item) => item["name"] == product["name"]);

    if (index != -1) {
      cartItems[index]["quantity"] += quantity;
      cartItems.refresh();
    } else {
      cartItems.add({...product, "quantity": quantity});
    }
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item["price"] * item["quantity"];
    }
    return total;
  }
}
