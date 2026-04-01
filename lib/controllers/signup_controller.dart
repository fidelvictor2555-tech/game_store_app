import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class signup_controller extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();

  Future<void> register() async {
    if (firstNameController.text.isEmpty) {
      Get.snackbar("error", "please enter first name");
      return;
    } else if (lastNameController.text.isEmpty) {
      Get.snackbar("error", "enter last name");
      return;
    } else if (phoneController.text.isEmpty) {
      Get.snackbar("error", "please enter phone number");
      return;
    } else if (passwordController.text.isEmpty ||
        passwordAgainController.text.isEmpty ||
        passwordController.text != passwordAgainController.text) {
      Get.snackbar(
        "error",
        "please password and password confirmation should be non empty and matching",
      );
      return;
    }

    try {
      var url = Uri.parse("http://10.0.2.2/gaming_store_api/register.php");
      var response = await http.post(
        url,
        body: {
          "f_name": firstNameController.text,
          "l_name": lastNameController.text,
          "phone": phoneController.text,
          "email": emailController.text,
          "password": passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        var serverData = json.decode(response.body);
        if (serverData['success'] == 1) {
          Get.snackbar("success", "you are registered");
          Get.offAllNamed('/login');
        } else {
          Get.snackbar("registration", "registration failed");
        }
      }
    } catch (e) {
      Get.snackbar("error", "connection refused");
    }
  }
}
