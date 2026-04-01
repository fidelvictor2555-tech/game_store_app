import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class login_controller extends GetxController {
  final loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        var url = Uri.parse("http://10.0.2.2/gaming_store_api/login.php");

        var response = await http.post(
          url,
          body: {
            "email": emailController.text,
            "password": passwordController.text,
          },
        );

        if (response.statusCode == 200) {
          var serverData = json.decode(response.body);

          if (serverData['success'] == 1) {
            Get.snackbar(
              "Success",
              "Login successful",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );

            Get.offAllNamed('/home');
          } else {
            Get.snackbar(
              "Login Failed",
              "Invalid email or password",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
          }
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Check your XAMPP connection",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
