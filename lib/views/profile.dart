import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/profile_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Obx(
      () => Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/profile_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.cyan,
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.name.value,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(controller.email.value),
                              Text(controller.phone.value),
                            ],
                          ),
                        ),

                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.cyan),
                          onPressed: () {
                            _editProfile(context, controller);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ✅ STATS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _statCard(
                        "Orders",
                        controller.totalOrders.value.toString(),
                      ),
                      _statCard("Spent", "KSh ${controller.totalSpent.value}"),
                      _statCard("Member", controller.memberSince.value),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ✅ SETTINGS LIST
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        _tile(
                          icon: Icons.person,
                          title: "Edit Profile",
                          onTap: () => _editProfile(context, controller),
                        ),
                        _tile(
                          icon: Icons.lock,
                          title: "Change Password",
                          onTap: () => _changePassword(context, controller),
                        ),
                        _tile(
                          icon: Icons.logout,
                          title: "Logout",
                          color: Colors.red,
                          onTap: controller.logout,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ STAT CARD
  Widget _statCard(String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // ✅ LIST TILE
  Widget _tile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.cyan),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  // ✅ EDIT PROFILE
  void _editProfile(BuildContext context, ProfileController controller) {
    final name = TextEditingController(text: controller.name.value);
    final phone = TextEditingController(text: controller.phone.value);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: phone,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await controller.updateProfile(name.text, phone.text);
              Get.back();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // ✅ CHANGE PASSWORD
  void _changePassword(BuildContext context, ProfileController controller) {
    final current = TextEditingController();
    final newPass = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: current,
              decoration: const InputDecoration(labelText: "Current Password"),
            ),
            TextField(
              controller: newPass,
              decoration: const InputDecoration(labelText: "New Password"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await controller.changePassword(
                currentPassword: current.text,
                newPassword: newPass.text,
                confirmPassword: newPass.text,
              );
              Get.back();
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
