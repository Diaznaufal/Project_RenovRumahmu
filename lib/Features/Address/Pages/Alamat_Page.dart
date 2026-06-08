import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Address/Pages/Form_alamat.dart';
import 'package:flutter_application_1/Features/Renovasi/Providers/Renovasi_Provider.dart';
import 'package:provider/provider.dart';
import '../Provider/Addres_Provider.dart';

class AlamatPage extends StatefulWidget {
  const AlamatPage({super.key});

  @override
  State<AlamatPage> createState() => _AlamatPageState();
}

class _AlamatPageState extends State<AlamatPage> {
  String? tempSelected;

  @override
  void initState() {
    super.initState();

    final provider = context.read<AddressProvider>();

    // ambil selected address awal
    tempSelected = provider.selectedAddress?.id;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddressProvider>();
    final addresses = provider.addresses;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black87,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        title: Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              splashRadius: 10,
              onPressed: () => Navigator.pop(context),
              icon: Transform.translate(
                offset: Offset(-9, 0),
                child: Icon(Icons.arrow_back, size: 24),
              ),
            ),

            Text(
              "PILIH ALAMAT",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Inria Sans",
              ),
            ),

            Spacer(),

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormAlamatPage()),
                );
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),

      body: addresses.isEmpty
          ? Center(
              child: Text(
                "Belum ada alamat",
                style: TextStyle(fontFamily: "Inria Sans"),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];

                final isSelected = tempSelected == address.id;

                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,

                            onTap: () {
                              setState(() {
                                tempSelected = address.id;
                              });
                            },

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color: Color(0xff003466),
                                ),

                                SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            address.name.isNotEmpty
                                                ? address.name[0]
                                                          .toUpperCase() +
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
                          ),
                        ),

                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),

                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    FormAlamatPage(address: address),
                              ),
                            );

                            // refresh selected id setelah edit
                            final updatedProvider = context
                                .read<AddressProvider>();

                            final updatedAddress = updatedProvider.addresses
                                .firstWhere((e) => e.id == address.id);

                            setState(() {
                              if (tempSelected == address.id) {
                                tempSelected = updatedAddress.id;
                              }
                            });
                          },

                          child: Text("Ubah"),
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
          onTap: tempSelected != null
              ? () {
                  final selected = context
                      .read<AddressProvider>()
                      .addresses
                      .firstWhere((e) => e.id == tempSelected);

                  context.read<AddressProvider>().selectAddress(selected);

                  context.read<RenovasiProvider>().setAlamat(
                    selected.fullAddress,
                  );

                  Navigator.pop(context);
                }
              : null,

          child: Container(
            height: 45,

            decoration: BoxDecoration(
              color: tempSelected != null
                  ? Color(0xff003466)
                  : Colors.grey.shade400,

              borderRadius: BorderRadius.circular(8),
            ),

            child: Center(
              child: Text(
                "Konfirmasi",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: "Inria Sans",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
