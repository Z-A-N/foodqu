import 'package:flutter/material.dart';

class DiskonPage extends StatelessWidget {
  const DiskonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diskon'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDiskonCard(
            image: 'assets/images/burger.png',
            title: 'Diskon 50% Makanan Favorit',
            subtitle: 'Hanya hari ini untuk pengguna baru!',
          ),
          _buildDiskonCard(
            image: 'assets/images/ama.png',
            title: 'Gratis Ongkir',
            subtitle: 'Untuk pemesanan di atas Rp50.000',
          ),
          _buildDiskonCard(
            image: 'assets/images/keto.png',
            title: 'Voucher Cashback 20%',
            subtitle: 'Khusus pelanggan setia setiap Jumat',
          ),
        ],
      ),
    );
  }

  Widget _buildDiskonCard({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(image, width: 100, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
