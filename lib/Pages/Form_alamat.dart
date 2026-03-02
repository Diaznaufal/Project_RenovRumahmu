import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/Addres_Provider.dart';
import '../Provider/AuthProvider.dart';
import '../models/Addres_model.dart';

class FormAlamatPage extends StatefulWidget {
  final AddressModel? address;

  const FormAlamatPage({super.key, this.address});

  @override
  State<FormAlamatPage> createState() => _FormAlamatPageState();
}

class _FormAlamatPageState extends State<FormAlamatPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController subdistrictController;
  late TextEditingController provinceController;
  late TextEditingController postalController;

  bool get isEdit => widget.address != null;

  @override
  void initState() {
    super.initState();

    final auth = context.read<AuthProvider>();

    nameController = TextEditingController(
      text: widget.address?.name ?? auth.name,
    );

    phoneController = TextEditingController(text: widget.address?.phone ?? "");

    addressController = TextEditingController(
      text: widget.address?.address ?? "",
    );

    cityController = TextEditingController(text: widget.address?.city ?? "");

    subdistrictController = TextEditingController(
      text: widget.address?.subdistrict ?? "",
    );

    provinceController = TextEditingController(
      text: widget.address?.province ?? "",
    );

    postalController = TextEditingController(
      text: widget.address?.postalCode ?? "",
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    subdistrictController.dispose();
    provinceController.dispose();
    postalController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<AddressProvider>();

    final newAddress = AddressModel(
      id: isEdit ? widget.address!.id : DateTime.now().toString(),
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      subdistrict: subdistrictController.text.trim(),
      city: cityController.text.trim(),
      province: provinceController.text.trim(),
      district: "",
      postalCode: postalController.text.trim(),
      note: "",
    );

    if (isEdit) {
      provider.updateAddress(widget.address!.id, newAddress);
    } else {
      provider.addAddress(newAddress);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Ubah Alamat" : "Tambah Alamat")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nama
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nama Penerima"),
                validator: (value) =>
                    value!.isEmpty ? "Nama wajib diisi" : null,
              ),

              SizedBox(height: 12),

              // Phone
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Nomor HP"),
                validator: (value) =>
                    value!.isEmpty ? "Nomor HP wajib diisi" : null,
              ),

              SizedBox(height: 12),

              // Alamat detail
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Nama Jalan, Gedung, No. Rumah",
                ),
                validator: (value) =>
                    value!.isEmpty ? "Alamat wajib diisi" : null,
              ),

              SizedBox(height: 12),
              TextFormField(
                controller: subdistrictController,
                decoration: InputDecoration(labelText: "Kecamatan"),
              ),

              SizedBox(height: 12),
              // Kota
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: "Kota / Kabupaten"),
              ),

              SizedBox(height: 12),

              // Provinsi
              TextFormField(
                controller: provinceController,
                decoration: InputDecoration(labelText: "Provinsi"),
              ),

              SizedBox(height: 12),

              // Kode Pos
              TextFormField(
                controller: postalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Kode Pos"),
              ),
              SizedBox(height: 1),

              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    if (isEdit)
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xff045097),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Color(0xff045097)),
                            ),
                          ),
                          onPressed: () {
                            context.read<AddressProvider>().removeAddress(
                              widget.address!.id,
                            );

                            Navigator.pop(context);
                          },
                          child: const Text("Hapus Alamat"),
                        ),
                      ),

                    if (isEdit) const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff045097),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _save,
                        child: Text(isEdit ? "Simpan" : "Tambah Alamat"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
