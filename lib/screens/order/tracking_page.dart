import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(child: Text('Kamu belum login.'));
    }

    final ordersRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .orderBy('createdAt', descending: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking Pesanan'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ordersRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada pesanan.'));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final data = order.data() as Map<String, dynamic>;
              final status = data['status'] ?? 'Diproses';
              final total = data['total'] ?? 0;
              final createdAt = (data['createdAt'] as Timestamp).toDate();
              final now = DateTime.now();
              final difference = now.difference(createdAt);

              final canCancel =
                  status == 'Diproses' && difference.inMinutes < 2;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text('Rp $total'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: $status'),
                      Text(
                        'Tanggal: ${createdAt.day}/${createdAt.month}/${createdAt.year}',
                      ),
                      if (canCancel)
                        TextButton.icon(
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          label: const Text(
                            'Batalkan Pesanan',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async {
                            await order.reference.update({
                              'status': 'Dibatalkan',
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pesanan dibatalkan'),
                              ),
                            );
                          },
                        ),
                      if (!canCancel && status == 'Diproses')
                        const Text(
                          'Waktu pembatalan sudah habis.',
                          style: TextStyle(color: Colors.grey),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
