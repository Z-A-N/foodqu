import 'package:flutter/material.dart';
import '../widgets/custom_header_with_search.dart';

class KidsMealPage extends StatelessWidget {
  const KidsMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> kidsMenu = [
      {
        'title': 'Mini Burger Set',
        'image': 'assets/images/Mini_Burger_Set.png',
        'rating': 4.9,
        'reviews': 732,
        'price': '18.000',
      },
      {
        'title': 'Happy Nugget Meal',
        'image': 'assets/images/Happy_Nugget_Meal.png',
        'rating': 4.8,
        'reviews': 528,
        'price': '20.000',
      },
      {
        'title': 'Fun Meal Box',
        'image': 'assets/images/Fun_Meal_Box.png',
        'rating': 4.7,
        'reviews': 480,
        'price': '22.000',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeaderWithSearch(
              title: 'Kids Meal',
              showBackButton: true,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: kidsMenu.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return _buildTopBanner();

                  final item = kidsMenu[index - 1];
                  return _buildKidsMealItem(
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
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/kids_meal.png', height: 60),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Menu spesial ceria untuk si kecil!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKidsMealItem({
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
