import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(Product product, int quantity) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      cartItems[index].quantity += quantity;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  void increaseQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    }
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  void clearCart() {
    cartItems.clear();
  }
}
