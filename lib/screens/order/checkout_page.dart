import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final int totalPrice;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _deliveryType = 'Standar';
  String? _selectedPaymentMethod = 'E-Wallet';
  String? _selectedEwallet = 'GoPay';
  String? _selectedBank;
  String? _voucherCode;
  String? _voucherTitle;
  int _voucherDiscount = 0;

  int get deliveryFee => _deliveryType == 'Prioritas' ? 15000 : 5000;
  int get finalTotal => widget.totalPrice + deliveryFee - _voucherDiscount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Jenis Pengiriman'),
            _buildDeliveryOptions(),
            const SizedBox(height: 16),
            _buildSectionTitle('Metode Pembayaran'),
            _paymentMethodSelector(),
            if (_selectedPaymentMethod == 'E-Wallet') _buildEwalletOptions(),
            if (_selectedPaymentMethod == 'Bank') _buildBankOptions(),
            const SizedBox(height: 16),
            _buildSectionTitle('Voucher'),
            _buildVoucherInput(),
            const SizedBox(height: 16),
            _buildSectionTitle('Ringkasan Pembayaran'),
            _buildSummary(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(
                child: Text('Bayar Sekarang', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDeliveryOptions() {
    return Row(
      children: [
        Radio<String>(
          value: 'Standar',
          groupValue: _deliveryType,
          onChanged: (value) => setState(() => _deliveryType = value),
        ),
        const Text('Standar (Rp5.000)'),
        const SizedBox(width: 16),
        Radio<String>(
          value: 'Prioritas',
          groupValue: _deliveryType,
          onChanged: (value) => setState(() => _deliveryType = value),
        ),
        const Text('Prioritas (Rp15.000)'),
      ],
    );
  }

  Widget _paymentMethodSelector() {
    final methods = {
      'COD': Icons.money,
      'E-Wallet': Icons.account_balance_wallet,
      'QRIS': Icons.qr_code,
      'Bank': Icons.account_balance,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: methods.entries.map((entry) {
        final isSelected = _selectedPaymentMethod == entry.key;
        return GestureDetector(
          onTap: () => setState(() => _selectedPaymentMethod = entry.key),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.deepOrange : Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.orange.withOpacity(0.1),
                        blurRadius: 6,
                      ),
                    ]
                  : [],
            ),
            child: Row(
              children: [
                Icon(
                  entry.value,
                  color: isSelected ? Colors.deepOrange : Colors.grey,
                ),
                const SizedBox(width: 12),
                Text(
                  entry.key,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.deepOrange : Colors.black,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  const Icon(Icons.check_circle, color: Colors.deepOrange),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEwalletOptions() {
    final ewallets = {
      'DANA': 'assets/logos/dana.png',
      'GoPay': 'assets/logos/gopay.png',
      'OVO': 'assets/logos/ovo.png',
      'ShopeePay': 'assets/logos/shopeepay.png',
    };

    return _buildPaymentSubOptions(
      options: ewallets,
      selected: _selectedEwallet,
      onSelect: (key) => setState(() => _selectedEwallet = key),
    );
  }

  Widget _buildBankOptions() {
    final banks = {
      'BCA': 'assets/logos/bca.png',
      'BRI': 'assets/logos/bri.png',
      'BNI': 'assets/logos/bni.png',
      'Mandiri': 'assets/logos/mandiri.png',
    };

    return _buildPaymentSubOptions(
      options: banks,
      selected: _selectedBank,
      onSelect: (key) => setState(() => _selectedBank = key),
    );
  }

  Widget _buildPaymentSubOptions({
    required Map<String, String> options,
    required String? selected,
    required Function(String) onSelect,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: options.entries.map((entry) {
          final isSelected = selected == entry.key;
          return GestureDetector(
            onTap: () => onSelect(entry.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 90,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.orange.shade50
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.deepOrange : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(entry.value, height: 40),
                  const SizedBox(height: 6),
                  Text(entry.key, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVoucherInput() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final result = await Navigator.pushNamed(context, '/voucher');
              if (!mounted) return;
              if (result is Map && result.containsKey('code')) {
                final code = result['code'];
                final title = result['title'];

                setState(() {
                  _voucherCode = code;
                  _voucherTitle = title;

                  if (code == 'FOODQU20' && widget.totalPrice >= 50000) {
                    _voucherDiscount = (widget.totalPrice * 0.2).toInt();
                  } else if (code == 'ONGKIRQU') {
                    _voucherDiscount = deliveryFee;
                  } else if (code == 'CASHBACK10K') {
                    _voucherDiscount = 10000;
                  } else {
                    _voucherDiscount = 0;
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Voucher $code diterapkan')),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_offer_outlined, color: Colors.orange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _voucherTitle != null
                          ? '$_voucherTitle ($_voucherCode)'
                          : 'Pilih voucher',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryItem('Subtotal Makanan', widget.totalPrice),
          _buildSummaryItem(
            'Biaya Pengiriman',
            deliveryFee,
            subtitle: _deliveryType,
          ),
          if (_voucherDiscount > 0)
            _buildSummaryItem(
              'Diskon Voucher',
              -_voucherDiscount,
              subtitle: _voucherTitle,
              isDiscount: true,
            ),
          const Divider(height: 24, thickness: 1),
          _buildSummaryItem(
            'Metode Pembayaran',
            0,
            subtitle: _selectedPaymentMethod ?? '',
          ),
          if (_selectedPaymentMethod == 'E-Wallet' && _selectedEwallet != null)
            _buildSummaryItem('E-Wallet', 0, subtitle: _selectedEwallet),
          if (_selectedPaymentMethod == 'Bank' && _selectedBank != null)
            _buildSummaryItem('Bank', 0, subtitle: _selectedBank),
          const Divider(height: 24, thickness: 1),
          _buildSummaryItem('Total Bayar', finalTotal, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String title,
    int value, {
    String? subtitle,
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isTotal ? 16 : 14,
                    fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                (value >= 0 ? 'Rp ' : '-Rp ') + value.abs().toString(),
                style: TextStyle(
                  fontSize: isTotal ? 16 : 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: isDiscount
                      ? Colors.red
                      : isTotal
                      ? Colors.deepOrange
                      : Colors.black,
                ),
              ),
            ],
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
        ],
      ),
    );
  }

  void _onCheckout() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    Navigator.pop(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 64, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Pembayaran Berhasil!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Pesanan kamu sedang diproses.',
              style: TextStyle(color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Selesai'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
