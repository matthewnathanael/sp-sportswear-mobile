import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sp_sportswear_mobile/screens/menu.dart';
import 'package:sp_sportswear_mobile/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  String _category = "jersey";
  String _thumbnail = "";
  bool _isFeatured = false;
  int _stock = 0;
  double? _rating;
  String _brand = "";

  final List<String> _categories = [
    'Jersey', 'Sepatu', 'Baju', 'Aksesoris', 'Bola',
    'Lainnya', 'Sweater', 'Celana', 'Tas', 'Sleeve', 'Kaos Kaki',
  ];

  // --- Definisi Warna & Style Lokal ---
  final Color primaryColor = const Color(0xFF44403C); // Stone-700
  final Color backgroundColor = const Color(0xFFFFFBEB); // Amber-50
  final Color borderColor = const Color(0xFFA8A29E); // Stone-400

  // Helper untuk style input agar rapi dan konsisten
  InputDecoration _inputDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: primaryColor),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      labelStyle: TextStyle(color: primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: backgroundColor, // Set background Amber-50
      appBar: AppBar(
        title: const Text('Form Tambah Produk'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail Produk Baru",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Isi formulir di bawah untuk menambahkan produk ke katalog.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // Input Fields
                  TextFormField(
                    decoration: _inputDecoration("Nama Produk", "Contoh: Jersey SP Sport", Icons.shopping_bag_outlined),
                    onChanged: (String? value) => setState(() => _name = value!),
                    validator: (String? value) => (value == null || value.isEmpty) ? "Nama tidak boleh kosong!" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: _inputDecoration("Harga (Rp)", "Contoh: 150000", Icons.monetization_on_outlined),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) => setState(() => _price = int.tryParse(value!) ?? 0),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Harga tidak boleh kosong!";
                      if (int.tryParse(value) == null || int.parse(value) <= 0) return "Harga harus angka positif!";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: _inputDecoration("Stok", "Contoh: 50", Icons.inventory_2_outlined),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) => setState(() => _stock = int.tryParse(value!) ?? 0),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Stok tidak boleh kosong!";
                      if (int.tryParse(value) == null) return "Stok harus berupa angka!";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: _inputDecoration("Brand (Opsional)", "Merk", Icons.branding_watermark_outlined),
                          onChanged: (String? value) => setState(() => _brand = value!),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: _inputDecoration("Rating (0-10)", "Contoh: 8.5", Icons.star_border),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (String? value) => setState(() => _rating = double.tryParse(value!)),
                          validator: (String? value) {
                            if (value != null && value.isNotEmpty) {
                              final val = double.tryParse(value);
                              if (val == null) return "Harus angka";
                              if (val < 0.0 || val > 10.0) return "0 - 10";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration("Kategori", "", Icons.category_outlined),
                    value: _category,
                    items: _categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat.toLowerCase(),
                        child: Text(cat),
                      );
                    }).toList(),
                    onChanged: (String? newValue) => setState(() => _category = newValue!),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    maxLines: 3,
                    decoration: _inputDecoration("Deskripsi", "Jelaskan produk Anda...", Icons.description_outlined),
                    onChanged: (String? value) => setState(() => _description = value!),
                    validator: (String? value) => (value == null || value.isEmpty) ? "Deskripsi tidak boleh kosong!" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: _inputDecoration("URL Thumbnail", "https://example.com/image.jpg", Icons.image_outlined),
                    onChanged: (String? value) => setState(() => _thumbnail = value!),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SwitchListTile(
                      title: const Text("Tandai sebagai Featured"),
                      secondary: Icon(Icons.star, color: _isFeatured ? Colors.amber : Colors.grey),
                      value: _isFeatured,
                      activeColor: Colors.amber,
                      onChanged: (bool value) => setState(() => _isFeatured = value),
                    ),
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Ganti URL sesuai environment (10.0.2.2 untuk emulator, localhost untuk web)
                          const String url = "http://localhost:8000/create-flutter/";

                          try {
                            final response = await request.postJson(
                              url,
                              jsonEncode({
                                "name": _name,
                                "price": _price,
                                "description": _description,
                                "thumbnail": _thumbnail,
                                "category": _category.toLowerCase(),
                                "is_featured": _isFeatured,
                                "stock": _stock,
                                "rating": _rating,
                                "brand": _brand,
                              }),
                            );
                            if (context.mounted) {
                              if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Produk berhasil disimpan!"),
                                  backgroundColor: Colors.green,
                                ));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyHomePage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(response['message'] ?? "Terjadi kesalahan."),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Gagal terhubung: $e"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }
                        }
                      },
                      child: const Text(
                        "Simpan Produk",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}