// File: lib/screens/product_detail.dart

import 'package:flutter/material.dart';
import 'package:sp_sportswear_mobile/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Definisi Warna Tema (Sesuai Web)
    const primaryColor = Color(0xFF44403C); // Stone-700
    const stoneDark = Color(0xFF1C1917);    // Stone-900 (Teks Judul)
    const stoneLight = Color(0xFF57534E);   // Stone-600 (Teks Deskripsi)
    const amberColor = Color(0xFFF59E0B);   // Amber-500 (Bintang/Aksen)
    const amberSoft = Color(0xFFFEF3C7);    // Amber-100 (Background Badge)

    return Scaffold(
      // Menggunakan warna background global (Amber-50 dari main.dart)
      // atau kita set manual di sini jika perlu
      backgroundColor: const Color(0xFFFFFBEB),

      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: primaryColor, // Ganti Indigo dengan Stone-700
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Gambar (Dengan background putih agar rapi)
            Container(
              width: double.infinity,
              color: Colors.white, // Background putih di belakang gambar
              child: product.thumbnail.isNotEmpty
                  ? Image.network(
                'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain, // Contain agar gambar tidak terpotong
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 300,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  ),
                ),
              )
                  : Container( // Fallback jika tidak ada thumbnail
                height: 300,
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
              ),
            ),

            //  Bagian Konten (Dalam Container putih dengan padding)
            Container(
              margin: const EdgeInsets.only(top: 2), // Sedikit jarak dari gambar
              color: Colors.white, // Container putih seperti 'Card' di web
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //  Baris Badge (Featured & Kategori)
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      // Badge Kategori
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: amberSoft, // Background Amber lembut
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.amber.shade200),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78350F), // Amber-900 Text
                          ),
                        ),
                      ),

                      // Badge Featured
                      if (product.isFeatured)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: amberColor, // Warna Amber lebih kuat
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Text(
                            'Featured',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Nama Produk
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w800, // Lebih tebal
                      color: stoneDark, // Warna Stone gelap
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Harga
                  Text(
                    'Rp ${product.price}',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor, // Warna Stone-700 (Primary)
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Brand
                  Text(
                    "Brand: ${product.brand}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(), // Garis pemisah tipis
                  const SizedBox(height: 16),

                  // Stock dan Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Stock
                      Row(
                        children: [
                          const Icon(Icons.inventory_2_outlined, size: 20, color: Colors.grey),
                          const SizedBox(width: 8),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 16, color: stoneDark),
                              children: [
                                const TextSpan(text: 'Stok: '),
                                TextSpan(
                                  text: '${product.stock}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Rating
                      Row(
                        children: [
                          const Icon(Icons.star, color: amberColor, size: 24),
                          const SizedBox(width: 4),
                          Text(
                            '${product.rating ?? 'N/A'}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: stoneDark
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Deskripsi Header
                  const Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: stoneDark,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Isi Deskripsi
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.6,
                      color: stoneLight, // Warna teks abu-abu hangat
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  const SizedBox(height: 32),

                  // Informasi Penjual (Box Terpisah)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: amberSoft, // Background Amber lembut
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi Penjual',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78350F), // Amber-900
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 16,
                              child: Icon(Icons.person, size: 20, color: primaryColor),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.userUsername ?? 'Tidak diketahui',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: stoneDark
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}