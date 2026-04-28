import 'package:get/get.dart';
import 'package:flutter_application_1/services/database_service.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;

  var totalOrders = 0.obs;
  var totalSpent = 0.obs;
  var memberSince = ''.obs;

  var userId = ''.obs;
  var isLoading = false.obs;

  // SET USER DATA
  void setUser(Map<String, dynamic> data) {
    userId.value = data["id"]?.toString() ?? '';
    name.value = data["name"] ?? '';
    email.value = data["email"] ?? '';
    phone.value = data["phone"] ?? '';

    totalOrders.value =
        int.tryParse(data["total_orders"]?.toString() ?? "0") ?? 0;
    totalSpent.value =
        int.tryParse(data["total_spent"]?.toString() ?? "0") ?? 0;

    memberSince.value = data["member_since"] ?? '';
  }

  // UPDATE PROFILE
  Future<void> updateProfile(String newName, String newPhone) async {
    if (newName.trim().isEmpty || newPhone.trim().isEmpty) {
      Get.snackbar("Error", "Name and phone cannot be empty");
      return;
    }

    if (userId.value.isEmpty) return;

    isLoading.value = true;

    try {
      final res = await DatabaseService.updateProfile(
        userId: int.parse(userId.value),
        name: newName.trim(),
        phone: newPhone.trim(),
      );

      if (res["success"] == true) {
        name.value = newName.trim();
        phone.value = newPhone.trim();
        Get.snackbar("Success", "Profile updated");
      } else {
        Get.snackbar("Error", res["message"] ?? "Update failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Network error occurred");
    }

    isLoading.value = false;
  }

  // UPDATE EMAIL
  Future<void> updateEmail({
    required String newEmail,
    required String currentPassword,
  }) async {
    if (newEmail.trim().isEmpty || currentPassword.isEmpty) {
      Get.snackbar("Error", "All fields required");
      return;
    }

    if (!GetUtils.isEmail(newEmail.trim())) {
      Get.snackbar("Error", "Invalid email format");
      return;
    }

    if (userId.value.isEmpty) return;

    isLoading.value = true;

    try {
      final res = await DatabaseService.updateEmail(
        userId: int.parse(userId.value),
        newEmail: newEmail.trim(),
        currentPassword: currentPassword,
      );

      if (res["success"] == true) {
        email.value = newEmail.trim();
        Get.snackbar("Success", "Email updated");
      } else {
        Get.snackbar("Error", res["message"] ?? "Update failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Network error occurred");
    }

    isLoading.value = false;
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar("Error", "Fill all fields");
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar("Error", "Password too short");
      return;
    }

    if (userId.value.isEmpty) return;

    isLoading.value = true;

    try {
      final res = await DatabaseService.changePassword(
        userId: int.parse(userId.value),
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (res["success"] == true) {
        Get.snackbar("Success", "Password changed");
      } else {
        Get.snackbar("Error", res["message"] ?? "Failed to change password");
      }
    } catch (e) {
      Get.snackbar("Error", "Network error occurred");
    }

    isLoading.value = false;
  }

  // LOGOUT
  void logout() {
    userId.value = '';
    name.value = '';
    email.value = '';
    phone.value = '';

    totalOrders.value = 0;
    totalSpent.value = 0;
    memberSince.value = '';

    Get.offAllNamed('/');
  }
}
