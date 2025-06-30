import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home/voucher_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodqu',
      home: const SplashScreen(),
      routes: {'/voucher': (context) => const VoucherPage()},
    );
  }
}
