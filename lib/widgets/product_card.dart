import 'package:flutter/material.dart';
import 'package:sp_sportswear_mobile/screens/product_form.dart';
import 'package:sp_sportswear_mobile/screens/product_entry_list.dart';
import 'package:sp_sportswear_mobile/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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
    final request = context.watch<CookieRequest>();
    return Material(
      color: item.color, // Warna diambil dari item
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
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

          // else if (item.name == "All Products") { ... }
          // else if (item.name == "My Products") { ... }
          else if (item.name == "All Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductListPage(filterType: "all"),
              ),
            );
          }

          else if (item.name == "My Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductListPage(filterType: "my"),
              ),
            );
          }
          else if (item.name == "Logout") {
            // TODO: Replace the URL with your app's URL and don't forget to add a trailing slash (/)!
            // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
            // If you using chrome,  use URL http://localhost:8000

            final response = await request.logout(
                "http://matthew-nathanael-spsportswear.pbp.cs.ui.ac.id/auth/logout/");
            String message = response["message"];
            if (context.mounted) {
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message See you again, $uname."),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
            }
          }

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