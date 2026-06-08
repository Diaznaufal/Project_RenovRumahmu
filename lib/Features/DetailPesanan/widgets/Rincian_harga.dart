import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import '../../Keranjang/Provider/Cart_Provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Keranjang/Models/cart_item_model.dart';
import '../../Konfirmasi/Models/Pembayaran_Model.dart';
import '../../RiwayatPesanan/Models/Riwayat_Model.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class RincianHarga extends StatelessWidget {
  final PembayaranModel payment;
  final List<CartItemModel> items;
  final OrderStatuss status;

  const RincianHarga({
    super.key,
    required this.items,
    required this.payment,
    required this.status,
  });

  String getPaymentStatus(OrderStatuss status) {
    switch (status) {
      case OrderStatuss.menunggupembayaran:
        return "Menunggu";
      case OrderStatuss.dibatalkan:
        return "-";
      case OrderStatuss.disiapkan:
      case OrderStatuss.dikirim:
      case OrderStatuss.selesai:
        return "Lunas";
    }
  }

  Color getPaymentColor(OrderStatuss status) {
    switch (status) {
      case OrderStatuss.menunggupembayaran:
        return Color(0xff003466);
      case OrderStatuss.dibatalkan:
        return Color(0xFF000000);
      case OrderStatuss.disiapkan:
      case OrderStatuss.dikirim:
      case OrderStatuss.selesai:
        return Color(0xff009236);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    int shippingCost = cart.shippingCost;

    double totalHarga = items.fold(0, (sum, item) => sum + item.totalPrice);

    double totalDiskon = items.fold(0, (sum, item) {
      final product = item.product;

      if (product.discount != null) {
        final discountNominal = (product.price * product.discount!) ~/ 100;

        return sum + (discountNominal * item.quantity);
      }

      return sum;
    });

    double totalPembayaran = totalHarga + shippingCost;

    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(44),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Metode Pembayaran",
                  style: TextStyle(fontFamily: "Inria Sans"),
                ),
                Text(
                  payment.id,
                  style: TextStyle(
                    fontFamily: "Inria Sans",
                    color: Color(0xff0056A8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status Pembayaran",
                  style: TextStyle(fontFamily: "Inria Sans"),
                ),
                Text(
                  getPaymentStatus(status),
                  style: TextStyle(
                    fontFamily: "Inria Sans",
                    color: getPaymentColor(status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Harga", style: TextStyle(fontFamily: "Inria Sans")),
                Text(
                  formatRupiah.format(totalHarga),
                  style: TextStyle(fontFamily: "Inria Sans"),
                ),
              ],
            ),

            /// PENGIRIMAN
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Pengiriman",
                  style: TextStyle(fontFamily: "Inria Sans"),
                ),
                Text(
                  formatRupiah.format(shippingCost),
                  style: TextStyle(fontFamily: "Inria Sans"),
                ),
              ],
            ),

            /// DISKON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Diskon",
                  style: TextStyle(fontFamily: "Inria Sans"),
                ),
                Text(
                  "- ${formatRupiah.format(totalDiskon)}",
                  style: const TextStyle(
                    color: Colors.red,

                    fontFamily: "Inria Sans",
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            DottedLine(dashLength: 5, dashGapLength: 5, lineThickness: 1),

            /// TOTAL PEMBAYARAN
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Pembayaran",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inria Sans",
                  ),
                ),
                Text(
                  formatRupiah.format(totalPembayaran),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inria Sans",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
