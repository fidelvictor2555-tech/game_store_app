import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'shop_home_page.dart';
import 'shopping_cart.dart';
import 'orders_page.dart';
import 'profile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ShopHomePage(), // 🏪 REAL HOME (products)
    const ShoppingCart(), // 🛒 Cart
    const OrdersPage(), // 📦 Orders
    const ProfilePage(), // 👤 Profile
  ];

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // 🌟 APP BAR
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),

        actions: [
          IconButton(
            onPressed: () => Get.offAllNamed('/'),
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),

      // 📌 BODY
      body: _pages[_selectedIndex],

      // 📱 BOTTOM NAV
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(color: Colors.black),

        child: GNav(
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          backgroundColor: Colors.black,
          color: Colors.white70,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.cyan,
          tabBorderRadius: 12,

          onTabChange: (index) => navigateBottomBar(index),

          tabs: const [
            GButton(icon: Icons.store, text: 'Shop'),
            GButton(icon: Icons.shopping_cart, text: 'Cart'),
            GButton(icon: Icons.receipt_long, text: 'Orders'),
            GButton(icon: Icons.person, text: 'Profile'),
          ],
        ),
      ),

      // 📂 DRAWER (cleaned slightly)
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const DrawerHeader(
                  child: Icon(Icons.games, color: Colors.cyan, size: 80),
                ),

                ListTile(
                  leading: const Icon(Icons.store, color: Colors.cyan),
                  title: const Text(
                    'SHOP',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    navigateBottomBar(0);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.shopping_cart, color: Colors.cyan),
                  title: const Text(
                    'CART',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    navigateBottomBar(1);
                  },
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onTap: () => Get.offAllNamed('/'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
