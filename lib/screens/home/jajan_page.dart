import 'package:flutter/material.dart';

class JajanPage extends StatelessWidget {
  const JajanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> jajanList = [
      {
        'name': 'Cilok Bumbu Kacang',
        'image': 'assets/images/cilok.png',
        'rating': 4.6,
        'reviews': 134,
      },
      {
        'name': 'Pisang Coklat Keju',
        'image': 'assets/images/piscok.png',
        'rating': 4.8,
        'reviews': 205,
      },
      {
        'name': 'Tahu Crispy Pedas',
        'image': 'assets/images/tahu.png',
        'rating': 4.7,
        'reviews': 169,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jajan'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: jajanList.length,
        itemBuilder: (context, index) {
          final item = jajanList[index];
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
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
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text('${item['rating']}'),
                            const SizedBox(width: 4),
                            Text(
                              '(${item['reviews']} ulasan)',
                              style: const TextStyle(color: Colors.grey),
                            ),
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
