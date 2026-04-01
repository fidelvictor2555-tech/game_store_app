import 'package:get/get.dart';

import 'package:flutter_application_1/views/home_view.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/signup_view.dart';

var routes = [
  GetPage(name: "/", page: () => const LoginView()),
  GetPage(name: "/signup", page: () => const SignupView()),
  GetPage(name: "/homescreen", page: () => const HomeScreen()),
];
