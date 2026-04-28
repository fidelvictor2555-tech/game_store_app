import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();

  Future<void> register() async {
    if (nameController.text.isEmpty) {
      Get.snackbar("error", "please enter full name");
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
      var url = Uri.parse("http://127.0.0.1/gaming_store_api/signup.php");
      print("NAME: ${nameController.text}");
      print("EMAIL: ${emailController.text}");
      print("PASSWORD: ${passwordController.text}");

      var response = await http.post(
        url,
        body: {
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        },
      );

      print("RAW RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        var serverData = json.decode(response.body);

        if (serverData['success'] == 1) {
          Get.snackbar("success", "you are registered");
          Get.offAllNamed('/');
        } else {
          Get.snackbar(
            "registration",
            serverData['message'] ?? "registration failed",
          );
        }
      } else {
        Get.snackbar("error", "server error: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      Get.snackbar("error", "an error occurred during registration");
    }
  }
}
