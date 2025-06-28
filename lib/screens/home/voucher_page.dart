import 'package:flutter/material.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildVoucherCard(
            code: 'MAKANHEMAT50',
            description: 'Diskon 50% untuk semua menu',
            expiry: 'Berlaku hingga 30 Juni 2025',
          ),
          _buildVoucherCard(
            code: 'ONGKIRGRATIS',
            description: 'Gratis ongkir untuk semua pengguna',
            expiry: 'Berlaku hingga 10 Juli 2025',
          ),
          _buildVoucherCard(
            code: 'CASHBACK20',
            description: 'Cashback 20% (maks. Rp20.000)',
            expiry: 'Berlaku hingga 15 Juli 2025',
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherCard({
    required String code,
    required String description,
    required String expiry,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              code,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(expiry, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
