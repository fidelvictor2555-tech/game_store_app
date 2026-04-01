import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/signup_controller.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(signup_controller());

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: controller.firstNameController,
                decoration: const InputDecoration(
                  hintText: "First Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.lastNameController,
                decoration: const InputDecoration(
                  hintText: "Last Name",
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.phoneController,
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.passwordAgainController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Confirm Password",
                  prefixIcon: Icon(Icons.lock_reset),
                ),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () => controller.register(),
                minWidth: double.infinity,
                height: 50,
                color: Colors.cyan,
                textColor: Colors.white,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
