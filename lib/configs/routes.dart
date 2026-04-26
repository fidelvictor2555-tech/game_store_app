import 'package:flutter_application_1/views/shopping_cart.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/views/home_view.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/signup_view.dart';
import 'package:flutter_application_1/views/inventory.dart';
import 'package:flutter_application_1/views/product_detail.dart';

var routes = [
  GetPage(name: "/", page: () => const LoginView()),
  GetPage(name: "/signup", page: () => const SignupView()),
  GetPage(name: "/homescreen", page: () => const HomeScreen()),
  GetPage(name: "/marketplace", page: () => const shopping_cart()),
  GetPage(name: "/inventory", page: () => const Inventory()),
  GetPage(name: "/product", page: () => const ProductDetail()),
];
