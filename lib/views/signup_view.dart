import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/signup_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.find<SignupController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Create Account",
          style: TextStyle(color: Color.fromARGB(255, 50, 63, 6)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              Image.asset('assets/coflog.jpg', height: 150),

              const SizedBox(height: 10),

              Text(
                'Join the Great Coffee family',
                style: TextStyle(
                  color: Colors.brown[600],
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 30),

              // EMAIL
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // PASSWORD
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPassVisible.value,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPassVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.togglePassword,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // SIGN UP BUTTON
              Obx(
                () => GestureDetector(
                  onTap: controller.isLoading.value
                      ? null
                      : () async {
                          final success = await controller.signup();
                          if (success) Get.offAllNamed('/');
                        },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.isLoading.value
                          ? Colors.grey[400]
                          : Colors.amber[700],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // LOGIN LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () => Get.offAllNamed('/'),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.red[500],
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
