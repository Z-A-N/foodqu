import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final String title;
  final String imagePath;
  final double rating;
  final int reviews;

  const ProductDetailPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.reviews,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String selectedSize = 'Regular';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      body: SafeArea(
        child: Column(
          children: [
            // Gambar produk dan ikon
            Stack(
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Image.asset(widget.imagePath, height: 180),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                const Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite_border),
                  ),
                ),
              ],
            ),

            // Detail Produk
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul dan harga dummy
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(
                          'Rp 25.000',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 18),
                        Text('${widget.rating} (${widget.reviews})'),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Ukuran/Porsi (opsional)
                    const Text(
                      'Pilih Ukuran / Porsi',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: ['Regular', 'Large'].map((size) {
                        final selected = size == selectedSize;
                        return GestureDetector(
                          onTap: () => setState(() => selectedSize = size),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: selected ? Colors.orange : Colors.white,
                              border: Border.all(color: Colors.orange),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                color: selected ? Colors.white : Colors.orange,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // Deskripsi produk dummy
                    const Text(
                      'Nikmati burger spesial kami dengan daging sapi pilihan, roti lembut, dan keju meleleh. '
                      'Dibuat segar setiap hari untuk memanjakan lidah kamu.',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),

                    const Spacer(),

                    // Tombol Add to Cart
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Tambah ke keranjang
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Tambah ke Keranjang',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
