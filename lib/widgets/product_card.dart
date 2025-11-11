import 'package:flutter/material.dart';
import '../screens/add_product_form.dart';

class ProductCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProductCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text("Kamu menekan tombol $text!"),
            ));

          if (text == "Add Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProductPage()),
            );
          } else if (text == "See Products") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Halaman produk belum dibuat.")),
            );
          } else if (text == "Logout") {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Konfirmasi Logout"),
                content: const Text("Yakin ingin keluar dari aplikasi?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Berhasil logout!")),
                      );
                    },
                    child: const Text("Ya"),
                  ),
                ],
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 110,
          height: 110,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 32),
              const SizedBox(height: 8),
              Text(text,
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
