import 'package:flutter/material.dart';
import 'package:football_shop_mobile/screens/menu.dart';
import 'package:football_shop_mobile/screens/add_product_form.dart';
import 'package:football_shop_mobile/screens/product_entry_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF1E293B).withOpacity(0.85),
              const Color(0xFF0F172A).withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.shade700,
                    Colors.blueAccent.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text(
                  "Football Shop",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            _menuTile(context, "Home", Icons.home_outlined, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MyHomePage()),
              );
            }),

            _menuTile(context, "Add Product", Icons.add_box_outlined, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AddProductPage()),
              );
            }),

            _menuTile(context, "Product List", Icons.list_alt, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductEntryListPage()),
              );
            }),

          ],
        ),
      ),
    );
  }

  Widget _menuTile(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
