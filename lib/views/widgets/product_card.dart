import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product.dart';
import '../../controllers/cart_controller.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final CartController cartC = Get.find<CartController>();

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.blueGrey,
        elevation: 3,
        // clipBehavior ini memastikan container putih di bawah mengikuti lengkungan border radius Card
        clipBehavior: Clip.antiAlias, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. BAGIAN GAMBAR
            // Hanya gunakan Expanded di sini. Artinya: "Ambil SEMUA sisa ruang setelah teks & tombol dirender"
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  },
                ),
              ),
            ),

            // 2. BAGIAN TEKS DAN TOMBOL
            // TIDAK ADA Expanded/Flexible di sini. Biarkan ukurannya menyesuaikan isinya.
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min, // KUNCI: Ambil tinggi seminimal mungkin
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.title,
                    maxLines: 1, // Dibatasi 1 baris agar tinggi seragam untuk semua card
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 4), // Pengganti Spacer, gunakan ukuran pasti
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),

                  // 3. BAGIAN TOMBOL
                  Obx(() {
                    int quantity = cartC.getProductQuantity(product);
                    
                    if (quantity == 0) {
                      return SizedBox(
                        height: 32, // Paksa tinggi tombol agar konsisten
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () => cartC.addProduct(product),
                          child: const Text(
                            'Tambahkan',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 32, // Tinggi disamakan dengan tombol Add di atas
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () => cartC.decreaseQuantity(product),
                                child: const Icon(Icons.remove, size: 20, color: Colors.red),
                              ),
                              Text(
                                '$quantity',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              InkWell(
                                onTap: () => cartC.addProduct(product),
                                child: const Icon(Icons.add, size: 20, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}