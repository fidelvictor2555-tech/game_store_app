import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Gaming Store",
          style: TextStyle(
            color: Color.fromARGB(255, 6, 118, 126),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              Image.asset('assets/images/dental_logo.png', height: 160),

              const SizedBox(height: 10),

              Text(
                "Welcome Back Gamer 🎮",
                style: TextStyle(
                  color: Colors.cyan[700],
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 30),

              // USERNAME
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[900],
                  ),
                ),
              ),
              const SizedBox(height: 5),

              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.person, color: Colors.cyan),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // PASSWORD
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[900],
                  ),
                ),
              ),
              const SizedBox(height: 5),

              Obx(
                () => TextField(
                  controller: passwordController,
                  obscureText: !loginController.isPassVisible.value,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    prefixIcon: const Icon(Icons.lock, color: Colors.cyan),
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginController.isPassVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.cyan,
                      ),
                      onPressed: loginController.togglePassword,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // LOGIN BUTTON
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: loginController.isLoading.value
                        ? null
                        : () async {
                            bool success = await loginController.login(
                              usernameController.text,
                              passwordController.text,
                            );

                            if (success) {
                              Get.offAllNamed('/homepage');
                            }
                          },
                    child: loginController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () => Get.toNamed('/signup'),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.cyan[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
