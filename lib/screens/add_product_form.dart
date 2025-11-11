import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Product",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // === Product Name ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) => _name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Product name cannot be empty!";
                  }
                  if (value.length < 3) {
                    return "Name must be at least 3 characters!";
                  }
                  if (value.length > 255) {
                    return "Name must be less than 255 characters!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Category ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) => _category = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Category cannot be empty!";
                  }
                  if (value.length < 3) {
                    return "Category must be at least 3 characters!";
                  }
                  if (value.length > 100) {
                    return "Category must be less than 100 characters!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Brand ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Brand",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) => _brand = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Brand cannot be empty!";
                  }
                  if (value.length < 2) {
                    return "Brand must be at least 2 characters!";
                  }
                  if (value.length > 100) {
                    return "Brand must be less than 100 characters!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Stock ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Stock",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _stock = int.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Stock cannot be empty!";
                  }
                  final stock = int.tryParse(value);
                  if (stock == null) return "Stock must be a valid number!";
                  if (stock < 0) return "Stock cannot be negative!";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Price ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Price (e.g. 125000.00)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = double.tryParse(value) ?? 0.0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Price cannot be empty!";
                  }
                  final price = double.tryParse(value);
                  if (price == null) return "Enter a valid number!";
                  if (price <= 0) return "Price must be greater than 0!";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Thumbnail URL (optional) ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Thumbnail URL (optional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) => _thumbnail = value,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final uri = Uri.tryParse(value);
                    if (uri == null || !uri.isAbsolute) {
                      return "Please enter a valid URL!";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Description ===
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) => _description = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description cannot be empty!";
                  }
                  if (value.length < 10) {
                    return "Description must be at least 10 characters!";
                  }
                  if (value.length > 1000) {
                    return "Description too long (max 1000 characters)!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // === Switch: Featured ===
              SwitchListTile(
                title: const Text("Mark as Featured Product"),
                value: _isFeatured,
                activeColor: const Color(0xFF1976D2),
                onChanged: (value) => setState(() => _isFeatured = value),
              ),

              // === Switch: Best Seller ===
              SwitchListTile(
                title: const Text("Mark as Best Seller"),
                value: _bestSeller,
                activeColor: const Color(0xFF1976D2),
                onChanged: (value) => setState(() => _bestSeller = value),
              ),

              const SizedBox(height: 20),

              // === Save Button ===
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Product Saved Successfully!"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text("Name: $_name"),
                                Text("Category: $_category"),
                                Text("Brand: $_brand"),
                                Text("Stock: $_stock"),
                                Text("Price: $_price"),
                                Text("Thumbnail: $_thumbnail"),
                                Text("Description: $_description"),
                                Text("Featured: ${_isFeatured ? "Yes" : "No"}"),
                                Text("Best Seller: ${_bestSeller ? "Yes" : "No"}"),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _formKey.currentState!.reset();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Save Product",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
