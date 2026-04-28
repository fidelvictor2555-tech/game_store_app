import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'shopping_cart.dart';
import 'inventory.dart';
import 'orders_page.dart';
import 'profile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const shopping_cart(),
    const Inventory(),
    const OrdersPage(),
    const profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

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
          onTabChange: (value) => navigateBottomBar(value),
          tabs: const [
            GButton(icon: Icons.store, text: 'Shop'),
            GButton(icon: Icons.shopping_cart, text: 'Cart'),
            GButton(icon: Icons.receipt_long, text: 'Orders'),
            GButton(icon: Icons.person, text: 'Profile'),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
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

      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Image.asset("assets/images/profile_bg.png"),
                ),

                ListTile(
                  leading: const Icon(Icons.home, color: Colors.cyan),
                  title: const Text(
                    'HOME',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    navigateBottomBar(0);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.info, color: Colors.cyan),
                  title: const Text(
                    'ABOUT',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => Navigator.pop(context),
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

          // CURRENT PAGE
          SafeArea(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}
