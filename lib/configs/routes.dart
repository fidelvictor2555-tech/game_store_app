import 'package:flutter_application_1/views/home_view.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/signup_view.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(name: '/', page: () => const LoginPage()),
  GetPage(name: '/signup', page: () => const SignUpView()),
  GetPage(name: '/homepage', page: () => const HomeView()),
];
