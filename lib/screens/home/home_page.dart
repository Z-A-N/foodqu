import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_header_with_search.dart';
import 'burger_page.dart';
import 'hemat_page.dart';
import 'minuman_page.dart';
import 'snack_page.dart';
import 'kids_meal_page.dart';
import 'voucher_page.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'title': 'Burger',
        'image': 'assets/icon/Burger.png',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BurgerPage()),
        ),
        'isHot': true,
      },
      {
        'title': 'Minuman',
        'image': 'assets/icon/Minuman.png',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MinumanPage()),
        ),
      },
      {
        'title': 'Snack',
        'image': 'assets/icon/snack.png',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SnackPage()),
        ),
      },
      {
        'title': 'Kids Meal',
        'image': 'assets/icon/kids_meal.png',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const KidsMealPage()),
        ),
      },
      {
        'title': 'Hemat',
        'image': 'assets/icon/paket_hemat.png',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HematPage()),
        ),
      },
      {
        'title': 'Voucher',
        'image': 'assets/icon/Voucher.png',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VoucherPage()),
        ),
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeaderWithSearch(title: 'Beranda'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const SizedBox(height: 140, child: _BannerCarousel()),
                    const SizedBox(height: 24),
                    const Text(
                      'Menu Utama',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _HorizontalMenu(items: menuItems),
                    const SizedBox(height: 24),
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
                        Text(
                          'Lihat semua',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _RecommendationList(),
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

class _BannerCarousel extends StatefulWidget {
  const _BannerCarousel();

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
    _controller = PageController(initialPage: 1000);
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
        final banner = banners[index % banners.length];
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

class _HorizontalMenu extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const _HorizontalMenu({required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _MenuItem(
              title: item['title'],
              imagePath: item['image'],
              onTap: item['onTap'],
              isHot: item['isHot'] ?? false,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final bool isHot;

  const _MenuItem({
    required this.title,
    required this.imagePath,
    required this.onTap,
    this.isHot = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imagePath, height: 40),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (isHot)
            Positioned(
              top: 4,
              left: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'HOT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecommendationList extends StatelessWidget {
  const _RecommendationList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .orderBy('rating', descending: true)
            .limit(10)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailPage(
                        title: data['title'],
                        imagePath: data['image'],
                        rating: data['rating'].toDouble(),
                        reviews: data['reviews'],
                        price: data['price'],
                        description: data['description'],
                      ),
                    ),
                  );
                },
                child: _FoodCard(
                  title: data['title'],
                  imagePath: data['image'],
                  rating: data['rating'].toDouble(),
                  reviews: data['reviews'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _FoodCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final double rating;
  final int reviews;

  const _FoodCard({
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.reviews,
  });

  @override
  State<_FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<_FoodCard> {
  late final String _uid;
  late final String _docId;
  bool _isFav = false;

  @override
  void initState() {
    super.initState();
    _uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    _docId = widget.title.toLowerCase().replaceAll(' ', '-');
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(_docId)
        .get();
    if (mounted) setState(() => _isFav = doc.exists);
  }

  void _toggleFavorite() async {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(_docId);

    if (_isFav) {
      await ref.delete();
    } else {
      await ref.set({
        'title': widget.title,
        'image': widget.imagePath,
        'rating': widget.rating,
        'reviews': widget.reviews,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    if (mounted) setState(() => _isFav = !_isFav);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.imagePath,
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: _toggleFavorite,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      _isFav ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: _isFav ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 16),
              const SizedBox(width: 4),
              Text('${widget.rating}'),
              const SizedBox(width: 4),
              Text(
                '(${widget.reviews})',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
