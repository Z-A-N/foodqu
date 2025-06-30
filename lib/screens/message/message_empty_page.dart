import 'package:flutter/material.dart';
import '../widgets/custom_header_with_search.dart';

class MessageEmptyPage extends StatelessWidget {
  const MessageEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeaderWithSearch(title: 'Pesan'),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Image.asset('assets/icon/empty_chat.png', height: 160),
                  const SizedBox(height: 24),
                  const Text(
                    'Belum ada order aktif',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Silakan lakukan pemesanan untuk memulai percakapan dengan driver.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
