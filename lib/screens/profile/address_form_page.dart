import 'package:flutter/material.dart';

class AddressFormPage extends StatefulWidget {
  final Map<String, dynamic>? address;

  const AddressFormPage({super.key, this.address});

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController namaController;
  late TextEditingController teleponController;
  late TextEditingController negaraController;
  late TextEditingController provinsiController;
  late TextEditingController kotaController;
  late TextEditingController kecamatanController;
  late TextEditingController kelurahanController;
  late TextEditingController rtController;
  late TextEditingController rwController;
  late TextEditingController kodePosController;
  late TextEditingController detailController;
  late TextEditingController labelController;

  bool isPrimary = false;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.address?['penerima']);
    teleponController = TextEditingController(text: widget.address?['telepon']);
    negaraController = TextEditingController(text: widget.address?['negara']);
    provinsiController = TextEditingController(text: widget.address?['provinsi']);
    kotaController = TextEditingController(text: widget.address?['kota']);
    kecamatanController = TextEditingController(text: widget.address?['kecamatan']);
    kelurahanController = TextEditingController(text: widget.address?['kelurahan']);
    rtController = TextEditingController(text: widget.address?['rt']);
    rwController = TextEditingController(text: widget.address?['rw']);
    kodePosController = TextEditingController(text: widget.address?['kodePos']);
    detailController = TextEditingController(text: widget.address?['detail']);
    labelController = TextEditingController(text: widget.address?['label']);
    isPrimary = widget.address?['isPrimary'] == true;
  }

  @override
  void dispose() {
    namaController.dispose();
    teleponController.dispose();
    negaraController.dispose();
    provinsiController.dispose();
    kotaController.dispose();
    kecamatanController.dispose();
    kelurahanController.dispose();
    rtController.dispose();
    rwController.dispose();
    kodePosController.dispose();
    detailController.dispose();
    labelController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'penerima': namaController.text,
        'telepon': teleponController.text,
        'negara': negaraController.text,
        'provinsi': provinsiController.text,
        'kota': kotaController.text,
        'kecamatan': kecamatanController.text,
        'kelurahan': kelurahanController.text,
        'rt': rtController.text,
        'rw': rwController.text,
        'kodePos': kodePosController.text,
        'detail': detailController.text,
        'label': labelController.text,
        'isPrimary': isPrimary,
      });
    }
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) => value == null || value.trim().isEmpty ? 'Wajib diisi' : null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address == null ? 'Tambah Alamat' : 'Edit Alamat'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField('Nama Penerima', namaController),
              const SizedBox(height: 12),
              _buildTextField('Nomor Telepon', teleponController),
              const SizedBox(height: 12),
              _buildTextField('Negara', negaraController),
              const SizedBox(height: 12),
              _buildTextField('Provinsi', provinsiController),
              const SizedBox(height: 12),
              _buildTextField('Kota/Kabupaten', kotaController),
              const SizedBox(height: 12),
              _buildTextField('Kecamatan', kecamatanController),
              const SizedBox(height: 12),
              _buildTextField('Kelurahan', kelurahanController),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildTextField('RT', rtController)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildTextField('RW', rwController)),
                ],
              ),
              const SizedBox(height: 12),
              _buildTextField('Kode Pos', kodePosController),
              const SizedBox(height: 12),
              _buildTextField('Detail Alamat (Jalan, No Rumah, dll)', detailController, maxLines: 3),
              const SizedBox(height: 12),
              _buildTextField('Label Alamat (cth: Rumah, Kosan)', labelController),
              const SizedBox(height: 12),
              SwitchListTile(
                value: isPrimary,
                activeColor: Colors.orange,
                onChanged: (val) => setState(() => isPrimary = val),
                title: const Text('Tandai sebagai alamat utama'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Simpan Alamat', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
