import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'controllers/login_controller.dart';
import 'controllers/signup_controller.dart';
import 'controllers/cart_controller.dart';
import 'configs/routes.dart';
import 'controllers/home_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Gaming Store",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),

      initialBinding: BindingsBuilder(() {
        Get.put(home_controller(), permanent: true);
        Get.put(LoginController(), permanent: true);
        Get.put(SignupController(), permanent: true);
        Get.put(CartController(), permanent: true);
        Get.put(OrdersController(), permanent: true);
      }),

      initialRoute: '/',
      getPages: routes,
    );
  }
}
