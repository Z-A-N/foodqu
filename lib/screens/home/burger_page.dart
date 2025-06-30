import 'package:flutter/material.dart';
import '../widgets/custom_header_with_search.dart';

class BurgerPage extends StatelessWidget {
  const BurgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> burgerMenu = [
      {
        'title': 'Beef Burger Jumbo',
        'image': 'assets/images/Beef_Burger_Jumbo.png',
        'rating': 5.0,
        'reviews': 1927,
        'price': 35000,
      },
      {
        'title': 'Cheese Burger',
        'image': 'assets/images/Cheese_Burger.png',
        'rating': 4.8,
        'reviews': 856,
        'price': 28000,
      },
      {
        'title': 'Crispy Chicken Burger',
        'image': 'assets/images/Crispy_Chicken_Burger.png',
        'rating': 4.6,
        'reviews': 423,
        'price': 30000,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeaderWithSearch(
              title: 'Menu Burger',
              showBackButton: true,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: burgerMenu.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return const _BurgerBanner();
                  final item = burgerMenu[index - 1];
                  return _BurgerItemCard(
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
}

class _BurgerBanner extends StatelessWidget {
  const _BurgerBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/burger.png', height: 60),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Temukan burger favoritmu di Foodqu!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _BurgerItemCard extends StatelessWidget {
  final String image;
  final String title;
  final double rating;
  final int reviews;
  final int price;

  const _BurgerItemCard({
    required this.image,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
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
                  'Rp ${price.toStringAsFixed(0)}',
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
