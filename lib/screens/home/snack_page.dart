import 'package:flutter/material.dart';
import '../widgets/custom_header_with_search.dart';

class SnackPage extends StatelessWidget {
  const SnackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> snackMenu = [
      {
        'title': 'French Fries',
        'image': 'assets/images/French_Fries.png',
        'rating': 4.8,
        'reviews': 875,
        'price': '12.000',
      },
      {
        'title': 'Cheese Sticks',
        'image': 'assets/images/Cheese_Sticks.png',
        'rating': 4.6,
        'reviews': 539,
        'price': '10.000',
      },
      {
        'title': 'Nugget Box',
        'image': 'assets/images/Nugget_Box.png',
        'rating': 4.7,
        'reviews': 618,
        'price': '15.000',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeaderWithSearch(title: 'Snack', showBackButton: true),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: snackMenu.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return _buildTopBanner();

                  final item = snackMenu[index - 1];
                  return _buildSnackItem(
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
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/snack.png', height: 60),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Cemilan lezat siap temani harimu!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSnackItem({
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
