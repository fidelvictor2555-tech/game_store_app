import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/configs/routes.dart';
import 'package:flutter_application_1/controllers/login_controller.dart';

void main() {
  Get.put(LoginController());
  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    ),
  );
}
