import 'package:flutter/material.dart';
import '../widgets/custom_header_with_search.dart';

class TerdekatPage extends StatelessWidget {
  const TerdekatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> restoranList = [
      {
        'name': 'Kedai Tyoba',
        'category': 'Timur-Tengah',
        'distance': '2km',
        'time': '29min',
        'image': 'assets/images/resto.png',
      },
      {
        'name': 'Waroeng Pecel Mbah Dadang',
        'category': 'Vegetarian',
        'distance': '5km',
        'time': '44min',
        'image': 'assets/images/resto.png',
      },
      {
        'name': 'Ayam Ungkep Bu Atun',
        'category': 'Hidangan Laut',
        'distance': '5km',
        'time': '44min',
        'image': 'assets/images/resto.png',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeaderWithSearch(
              title: 'Terdekat',
              showBackButton: true,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: restoranList.length,
                itemBuilder: (context, index) {
                  final resto = restoranList[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              resto['image']!,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  resto['name']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  resto['category']!,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${resto['distance']}  •  ${resto['time']}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
