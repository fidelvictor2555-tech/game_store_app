import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  void addToCart(Map<String, dynamic> product, int quantity) {
    final index = cartItems.indexWhere(
      (item) => item["name"] == product["name"],
    );

    if (index >= 0) {
      cartItems[index]["quantity"] += quantity;
      cartItems.refresh();
    } else {
      cartItems.add({
        "name": product["name"],
        "price": product["price"],
        "image": product["image"],
        "quantity": quantity,
      });
    }
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  void increaseQuantity(int index) {
    cartItems[index]["quantity"]++;
    cartItems.refresh();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index]["quantity"] > 1) {
      cartItems[index]["quantity"]--;
      cartItems.refresh();
    }
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item["price"] * item["quantity"];
    }
    return total;
  }

  void clearCart() {
    cartItems.clear();
  }
}
