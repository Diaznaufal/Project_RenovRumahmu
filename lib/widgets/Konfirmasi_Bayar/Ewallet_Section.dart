import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Status_pesanan.dart';
import 'package:flutter_application_1/Provider/Cart_Provider.dart';
import 'package:flutter_application_1/Provider/Riwayat_Provider.dart';
import 'package:flutter_application_1/models/Pembayaran_Model.dart';
import 'package:flutter_application_1/models/Riwayat_Model.dart';
import 'package:flutter_application_1/widgets/Konfirmasi_Bayar/Total_Pembayaran.dart';
import 'package:provider/provider.dart';

class EwalletSection extends StatefulWidget {
  final PembayaranModel payment;
  final int total;

  const EwalletSection({required this.payment, required this.total});

  @override
  State<EwalletSection> createState() => _EwalletSectionState();
}

class _EwalletSectionState extends State<EwalletSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.payment.id}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.payment.id} Saldo",
                    style: TextStyle(color: Color(0xff045097)),
                  ),
                ],
              ),
              Image.asset(widget.payment.image, width: 70, height: 60),
            ],
          ),
        ),
        SizedBox(height: 15),
        TotalPembayaran(total: widget.total),
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
                status: OrderStatuss.dibatalkan,
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
            child: Text("Buka Aplikasi ${widget.payment.id}"),
          ),
        ),
      ],
    );
  }
}
