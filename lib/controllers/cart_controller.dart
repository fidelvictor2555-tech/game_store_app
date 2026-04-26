import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item["price"];
    }
    return total;
  }
}
