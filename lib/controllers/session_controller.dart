import 'package:get/get.dart';
import '../models/user_model.dart';

class SessionController extends GetxController {
  var user = Rxn<UserModel>();

  void setUser(UserModel newUser) {
    user.value = newUser;
  }

  void clearUser() {
    user.value = null;
  }
}
