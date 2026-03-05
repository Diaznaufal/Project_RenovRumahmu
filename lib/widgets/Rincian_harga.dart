import 'package:flutter/material.dart';
import 'package:flutter_application_1/Provider/Cart_Provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/product_cart.dart';
import '../models/Pembayaran_Model.dart';
import '../models/Riwayat_Model.dart';

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
      if (item.product.oldPrice != null) {
        return sum +
            ((item.product.oldPrice! - item.product.price) * item.quantity);
      }
      return sum;
    });

    double totalPembayaran = totalHarga + shippingCost;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 145,
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
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Metode Pembayaran",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    payment.id,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff0056A8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Status Pembayaran",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    getPaymentStatus(status),
                    style: TextStyle(
                      fontSize: 12,
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
                  const Text("Total Harga", style: TextStyle(fontSize: 12)),
                  Text(
                    formatRupiah.format(totalHarga),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),

              /// PENGIRIMAN
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Pengiriman",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    formatRupiah.format(shippingCost),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),

              /// DISKON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Diskon", style: TextStyle(fontSize: 12)),
                  Text(
                    "- ${formatRupiah.format(totalDiskon)}",
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
              ),

              const Divider(thickness: 2),

              /// TOTAL PEMBAYARAN
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Pembayaran",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatRupiah.format(totalPembayaran),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
