import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Renovasi/Providers/Renovasi_Provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Checkout/Providers/Order_Provider.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class RincianEstimasiHarga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<RenovasiProvider>();
    final order = context.watch<OrderProvider>();

    final isBorongan = prov.isBorongan;

    final jasa = prov.biayaJasa;

    final material = prov.biayaMaterial;

    final total = prov.estimasiHarga;

    return Container(
      height: isBorongan ? 276 : 230,
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
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ================= JASA =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isBorongan ? "Biaya Jasa" : "Biaya Jasa Harian",
                  style: TextStyle(fontFamily: "Inria Sans"),
                ),

                Text(
                  isBorongan
                      ? formatRupiah.format(jasa)
                      : "${(formatRupiah.format(jasa))}/hari",
                  style: TextStyle(fontFamily: "Inria Sans"),
                ),
              ],
            ),

            // ================= MATERIAL/SURVEY =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isBorongan ? "Biaya Material" : "Biaya Jasa",
                  style: TextStyle(fontFamily: "Inria Sans"),
                ),

                Text(
                  formatRupiah.format(material),
                  style: TextStyle(fontFamily: "Inria Sans"),
                ),
              ],
            ),

            // ================= PROMO =================
            if (prov.appliedPromo != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Promo ",
                          style: TextStyle(fontFamily: "Inria Sans"),
                        ),
                        TextSpan(
                          text: prov.appliedPromo?.code ?? "",
                          style: TextStyle(
                            fontFamily: "Inria Sans",
                            fontWeight: FontWeight.w500,
                            color: Color(0xff045097),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    prov.appliedPromo != null
                        ? "-${formatRupiah.format(prov.diskonPromo)}"
                        : "Masukan Kode",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Inria Sans",
                    ),
                  ),
                ],
              ),

            DottedLine(dashLength: 5, dashGapLength: 5, lineThickness: 1),

            // ================= TOTAL =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Estimasi Total",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inria Sans",
                  ),
                ),

                Text(
                  formatRupiah.format(total),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inria Sans",
                    color: Color(0xff045097),
                  ),
                ),
              ],
            ),

            DottedLine(dashLength: 5, dashGapLength: 5, lineThickness: 1),

            // ================= METODE =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Metode", style: TextStyle(fontFamily: "Inria Sans")),

                Text(
                  order.paymentType == null
                      ? "-"
                      : order.paymentType == "dp"
                      ? "DP 30%"
                      : "Full Payment",

                  style: TextStyle(fontFamily: "Inria Sans"),
                ),
              ],
            ),

            // ================= BAYAR SEKARANG =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bayar Sekarang",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inria Sans",
                  ),
                ),

                Text(
                  order.paymentType == null
                      ? "-"
                      : order.paymentType == "dp"
                      ? formatRupiah.format(order.bayarSekarang)
                      : formatRupiah.format(total),

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inria Sans",
                    color: Color(0xff045097),
                  ),
                ),
              ],
            ),

            // ================= SISA PEMBAYARAN =================
            if (order.paymentType != null && order.paymentType == "dp") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Sisa Pembayaran",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inria Sans",
                    ),
                  ),

                  Text(
                    formatRupiah.format(order.sisaPembayaran),

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inria Sans",
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: 10),

            // ================= INFO =================
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey, size: 25),

                    SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        "Biaya akhir dapat berubah sesuai hasil survei lapangan dan pilihan material.",

                        maxLines: 2,

                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
