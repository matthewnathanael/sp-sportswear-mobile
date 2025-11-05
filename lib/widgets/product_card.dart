import 'package:flutter/material.dart';
import 'package:sp_sportswear_mobile/screen/product_form.dart'; // Import halaman form

// Model untuk item di homepage
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color; // Properti warna tetap ada

  ItemHomepage(this.name, this.icon, this.color);
}

// Widget untuk kartu item
class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color, // Warna diambil dari item
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          // Menampilkan pesan SnackBar saat kartu ditekan.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          // Cek jika nama item adalah "Create Products" dan navigasi
          if (item.name == "Create Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductFormPage(),
              ),
            );
          }
          // Anda bisa menambahkan else if untuk tombol lain di sini
          // else if (item.name == "All Products") { ... }
          // else if (item.name == "My Products") { ... }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}