import 'package:flutter/material.dart';
import 'package:sp_sportswear_mobile/models/product_entry.dart'; //  Menggunakan model ProductEntry
import 'package:sp_sportswear_mobile/widgets/left_drawer.dart';
import 'package:sp_sportswear_mobile/screens/product_detail.dart';
import 'package:sp_sportswear_mobile/widgets/product_entry_card.dart'; // Menggunakan widget ProductEntryCard
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductListPage extends StatefulWidget {
  final String filterType;
  const ProductListPage({super.key, required this.filterType});

  @override
  State<ProductListPage> createState() => _ProductListPageState(); //
}

class _ProductListPageState extends State<ProductListPage> { //

  // Nama fungsi dan tipe data yang di-return
  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    // TODO: Ganti URL dengan URL aplikasi! Pastikan ada trailing slash (/)
    // Untuk emulator Android: http://10.0.2.2:8000
    // Untuk browser: http://localhost:8000
    String url = 'http://localhost:8000/json/';
    if (widget.filterType == "my") {
      url = 'http://localhost:8000/json/?filter=my';
    }
    // Decode response ke format json
    final response = await request.get(url);
    var data = response;

    // Konversi data json ke objek ProductEntry
    List<ProductEntry> listProducts = []; // Nama list
    for (var d in data) {
      if (d != null) {
        listProducts.add(ProductEntry.fromJson(d)); // Menggunakan ProductEntry.fromJson
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filterType == "my" ? 'My Products' : 'All Products'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request), //  Memanggil fetchProducts
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) { // Ditambahkan cek .isEmpty
              return Center( // cost dihilangin biar bisa either 2 choices itu (my) ato (all)
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.filterType == "my"
                          ? 'Anda belum memiliki produk.'
                          : 'Belum ada produk.',
                      style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ProductEntryCard( // ProductEntryCard
                  product: snapshot.data![index], // Menggunakan parameter 'product'
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage ( //  ProductDetailPage
                          product: snapshot.data![index], // DIUBAH: dari news ke product
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