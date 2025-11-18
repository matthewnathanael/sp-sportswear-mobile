// File: lib/widgets/left_drawer.dart

import 'package:flutter/material.dart';
import 'package:sp_sportswear_mobile/screens/menu.dart';
import 'package:sp_sportswear_mobile/screens/product_form.dart';
// BARU: Import halaman daftar produk
import 'package:sp_sportswear_mobile/screens/product_entry_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue, // Anda bisa ganti warnanya jika mau
            ),
            child: Column(
              children: [
                Text(
                  'SP Sportswear', // Judul
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Toko sportswear terlengkap!", // Deskripsi
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'), //
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('Daftar Produk'),
            onTap: () {
              // Route ke halaman daftar produk
              Navigator.pushReplacement( // Diganti menjadi pushReplacement
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductListPage(filterType: "all"),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart), // Ikon
            title: const Text('Tambah Produk'), // Teks
            // Bagian redirection ke ProductFormPage
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductFormPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}