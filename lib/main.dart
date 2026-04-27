import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/configs/routes.dart';
import 'package:flutter_application_1/controllers/login_controller.dart';
import 'package:flutter_application_1/controllers/session_controller.dart';
import 'package:flutter_application_1/controllers/cart_controller.dart';
import 'package:flutter_application_1/views/admin_panel.dart';

void main() {
  Get.put(LoginController());
  Get.put(SessionController());
  Get.put(CartController());
  GetPage(name: "/admin", page: () => const AdminPanel());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
    );
  }
}
