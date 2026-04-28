import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/database_service.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPassVisible = false.obs;
  var isLoading = false.obs;

  void togglePassword() => isPassVisible.value = !isPassVisible.value;

  Future<bool> signup() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // VALIDATION
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Missing Fields",
        "Email and password are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber[100],
        colorText: Colors.brown[800],
      );
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address",
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

    final response = await DatabaseService.signup(
      name: "", // backend compatibility if still required
      email: email,
      phone: "", // removed from UI but kept for backend compatibility
      password: password,
    );

    isLoading.value = false;

    if (response["success"] == true) {
      emailController.clear();
      passwordController.clear();

      Get.snackbar(
        "Account Created",
        "You can now log in",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
      );
      return true;
    } else {
      Get.snackbar(
        "Sign Up Failed",
        response["message"] ?? "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
      return false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
