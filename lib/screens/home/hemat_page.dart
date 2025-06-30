import 'package:flutter/material.dart';
import '../widgets/custom_header_with_search.dart';

class HematPage extends StatelessWidget {
  const HematPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> paketHemat = [
      {
        'title': 'Hemat Burger 1',
        'image': 'assets/images/paket1.png',
        'rating': 4.9,
        'reviews': 894,
        'price': '25.000',
      },
      {
        'title': 'Hemat Burger 2',
        'image': 'assets/images/paket2.png',
        'rating': 4.8,
        'reviews': 730,
        'price': '28.000',
      },
      {
        'title': 'Hemat Komplit',
        'image': 'assets/images/paket_komplit.png',
        'rating': 4.7,
        'reviews': 610,
        'price': '30.000',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeaderWithSearch(
              title: 'Paket Hemat',
              showBackButton: true,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: paketHemat.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return _buildTopBanner();

                  final item = paketHemat[index - 1];
                  return _buildHematItem(
                    image: item['image'],
                    title: item['title'],
                    rating: item['rating'],
                    reviews: item['reviews'],
                    price: item['price'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/hemat.png', height: 60),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Makan enak tanpa bikin dompet menjerit!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHematItem({
    required String image,
    required String title,
    required double rating,
    required int reviews,
    required String price,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 100,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text('$rating'),
                    const SizedBox(width: 4),
                    Text(
                      '($reviews)',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp $price',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
