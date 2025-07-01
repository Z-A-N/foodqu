import 'package:shared_preferences/shared_preferences.dart';
import '../main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/foundation.dart';
import 'auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid');

    if (kDebugMode) {
      print('🟡 SplashScreen: UID ditemukan = $uid');
    }

    if (!mounted) return;

    if (uid != null && uid.isNotEmpty) {
      if (kDebugMode) {
        print('✅ SplashScreen: Navigasi ke MainNavigation');
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigation()),
      );
    } else {
      if (kDebugMode) {
        print('🟥 SplashScreen: Navigasi ke LoginPage');
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), checkLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Lottie.asset('assets/lottie/Flow main.json')),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Halaman Berikutnya')));
  }
}
