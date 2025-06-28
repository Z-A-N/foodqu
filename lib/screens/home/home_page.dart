import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/custom_header_with_search.dart';
import 'terdekat_page.dart';
import 'enak_loh_page.dart';
import 'diskon_page.dart';
import 'voucher_page.dart';
import 'makanan_page.dart';
import 'minuman_page.dart';
import 'jajan_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar
                const CustomHeaderWithSearch(title: 'Beranda'),
                const SizedBox(height: 20),

                // Banner Promo
                SizedBox(height: 140, child: _BannerCarousel()),
                const SizedBox(height: 24),

                // Menu Kategori (Semua pakai gambar)
                const Text(
                  'Layanan Teratas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  
                  children: [
                    _buildMenuItemWithImage(
                      'Terdekat',
                      'assets/icon/terdekat.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TerdekatPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItemWithImage(
                      'Enak loh',
                      'assets/icon/rekomen.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EnakLohPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItemWithImage(
                      'Diskon',
                      'assets/icon/diskon.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DiskonPage()),
                        );
                      },
                    ),
                    _buildMenuItemWithImage(
                      'Voucher',
                      'assets/icon/voucher.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VoucherPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItemWithImage(
                      'Makanan',
                      'assets/icon/makanan.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MakananPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItemWithImage(
                      'Minuman',
                      'assets/icon/minuman.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MinumanPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItemWithImage(
                      'Jajan',
                      'assets/icon/jajan.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const JajanPage()),
                        );
                      },
                    ),
                    _buildMenuItemWithImage(
                      'Lainnya',
                      'assets/icon/lainnya.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TerdekatPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Rekomendasi
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rekomendasi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('See all', style: TextStyle(color: Colors.orange)),
                  ],
                ),
                const SizedBox(height: 12),

                SizedBox(
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFoodCard(
                        'Mie Ayam Noni',
                        'assets/images/mie.png',
                        5.0,
                        1927,
                      ),
                      _buildFoodCard(
                        'Amazy Geprek Baturaden',
                        'assets/images/ama.png',
                        4.8,
                        287,
                      ),
                      _buildFoodCard(
                        'Ketoprak Baper',
                        'assets/images/keto.png',
                        4.5,
                        156,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemWithImage(
    String title,
    String imagePath, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70, // ukuran tetap agar Wrap bekerja rapi
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange[100],
              radius: 28,
              child: Image.asset(imagePath, height: 28),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodCard(
    String title,
    String imagePath,
    double rating,
    int reviews,
  ) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              height: 100,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 16),
              const SizedBox(width: 4),
              Text('$rating'),
              const SizedBox(width: 4),
              Text('($reviews)', style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class _BannerCarousel extends StatefulWidget {
  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  late final PageController _controller;

  final List<Map<String, String>> banners = [
    {
      'image': 'assets/images/burger.png',
      'title': 'Makan Sepuasmu!',
      'subtitle': 'Dapatkan diskon hingga 90%',
    },
    {
      'image': 'assets/images/burger.png',
      'title': 'Promo Spesial!',
      'subtitle': 'Cuma hari ini, yuk buruan!',
    },
    {
      'image': 'assets/images/burger.png',
      'title': 'Diskon Gede!',
      'subtitle': 'Makanan favorit lebih hemat',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 1000); // start dari tengah
    Future.delayed(Duration.zero, () {
      Timer.periodic(const Duration(seconds: 4), (timer) {
        if (!mounted) return;
        _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemBuilder: (context, index) {
        final banner = banners[index % banners.length]; // infinite loop
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.orange[100],
          ),
          child: Row(
            children: [
              Image.asset(banner['image']!, height: 100),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      banner['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      banner['subtitle']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
