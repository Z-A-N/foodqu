import 'package:flutter/material.dart';
import '../widgets/custom_header_with_search.dart';
import 'history_detail_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyOrders = [
      {
        'id': 'FOODQU001',
        'title': 'Mie Ayam Noni',
        'image': 'assets/images/mie.png',
        'date': '20 Juni 2025, 14:35',
        'status': 'Selesai',
        'price': 'Rp18.000',
        'description': 'Mie ayam enak dan murah meriah!',
      },
      {
        'id': 'FOODQU001',
        'title': 'Amazy Geprek',
        'image': 'assets/images/ama.png',
        'date': '18 Juni 2025, 12:05',
        'status': 'Dibatalkan',
        'price': 'Rp22.000',
        'description': 'Ayam geprek crispy dengan sambal level 5.',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeaderWithSearch(title: 'Riwayat'),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: dummyOrders.length,
                  itemBuilder: (context, index) {
                    final order = dummyOrders[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            order['image'],
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "ID: ${order['id']}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(order['date']),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HistoryDetailPage(order: order),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
