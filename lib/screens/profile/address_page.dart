import 'package:flutter/material.dart';
import 'address_form_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<Map<String, dynamic>> addresses = [];

  void _addOrEditAddress({Map<String, dynamic>? address, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressFormPage(address: address),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        if (result['isPrimary'] == true) {
          // Set semua alamat lain menjadi bukan utama
          for (var addr in addresses) {
            addr['isPrimary'] = false;
          }
        }

        if (index != null) {
          addresses[index] = result;
        } else {
          addresses.add(result);
        }
      });
    }
  }

  void _deleteAddress(int index) {
    setState(() {
      addresses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Alamat'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: addresses.isEmpty
          ? const Center(child: Text('Belum ada alamat. Tambahkan sekarang!'))
          : ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final addr = addresses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      addr['label'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(addr['detail'] ?? ''),
                        if (addr['isPrimary'] == true)
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              'Alamat Utama',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _addOrEditAddress(address: addr, index: index);
                        } else if (value == 'delete') {
                          _deleteAddress(index);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Hapus'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => _addOrEditAddress(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
