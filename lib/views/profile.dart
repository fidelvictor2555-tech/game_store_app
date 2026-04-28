import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/home_controller.dart';
import 'package:flutter_application_1/controllers/session_controller.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    SessionController? session;

    try {
      session = Get.find<SessionController>();
    } catch (e) {
      session = null;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Profile"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/profile_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // USER INFO CARD
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.cyan,
                        child: Icon(Icons.person, color: Colors.white),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          session?.user.value?.email ?? "Guest User",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        _buildProfileOption(
                          Icons.shopping_bag,
                          "My Orders",
                          controller,
                          onPress: () {
                            Get.toNamed("/orders");
                          },
                        ),

                        _buildProfileOption(
                          Icons.person,
                          "Edit Profile",
                          controller,
                          onPress: () => _showEditProfileSheet(context),
                        ),

                        _buildProfileOption(
                          Icons.notifications,
                          "Notifications",
                          controller,
                        ),

                        _buildProfileOption(
                          Icons.security,
                          "Privacy & Security",
                          controller,
                        ),

                        _buildProfileOption(
                          Icons.help,
                          "Help Support",
                          controller,
                        ),

                        _buildProfileOption(
                          Icons.settings,
                          "Settings",
                          controller,
                        ),

                        _buildProfileOption(Icons.info, "About", controller),

                        _buildProfileOption(
                          Icons.logout,
                          "Logout",
                          controller,
                          isLogout: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A2E),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          children: [
            const Center(
              child: Text(
                "Update Information",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),

            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: _inputStyle("New Email", Icons.email_outlined),
            ),

            const SizedBox(height: 15),

            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: _inputStyle("New Password", Icons.lock_outline),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    "Success",
                    "Profile updated!",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.cyan),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.cyan),
      ),
    );
  }

  Widget _buildProfileOption(
    IconData icon,
    String title,
    HomeController controller, {
    bool isLogout = false,
    VoidCallback? onPress,
  }) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.redAccent : Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.redAccent : Colors.white,
          fontSize: 18,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.white54,
      ),
      onTap: () {
        if (isLogout) {
          Get.defaultDialog(
            title: "Logout",
            middleText: "Are you sure you want to Log Out?",
            textConfirm: "Yes",
            textCancel: "No",
            confirmTextColor: Colors.white,
            buttonColor: Colors.blueAccent,
            onConfirm: () {
              controller.logout();
            },
          );
        } else if (onPress != null) {
          onPress();
        }
      },
    );
  }
}
