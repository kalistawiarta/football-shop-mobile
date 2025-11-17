import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:football_shop_mobile/screens/menu.dart';

import 'package:flutter/material.dart';
import 'package:football_shop_mobile/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  // FORM KEY + STATE VARIABLES
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _description = "";
  String _category = "";
  String _thumbnail = "";
  int _stock = 0;
  double _price = 0;
  bool _bestSeller = false;

  // Kategori bebas → kamu bisa ganti kalau mau
  final List<String> _categories = [
    "Sepak Bola",
    "Padel",
    "Golf",
    "Renang",
    "Tenis",
    "Olahraga",
    "Lainnya",
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= NAME =================
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nama Produk",
                    hintText: "Masukkan nama produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (val) => setState(() => _name = val),
                  validator: (val) =>
                      val == null || val.isEmpty ? "Nama tidak boleh kosong" : null,
                ),
              ),

              // ================= DESCRIPTION =================
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Deskripsi Produk",
                    hintText: "Masukkan deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (val) => setState(() => _description = val),
                  validator: (val) => val == null || val.isEmpty
                      ? "Deskripsi tidak boleh kosong"
                      : null,
                ),
              ),

              // ================= CATEGORY =================
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  value: _category.isEmpty ? null : _category,
                  items: _categories
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _category = val!),
                  validator: (val) =>
                      val == null ? "Kategori wajib diisi" : null,
                ),
              ),

              // ================= PRICE =================
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Harga",
                    hintText: "Masukkan harga produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (val) =>
                      setState(() => _price = double.tryParse(val) ?? 0),
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Harga wajib diisi";
                    if (double.tryParse(val) == null) return "Harga harus angka";
                    return null;
                  },
                ),
              ),

              // ================= STOCK =================
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Stok",
                    hintText: "Masukkan stok",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (val) =>
                      setState(() => _stock = int.tryParse(val) ?? 0),
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Stok wajib diisi";
                    if (int.tryParse(val) == null) return "Stok harus angka";
                    return null;
                  },
                ),
              ),

              // ================= THUMBNAIL =================
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "URL Thumbnail",
                    hintText: "Masukkan URL gambar produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (val) => setState(() => _thumbnail = val),
                ),
              ),

              // ================= BEST SELLER =================
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  value: _bestSeller,
                  title: const Text("Tandai sebagai Best Seller"),
                  onChanged: (val) => setState(() => _bestSeller = val),
                ),
              ),

              // ================= SUBMIT BUTTON =================
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await request.postJson(
                        "http://localhost:8000/create-flutter/", // ganti jika pakai emulator
                        jsonEncode({
                          "name": _name,
                          "description": _description,
                          "category": _category,
                          "thumbnail": _thumbnail,
                          "price": _price,
                          "stock": _stock,
                          "best_seller": _bestSeller,
                        }),
                      );

                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Product successfully saved!"),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Something went wrong."),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
