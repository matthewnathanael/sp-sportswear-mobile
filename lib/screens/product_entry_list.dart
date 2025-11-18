import 'package:flutter/material.dart';
import 'package:sp_sportswear_mobile/models/product_entry.dart';
import 'package:sp_sportswear_mobile/widgets/left_drawer.dart';
import 'package:sp_sportswear_mobile/screens/product_detail.dart';
import 'package:sp_sportswear_mobile/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductListPage extends StatefulWidget {
  final String filterType;
  const ProductListPage({super.key, required this.filterType});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  // Definisi Warna Tema Lokal
  final Color primaryColor = const Color(0xFF44403C); // Stone-700
  final Color backgroundColor = const Color(0xFFFFFBEB); // Amber-50
  final Color textDark = const Color(0xFF1C1917); // Stone-900

  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    // Ganti URL sesuai environment (Emulator: 10.0.2.2, Web: localhost)
    String url = 'https://matthew-nathanael-spsportswear.pbp.cs.ui.ac.id/json/';
    if (widget.filterType == "my") {
      url = 'https://matthew-nathanael-spsportswear.pbp.cs.ui.ac.id/json/?filter=my';
    }

    final response = await request.get(url);
    var data = response;

    List<ProductEntry> listProducts = [];
    for (var d in data) {
      if (d != null) {
        listProducts.add(ProductEntry.fromJson(d));
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: backgroundColor, // Set background Amber-50
      appBar: AppBar(
        title: Text(
          widget.filterType == "my" ? 'Produk Saya' : 'Daftar Produk',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor, // Set AppBar Stone-700
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ));
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        Icons.inventory_2_outlined,
                        size: 80,
                        color: Colors.grey[400]
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.filterType == "my"
                          ? 'Anda belum memiliki produk.'
                          : 'Belum ada produk tersedia.',
                      style: TextStyle(
                        fontSize: 18,
                        color: textDark.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ProductEntryCard(
                  product: snapshot.data![index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}