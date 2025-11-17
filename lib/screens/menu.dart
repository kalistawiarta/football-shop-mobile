import 'package:flutter/material.dart';
import '../widgets/left_drawer.dart';
import '../widgets/product_card.dart';
import '../screens/add_product_form.dart';
import '../screens/product_entry_list.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = '2406351491';
  final String name = 'Kalista Wiarta';
  final String className = 'B';

  final List<Map<String, dynamic>> homeButtons = [
    {"text": "See Products", "icon": Icons.newspaper},
    {"text": "Add Product", "icon": Icons.add},
    {"text": "Logout", "icon": Icons.logout},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Sportify",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      drawer: const LeftDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// =======================
            /// INFO CARDS
            /// =======================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoCard("NPM", npm),
                _infoCard("Name", name),
                _infoCard("Class", className),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Selamat datang di Sportify!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            /// =======================
            /// BUTTON GRID (ProductCard dipakai)
            /// =======================
            GridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              padding: const EdgeInsets.all(8),
              crossAxisCount: 3,
              children: homeButtons.map((btn) {
                return ProductCard(
                  icon: btn["icon"],
                  text: btn["text"],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Glassmorphism Info Card
  Widget _infoCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.06),
              Colors.white.withOpacity(0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
