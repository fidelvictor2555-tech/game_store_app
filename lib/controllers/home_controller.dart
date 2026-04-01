import 'package:get/get.dart';

class home_controller extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}
