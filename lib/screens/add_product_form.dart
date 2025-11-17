import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop_mobile/widgets/left_drawer.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _category = "";
  String _brand = "";
  int _stock = 0;
  double _price = 0.0;
  String _thumbnail = "";
  String _description = "";
  bool _isFeatured = false;
  bool _bestSeller = false;

  final _nameC = TextEditingController();
  final _categoryC = TextEditingController();
  final _brandC = TextEditingController();
  final _stockC = TextEditingController();
  final _priceC = TextEditingController();
  final _thumbnailC = TextEditingController();
  final _descriptionC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Add Product"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white24),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.07),
                Colors.white.withOpacity(0.03),
              ],
            ),
          ),

          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _input(
                  "Product Name",
                  _nameC,
                  onChanged: (v) => _name = v,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Name cannot be empty";
                    if (v.length < 3) return "Minimum 3 characters";
                    if (v.length > 255) return "Max 255 characters";
                    return null;
                  },
                ),
                _input(
                  "Category",
                  _categoryC,
                  onChanged: (v) => _category = v,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Category required";
                    if (v.length < 3) return "Minimum 3 characters";
                    return null;
                  },
                ),
                _input(
                  "Brand",
                  _brandC,
                  onChanged: (v) => _brand = v,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Brand required";
                    if (v.length < 2) return "Minimum 2 characters";
                    return null;
                  },
                ),
                _input(
                  "Stock",
                  _stockC,
                  type: TextInputType.number,
                  onChanged: (v) => _stock = int.tryParse(v) ?? 0,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Stock required";
                    final s = int.tryParse(v);
                    if (s == null) return "Must be a number";
                    if (s < 0) return "Cannot be negative";
                    return null;
                  },
                ),
                _input(
                  "Price (e.g. 250000)",
                  _priceC,
                  type: TextInputType.number,
                  onChanged: (v) => _price = double.tryParse(v) ?? 0,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Price required";
                    final p = double.tryParse(v);
                    if (p == null) return "Must be a valid number";
                    if (p <= 0) return "Price must be positive";
                    return null;
                  },
                ),
                _input(
                  "Thumbnail URL (optional)",
                  _thumbnailC,
                  onChanged: (v) => _thumbnail = v,
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    final uri = Uri.tryParse(v);
                    if (uri == null || !uri.isAbsolute) {
                      return "Invalid URL format";
                    }
                    return null;
                  },
                ),
                _input(
                  "Description",
                  _descriptionC,
                  onChanged: (v) => _description = v,
                  maxLines: 4,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Description required";
                    if (v.length < 10) return "Minimum 10 characters";
                    return null;
                  },
                ),

                SwitchListTile(
                  title: const Text("Mark as Featured",
                    style: TextStyle(color: Colors.white)),
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v),
                ),
                SwitchListTile(
                  title: const Text("Mark as Best Seller",
                    style: TextStyle(color: Colors.white)),
                  value: _bestSeller,
                  onChanged: (v) => setState(() => _bestSeller = v),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final response = await request.postJson(
                      "http://localhost:8000/create-flutter/",
                      jsonEncode({
                        "name": _name,
                        "category": _category,
                        "brand": _brand,
                        "stock": _stock,
                        "price": _price,
                        "thumbnail": _thumbnail,
                        "description": _description,
                        "is_featured": _isFeatured,
                        "best_seller": _bestSeller,
                      }),
                    );

                    if (response["status"] == "success") {
                      // CLEAR FORM
                      _nameC.clear();
                      _categoryC.clear();
                      _brandC.clear();
                      _stockC.clear();
                      _priceC.clear();
                      _thumbnailC.clear();
                      _descriptionC.clear();
                      setState(() {
                        _isFeatured = false;
                        _bestSeller = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Product added successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Save Product"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(
    String label,
    TextEditingController controller, {
    required Function(String) onChanged,
    TextInputType type = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: type,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
