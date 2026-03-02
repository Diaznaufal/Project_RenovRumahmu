import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Form_alamat.dart';
import 'package:provider/provider.dart';
import '../Provider/Addres_Provider.dart';

class AlamatPage extends StatelessWidget {
  const AlamatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddressProvider>();
    final addresses = provider.addresses;

    return Scaffold(
      appBar: AppBar(title: Text("Pilih Alamat")),
      body: addresses.isEmpty
          ? Center(child: Text("Belum ada alamat"))
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                final isSelected = provider.selectedAddress?.id == address.id;

                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            provider.selectAddress(address);
                            Navigator.pop(context);
                          },
                          child: Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: Colors.red,
                          ),
                        ),

                        SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    address.name.isNotEmpty
                                        ? address.name[0].toUpperCase() +
                                              address.name.substring(1)
                                        : "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    address.phone,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Spacer(),

                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              FormAlamatPage(address: address),
                                        ),
                                      );
                                    },
                                    child: Text("Ubah"),
                                  ),
                                ],
                              ),

                              SizedBox(height: 4),

                              Text(
                                address.fullAddress,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                );
              },
            ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormAlamatPage()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff003466),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    "Tambahkan Alamat",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
