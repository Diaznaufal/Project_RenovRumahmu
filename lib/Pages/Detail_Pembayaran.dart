import 'package:flutter/material.dart';
import '../Data/pembayaran_data.dart';
import '../models/Pembayaran_Model.dart';

class DetailPembayaran extends StatelessWidget {
  final PembayaranKategori category;

  const DetailPembayaran({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final filteredList = MetodePembayaran.where(
      (e) => e.category == category,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black.withAlpha(77),
        titleSpacing: 1,
        toolbarHeight: 60,
        title: Text(
          "PILIH METODE PEMBAYARAN",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final item = filteredList[index];

          return ListTile(
            title: Text(item.title, style: TextStyle(fontSize: 14)),
            onTap: () {
              Navigator.pop(context, item);
            },
          );
        },
      ),
    );
  }
}
