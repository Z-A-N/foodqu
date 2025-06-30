import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/custom_header_with_search.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  Timer? _debounce;

  final List<Map<String, dynamic>> allVouchers = [
    {
      'title': 'Diskon 20% Semua Menu',
      'code': 'FOODQU20',
      'desc': 'Min. belanja Rp50.000 • s/d 31 Jul 2025',
      'icon': Icons.percent,
      'status': 'Aktif',
    },
    {
      'title': 'Gratis Ongkir',
      'code': 'ONGKIRQU',
      'desc': 'Tanpa minimum • Wilayah tertentu',
      'icon': Icons.local_shipping_outlined,
      'status': 'Aktif',
    },
    {
      'title': 'Cashback Rp10.000',
      'code': 'CASHBACK10K',
      'desc': 'Khusus pengguna baru • 1x pakai',
      'icon': Icons.monetization_on_outlined,
      'status': 'Digunakan',
    },
    {
      'title': 'Voucher Makan Siang',
      'code': 'LUNCHDEAL',
      'desc': 'Berlaku s/d 1 Juni 2025',
      'icon': Icons.lunch_dining,
      'status': 'Expired',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _searchQuery = value);
      }
    });
  }

  List<Map<String, dynamic>> getFilteredVouchers(String status) {
    final keyword = _searchQuery.toLowerCase();
    return allVouchers.where((v) {
      final matchesStatus = v['status'] == status;
      final matchesSearch =
          v['title'].toLowerCase().contains(keyword) ||
          v['code'].toLowerCase().contains(keyword);
      return matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeaderWithSearch(
              title: 'Voucher',
              showBackButton: true,
              showNotificationIcon: false,
            ),
            _buildTopBanner(),
            _buildSearchBox(),
            const SizedBox(height: 8),
            _buildTabs(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _VoucherList(status: 'Aktif'),
                  _VoucherList(status: 'Digunakan'),
                  _VoucherList(status: 'Expired'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset('assets/icon/Voucher.png', height: 60),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Gunakan voucher pilihan untuk hemat setiap pesanan di Foodqu!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari voucher...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildTabs() {
    return TabBar(
      controller: _tabController,
      labelColor: Colors.deepOrange,
      unselectedLabelColor: Colors.black54,
      indicatorColor: Colors.deepOrange,
      tabs: const [
        Tab(text: 'Aktif'),
        Tab(text: 'Digunakan'),
        Tab(text: 'Expired'),
      ],
    );
  }
}

class _VoucherList extends StatelessWidget {
  final String status;

  const _VoucherList({required this.status});

  @override
  Widget build(BuildContext context) {
    final parentState = context.findAncestorStateOfType<_VoucherPageState>();
    final vouchers = parentState!.getFilteredVouchers(status);

    if (vouchers.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text(
            'Tidak ditemukan voucher',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      addAutomaticKeepAlives: false,
      itemCount: vouchers.length,
      padding: const EdgeInsets.only(bottom: 32),
      itemBuilder: (context, index) {
        final v = vouchers[index];
        return VoucherCard(
          key: ValueKey(v['code']),
          title: v['title'],
          code: v['code'],
          desc: v['desc'],
          icon: v['icon'],
          isActive: v['status'] == 'Aktif',
        );
      },
    );
  }
}

class VoucherCard extends StatelessWidget {
  final String title;
  final String code;
  final String desc;
  final IconData icon;
  final bool isActive;

  const VoucherCard({
    super.key,
    required this.title,
    required this.code,
    required this.desc,
    required this.icon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive
          ? () {
              Navigator.pop(context, {'title': title, 'code': code});
            }
          : null,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.grey[100],
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.orange.shade100, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.orange.shade50,
              child: Icon(icon, size: 22, color: Colors.deepOrange),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          code,
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (isActive)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
