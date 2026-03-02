import 'package:flutter/material.dart';
import 'package:flutter_application_1/Provider/Cart_Provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp ',
  decimalDigits: 0,
);

class TotalPembayaran extends StatelessWidget {
  final int total;

  const TotalPembayaran({required this.total, super.key});

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final expiry = cart.expiryTime;
    final remaining = cart.remainingTime;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Pembayaran",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            Text(
              formatRupiah.format(total),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff045097),
              ),
            ),
          ],
        ),

        SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(44),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "Selesaikan pembayaran sebelum:",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8),

              if (expiry != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat(
                          "dd MMM yyyy, HH:mm",
                          "id_ID",
                        ).format(expiry),
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        formatDuration(remaining),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
