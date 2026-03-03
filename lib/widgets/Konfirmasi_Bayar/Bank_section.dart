import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Pages/Status_pesanan.dart';
import 'package:flutter_application_1/Provider/Cart_Provider.dart';
import 'package:flutter_application_1/Provider/Riwayat_Provider.dart';
import 'package:flutter_application_1/models/Pembayaran_Model.dart';
import 'package:flutter_application_1/models/Riwayat_Model.dart';
import 'package:flutter_application_1/widgets/Konfirmasi_Bayar/Cara_Bayar.dart';
import 'package:flutter_application_1/widgets/Konfirmasi_Bayar/Total_Pembayaran.dart';
import 'package:provider/provider.dart';

class BankSection extends StatefulWidget {
  final PembayaranModel payment;
  final int total;

  const BankSection({super.key, required this.payment, required this.total});

  @override
  State<BankSection> createState() => _BankSectionState();
}

class _BankSectionState extends State<BankSection> {
  int? openIndex; // hanya 1 yang bisa terbuka

  List<Map<String, String>> get metodePembayaran => [
    {
      "title": "Via ${widget.payment.id} Mobile",
      "content":
          "1. Login ke aplikasi ${widget.payment.id} Mobile.\n"
          "2. Pilih ${widget.payment.id} Virtual Account.\n"
          "3. Pilih Input No. Virtual Account.\n"
          "4. Masukan nomor Virtual Account, lalu klik OK.\n"
          "5. Klik Send dan cek rincian tagihan yang muncul.\n"
          "6. Masukkan PIN kamu untuk konfirmasi.",
    },
    {
      "title": "Via ATM ${widget.payment.id}",
      "content":
          "1. Masukkan kartu ATM.\n"
          "2. Pilih Transaksi Lainnya.\n"
          "3. Pilih Transfer.\n"
          "4. Masukkan Nomor VA.\n"
          "5. Konfirmasi.",
    },
    {
      "title": "Via Klik${widget.payment.id}",
      "content":
          "1. Login ke Klik${widget.payment.id}.\n"
          "2. Pilih Transfer Dana.\n"
          "3. Masukkan Nomor VA.\n"
          "4. Konfirmasi.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final String virtualAccount = "0887113793287426";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(44),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transfer Bank - ${widget.payment.id}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Virtual Account",
                    style: TextStyle(color: Color(0xff045097)),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    virtualAccount,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Nomor Virtual Account",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff045097),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: virtualAccount));

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Nomor VA berhasil disalin",
                        style: TextStyle(fontSize: 13),
                      ),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                child: Text("Salin"),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        TotalPembayaran(total: widget.total),
        SizedBox(height: 10),
        Text("Cara Pembayaran"),
        SizedBox(height: 10),
        Column(
          children: List.generate(metodePembayaran.length, (index) {
            final item = metodePembayaran[index];
            return CaraBayar(
              title: item["title"]!,
              content: item["content"]!,
              isOpen: openIndex == index,
              onTap: () {
                setState(() {
                  if (openIndex == index) {
                    openIndex = null;
                  } else {
                    openIndex = index;
                  }
                });
              },
            );
          }),
        ),

        SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff045097),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              final cartProvider = Provider.of<CartProvider>(
                context,
                listen: false,
              );

              final riwayatProvider = Provider.of<RiwayatProvider>(
                context,
                listen: false,
              );

              final selectedItems = cartProvider.items.values
                  .where((item) => item.isSelected)
                  .map((item) => item.copy())
                  .toList();

              if (selectedItems.isEmpty) return;

              final totalHarga = cartProvider.totalPayment;

              final newOrder = RiwayatModel(
                id: DateTime.now().toString(),
                type: OrderType.material,
                title: "Pembelian ${selectedItems.length} Material",
                date: DateTime.now(),
                status: OrderStatuss.dikirim,
                totalPrice: totalHarga,
                items: selectedItems,
                serviceLabel: "Material",
              );

              riwayatProvider.tambahRiwayat(newOrder);

              for (var item
                  in cartProvider.items.values
                      .where((item) => item.isSelected)
                      .toList()) {
                cartProvider.removeCartItem(item);
              }

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => StatusPesanan(order: newOrder),
                ),
                (route) => false,
              );
            },
            child: Text("Kembali ke Home"),
          ),
        ),
      ],
    );
  }
}
