import 'package:flutter/material.dart';
import '../widgets/custom_header_with_search.dart';

class EnakLohPage extends StatelessWidget {
  const EnakLohPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recommendations = [
      {
        'title': 'Mie Ayam Noni',
        'image': 'assets/images/mie.png',
        'rating': 5.0,
        'reviews': 1927,
      },
      {
        'title': 'Amazy Geprek Baturaden',
        'image': 'assets/images/ama.png',
        'rating': 4.8,
        'reviews': 287,
      },
      {
        'title': 'Ketoprak Baper',
        'image': 'assets/images/keto.png',
        'rating': 4.5,
        'reviews': 156,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeaderWithSearch(title: 'Rekomendasi', showBackButton: true),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  final item = recommendations[index];
                  return _buildRecommendationItem(
                    image: item['image'],
                    title: item['title'],
                    rating: item['rating'],
                    reviews: item['reviews'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem({
    required String image,
    required String title,
    required double rating,
    required int reviews,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                Text(title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
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
          ),
        ],
      ),
    );
  }
}
