import 'package:flutter/material.dart';

class MinumanPage extends StatelessWidget {
  const MinumanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> minumanList = [
      {
        'name': 'Es Teh Manis',
        'image': 'assets/images/esteh.png',
        'rating': 4.5,
        'reviews': 210,
      },
      {
        'name': 'Kopi Susu Gula Aren',
        'image': 'assets/images/kopisusu.png',
        'rating': 4.7,
        'reviews': 310,
      },
      {
        'name': 'Jus Alpukat Coklat',
        'image': 'assets/images/jusalpukat.png',
        'rating': 4.8,
        'reviews': 180,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minuman'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: minumanList.length,
        itemBuilder: (context, index) {
          final item = minumanList[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.asset(
                    item['image'],
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.orange, size: 16),
                            const SizedBox(width: 4),
                            Text('${item['rating']}'),
                            const SizedBox(width: 4),
                            Text('(${item['reviews']} ulasan)',
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
