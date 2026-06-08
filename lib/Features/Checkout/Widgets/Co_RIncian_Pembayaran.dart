import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import '../../Keranjang/Provider/Cart_Provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class RincianPembayaran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 115,
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
                  Text("Total Harga", style: TextStyle(fontSize: 12)),
                  Text(
                    formatRupiah.format(cart.totalSelectedAmount),
                    style: TextStyle(fontSize: 12, fontFamily: "Inria Sans"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Pengiriman", style: TextStyle(fontSize: 12)),
                  Text(
                    formatRupiah.format(cart.shippingCost),
                    style: TextStyle(fontSize: 12, fontFamily: "Inria Sans"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Diskon",
                    style: TextStyle(fontSize: 12, fontFamily: "Inria Sans"),
                  ),
                  Text(
                    "- ${formatRupiah.format(cart.totalDiscount)}",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontFamily: "Inria Sans",
                    ),
                  ),
                ],
              ),
              DottedLine(dashLength: 5, dashGapLength: 5, lineThickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Pembayaran",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inria Sans",
                    ),
                  ),
                  Text(
                    formatRupiah.format(cart.totalPembayaran),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inria Sans",
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
