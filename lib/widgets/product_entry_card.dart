// File: lib/widgets/product_entry_card.dart

import 'package:flutter/material.dart';
import 'package:sp_sportswear_mobile/models/product_entry.dart';

class ProductEntryCard extends StatelessWidget {
  final ProductEntry product;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // --- Definisi Warna Lokal (Agar tidak bergantung pada main.dart) ---
    const Color stone700 = Color(0xFF44403C); // Warna Utama (Gelap)
    const Color stone500 = Color(0xFF78716C); // Warna Teks Sekunder (Abu-abu)
    const Color amber500 = Color(0xFFF59E0B); // Warna Aksen (Kuning/Oranye)
    const Color amber100 = Color(0xFFFEF3C7); // Background Badge
    const Color surfaceWhite = Colors.white;  // Background Kartu

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3), // Bayangan lembut ke bawah
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Header
              Stack(
                children: [
                  // Thumbnail Gambar
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: product.thumbnail.isNotEmpty
                        ? Image.network(
                      'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 180,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 40, color: Colors.white),
                        ),
                      ),
                    )
                        : Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 40, color: Colors.white),
                      ),
                    ),
                  ),

                  // Badge Kategori (Kiri Atas)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: amber100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: Text(
                        product.category.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF78350F), // Amber-900 text
                        ),
                      ),
                    ),
                  ),

                  // Badge Featured (Kanan Atas)
                  if (product.isFeatured)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: amber500,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Featured',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              //  Bagian Konten Teks
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Baris 1: Nama Produk & Harga
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: stone700, // Stone Color
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Rp ${product.price}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800, // Extra Bold
                            color: stone700,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Baris 2: Brand (Jika ada)
                    if (product.brand.isNotEmpty)
                      Text(
                        product.brand,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                          color: stone500,
                        ),
                      ),

                    const SizedBox(height: 8),

                    // Baris 3: Deskripsi Singkat
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: stone500,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Color(0xFFE7E5E4)), // Garis tipis
                    const SizedBox(height: 12),

                    // Baris 4: Info Footer (Rating & Stock)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rating
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: amber500, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              product.rating != null ? '${product.rating}' : 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: stone700,
                              ),
                            ),
                          ],
                        ),

                        // Stock
                        Row(
                          children: [
                            Icon(Icons.inventory_2_outlined, size: 16, color: stone500),
                            const SizedBox(width: 4),
                            Text(
                              'Stok: ${product.stock}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: stone500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}