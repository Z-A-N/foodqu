import 'package:flutter/material.dart';
import 'screens/home/home_page.dart';
import 'screens/history/history_page.dart';
import 'screens/order/order_page.dart';
import 'screens/message/message_page.dart';
import 'screens/message/message_empty_page.dart';
import 'screens/profile/profile_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final bool hasActiveOrder = false; // Simulasi status order aktif

  final List<IconData> _icons = [
    Icons.home,
    Icons.history,
    Icons.receipt_long,
    Icons.message,
    Icons.person,
  ];

  final List<String> _labels = ['Home', 'History', 'Order', 'Pesan', 'Profil'];

  List<Widget> get _pages => [
    const HomePage(),
    const HistoryPage(),
    const OrderPage(),
    hasActiveOrder ? const MessagePage() : const MessageEmptyPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFA726),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
              final isSelected = _selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _icons[index],
                        color: isSelected
                            ? const Color(0xFFFF5722)
                            : Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _labels[index],
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? const Color(0xFFFF5722)
                              : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
