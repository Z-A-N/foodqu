import 'package:flutter/material.dart';

class HistoryDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const HistoryDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
        backgroundColor: const Color(0xFFFFA726),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  order['image'],
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // ID Pemesanan
            Text(
              "ID Pemesanan: ${order['id']}",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),

            // Judul
            Text(
              order['title'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            // Deskripsi
            Text(
              order['description'] ?? '',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Info detail
            _buildDetailRow(Icons.calendar_today, "Tanggal", order['date']),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.attach_money, "Harga", order['price']),
            const SizedBox(height: 12),
            _buildDetailRow(
              Icons.info_outline,
              "Status",
              order['status'],
              valueColor: order['status'] == 'Selesai'
                  ? Colors.green
                  : Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value, {
    Color valueColor = Colors.black87,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.orange),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(value, style: TextStyle(fontSize: 14, color: valueColor)),
            ],
          ),
        ),
      ],
    );
  }
}
