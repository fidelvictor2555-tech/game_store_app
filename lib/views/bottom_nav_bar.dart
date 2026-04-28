import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';

class MyBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const MyBottomNavBar({super.key, required this.selectedIndex});

  void _onTabChange(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed('/homepage');
        break;
      case 1:
        Get.toNamed('/cart');
        break;
      case 2:
        Get.toNamed('/orders');
        break;
      case 3:
        Get.toNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: GNav(
        selectedIndex: selectedIndex,
        onTabChange: _onTabChange,
        rippleColor: Colors.grey.shade200,
        hoverColor: Colors.grey.shade100,
        haptic: true,
        tabBorderRadius: 16,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),

        gap: 8,
        color: Colors.grey[500],
        activeColor: Colors.amber[800],
        iconSize: 24,

        tabBackgroundColor: Colors.amber.withOpacity(0.15),

        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),

        tabs: const [
          GButton(icon: Icons.storefront, text: 'Shop'),
          GButton(icon: Icons.shopping_cart_outlined, text: 'Cart'),
          GButton(icon: Icons.receipt_long, text: 'Orders'),
          GButton(icon: Icons.person_outline, text: 'Profile'),
        ],
      ),
    );
  }
}
