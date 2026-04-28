import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/database_service.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPassVisible = false.obs;
  var isConfirmPassVisible = false.obs;
  var isLoading = false.obs;

  void togglePassword() => isPassVisible.value = !isPassVisible.value;
  void toggleConfirmPassword() =>
      isConfirmPassVisible.value = !isConfirmPassVisible.value;

  Future<bool> signup() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    // VALIDATION
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Error", "Invalid email");
      return false;
    }

    if (password.length < 6) {
      Get.snackbar("Error", "Password too weak");
      return false;
    }

    if (password != confirm) {
      Get.snackbar("Error", "Passwords do not match");
      return false;
    }

    isLoading.value = true;

    final response = await DatabaseService.signup(
      name: name,
      email: email,
      password: password,
    );

    isLoading.value = false;

    if (response["success"] == true) {
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      Get.snackbar("Success", "Account created");
      return true;
    } else {
      Get.snackbar("Failed", response["message"] ?? "Signup failed");
      return false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
