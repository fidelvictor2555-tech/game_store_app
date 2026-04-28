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

      // APP BAR (your cyan theme restored)
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Create Account",
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
              const SizedBox(height: 15),

              // LOGO (your original style)
              Image.asset('assets/images/dental_logo.png', height: 150),

              const SizedBox(height: 10),

              Text(
                "Welcome Gamer 👾",
                style: TextStyle(
                  color: Colors.cyan[700],
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 25),

              // FULL NAME
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Full Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.cyan[900],
                  ),
                ),
              ),
              const SizedBox(height: 5),

              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  hintText: "Enter your full name",
                  prefixIcon: const Icon(Icons.person, color: Colors.cyan),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // EMAIL
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.cyan[900],
                  ),
                ),
              ),
              const SizedBox(height: 5),

              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.email, color: Colors.cyan),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // PASSWORD
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.cyan[900],
                  ),
                ),
              ),
              const SizedBox(height: 5),

              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPassVisible.value,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    prefixIcon: const Icon(Icons.lock, color: Colors.cyan),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPassVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.cyan,
                      ),
                      onPressed: controller.togglePassword,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // CONFIRM PASSWORD
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Confirm Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.cyan[900],
                  ),
                ),
              ),
              const SizedBox(height: 5),

              Obx(
                () => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: !controller.isConfirmPassVisible.value,
                  decoration: InputDecoration(
                    hintText: "Re-enter password",
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.cyan,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmPassVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.cyan,
                      ),
                      onPressed: controller.toggleConfirmPassword,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // SIGNUP BUTTON (your theme restored)
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
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            final success = await controller.signup();
                            if (success) Get.offAllNamed('/');
                          },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // LOGIN LINK (your style restored)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () => Get.offAllNamed('/'),
                    child: Text(
                      "Login",
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
