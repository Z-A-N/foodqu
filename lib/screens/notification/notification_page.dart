import 'package:flutter/material.dart';
import '../widgets/custom_header_with_search.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'Pesanan kamu sedang diproses',
        'subtitle': 'Driver sedang menuju restoran untuk mengambil pesananmu.',
        'time': '2 menit lalu',
      },
      {
        'title': 'Promo Spesial Hari Ini!',
        'subtitle': 'Dapatkan diskon 30% untuk semua menu ayam.',
        'time': '1 jam lalu',
      },
      {
        'title': 'Selamat Datang di Foodqu!',
        'subtitle': 'Nikmati berbagai pilihan makanan favoritmu.',
        'time': 'Kemarin',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeaderWithSearch(
              title: 'Notifikasi',
              showBackButton: true,
              showNotificationIcon: false,
            ),
            if (notifications.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'Belum ada notifikasi.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
                    return _NotificationCard(
                      title: notif['title']!,
                      subtitle: notif['subtitle']!,
                      time: notif['time']!,
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

class _NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const _NotificationCard({
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.notifications_active, color: Colors.orange),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(
          time,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
