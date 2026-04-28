import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/database_service.dart';
import 'package:flutter_application_1/controllers/profile_controller.dart';

class LoginController extends GetxController {
  var isPassVisible = false.obs;
  var isLoading = false.obs;

  void togglePassword() => isPassVisible.value = !isPassVisible.value;

  Future<bool> login(String email, String password) async {
    // VALIDATION
    if (email.trim().isEmpty || password.trim().isEmpty) {
      Get.snackbar(
        "Missing Fields",
        "Email and password are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber[100],
        colorText: Colors.brown[800],
      );
      return false;
    }

    if (!GetUtils.isEmail(email.trim())) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber[100],
        colorText: Colors.brown[800],
      );
      return false;
    }

    if (password.length < 6) {
      Get.snackbar(
        "Weak Password",
        "Password must be at least 6 characters",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber[100],
        colorText: Colors.brown[800],
      );
      return false;
    }

    isLoading.value = true;

    final response = await DatabaseService.login(
      username: email.trim(), // backend still expects "username"
      password: password.trim(),
    );

    isLoading.value = false;

    if (response["success"] == true) {
      // SAFE user handling
      if (response["user"] != null) {
        Get.find<ProfileController>().setUser(response["user"]);
      }

      Get.snackbar(
        "Welcome Back",
        "Login successful",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
      );

      return true;
    } else {
      Get.snackbar(
        "Login Failed",
        response["message"] ?? "Invalid credentials",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
      return false;
    }
  }
}
