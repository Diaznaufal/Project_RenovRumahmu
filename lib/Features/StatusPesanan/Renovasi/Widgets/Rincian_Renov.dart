import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Renovasi/Providers/Renovasi_Provider.dart';
import 'package:flutter_application_1/Features/RiwayatPesanan/Models/Riwayat_Model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp ',
  decimalDigits: 0,
);

class RincianRenov extends StatefulWidget {
  final RiwayatModel order;

  const RincianRenov({super.key, required this.order});

  @override
  State<RincianRenov> createState() => _RincianRenovState();
}

class _RincianRenovState extends State<RincianRenov> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final step = widget.order.renovasiStep;

    switch (step) {
      case RenovasiStep.finishing:
        return _buildRincianFinishing();

      case RenovasiStep.proyekSelesai:
        return _buildRincianSelesai();

      default:
        return _buildRincianDefault();
    }
  }

  // ================= DEFAULT =================

  Widget _buildRincianDefault() {
    final total = widget.order.totalPrice ?? 0;

    return _buildContainer(
      child: Column(
        children: [
          _buildMetode(),

          const SizedBox(height: 5),

          _buildBayarSekarang(total),

          if (widget.order.metodePembayaranProyek == "dp") ...[
            const SizedBox(height: 5),
            _buildSisaPembayaran(),
          ],

          _buildExpandButton(),

          const SizedBox(height: 5),

          _buildDottedLine(),

          const SizedBox(height: 10),

          _buildEstimasiTotal(total),

          const SizedBox(height: 10),

          _buildInfoBox(),
        ],
      ),
    );
  }

  // ================= FINISHING =================

  Widget _buildRincianFinishing() {
    final total = widget.order.totalPrice ?? 0;

    return _buildContainer(
      child: Column(
        children: [
          _buildMetode(),

          const SizedBox(height: 5),

          _buildTelahDibayar(total),

          if (widget.order.metodePembayaranProyek == "dp") ...[
            const SizedBox(height: 5),
            _buildSisaPembayaran(),
          ],

          _buildExpandButton(),

          const SizedBox(height: 5),

          _buildDottedLine(),

          const SizedBox(height: 10),

          _buildEstimasiTotal(total),

          const SizedBox(height: 10),

          _buildInfoBox(),
        ],
      ),
    );
  }

  // ================= SELESAI =================

  Widget _buildRincianSelesai() {
    final total = widget.order.totalPrice ?? 0;

    return _buildContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: const [
              Text(
                "Status Pembayaran",
                style: TextStyle(fontFamily: "Inria Sans"),
              ),

              Text(
                "Lunas",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text(
            "Biaya Awal",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              fontFamily: "Inria Sans",
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Biaya Jasa",
                style: TextStyle(fontFamily: "Inria Sans"),
              ),

              Text(
                formatRupiah.format(widget.order.biayaJasa),
                style: const TextStyle(fontFamily: "Inria Sans"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Biaya Material",
                style: TextStyle(fontFamily: "Inria Sans"),
              ),

              Text(
                formatRupiah.format(widget.order.biayaMaterial),
                style: const TextStyle(fontFamily: "Inria Sans"),
              ),
            ],
          ),
Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Promo "),
                          if ((widget.order.promoCode ?? '').isNotEmpty)
                            TextSpan(
                              text: widget.order.promoCode!,
                              style: const TextStyle(
                                color: Color(0xff045097),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),

                    Text(
                      (widget.order.promoCode ?? '').isNotEmpty
                          ? "-${formatRupiah.format(widget.order.diskonPromo)}"
                          : "-",
                      style: const TextStyle(
                        color: Colors.red,
                        fontFamily: "Inria Sans",
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 5),
          Text(
            "Biaya Penyesuaian",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              fontFamily: "Inria Sans",
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "+ Water Proofing",
                style: TextStyle(fontFamily: "Inria Sans"),
              ),

              Text(
                formatRupiah.format(200000),
                style: const TextStyle(fontFamily: "Inria Sans"),
              ),
            ],
          ),

          const SizedBox(height: 10),

          _buildDottedLine(),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Biaya Akhir",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),

              Text(
                formatRupiah.format(total),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                  color: Color(0xff045097),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= COMPONENT =================

  Widget _buildContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),

      child: child,
    );
  }

  Widget _buildMetode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        const Text("Metode", style: TextStyle(fontFamily: "Inria Sans")),

        Text(
          widget.order.metodePembayaranProyek == null
              ? "-"
              : widget.order.metodePembayaranProyek == "dp"
              ? "DP 30%"
              : "Full Payment",

          style: const TextStyle(fontFamily: "Inria Sans"),
        ),
      ],
    );
  }

  Widget _buildBayarSekarang(int total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        const Text(
          "Bayar Sekarang",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
          ),
        ),

        Text(
          widget.order.metodePembayaranProyek == "dp"
              ? formatRupiah.format(widget.order.bayarSekarang ?? 0)
              : formatRupiah.format(total),

          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
            color: Color(0xff045097),
          ),
        ),
      ],
    );
  }

  Widget _buildTelahDibayar(int total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        const Text(
          "Telah Dibayar",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
          ),
        ),

        Text(
          widget.order.metodePembayaranProyek == "dp"
              ? formatRupiah.format(widget.order.bayarSekarang ?? 0)
              : formatRupiah.format(total),

          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
            color: Color(0xff045097),
          ),
        ),
      ],
    );
  }

  Widget _buildSisaPembayaran() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        const Text(
          "Sisa Pembayaran",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
          ),
        ),

        Text(
          formatRupiah.format(widget.order.sisaPembayaran ?? 0),

          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
            color: Color(0xff045097),
          ),
        ),
      ],
    );
  }

  Widget _buildEstimasiTotal(int total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        const Text(
          "Estimasi Total",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
          ),
        ),

        Text(
          formatRupiah.format(total),

          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
            color: Color(0xff045097),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandButton() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },

          child: Row(
            children: [
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,

                color: const Color(0xff045097),
                size: 18,
              ),

              const Text(
                "Lihat Rincian",
                style: TextStyle(
                  color: Color(0xff045097),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),

          crossFadeState: isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,

          firstChild: Padding(
            padding: const EdgeInsets.only(top: 1),

            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Biaya Jasa"),
                    Text(
                      widget.order.biayaJasa.toString(),
                      style: TextStyle(fontFamily: "Inria Sans"),
                    ),
                  ],
                ),

                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Biaya Material"),
                    Text(
                      widget.order.biayaMaterial.toString(),
                      style: TextStyle(fontFamily: "Inria Sans"),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "+ Water proofing",
                      style: TextStyle(fontFamily: "Inria Sans"),
                    ),

                    Text(
                      formatRupiah.format(200000),
                      style: const TextStyle(fontFamily: "Inria Sans"),
                    ),
                  ],
                ),

                SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Promo "),
                          if ((widget.order.promoCode ?? '').isNotEmpty)
                            TextSpan(
                              text: widget.order.promoCode!,
                              style: const TextStyle(
                                color: Color(0xff045097),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),

                    Text(
                      (widget.order.promoCode ?? '').isNotEmpty
                          ? "-${formatRupiah.format(widget.order.diskonPromo)}"
                          : "-",
                      style: const TextStyle(
                        color: Colors.red,
                        fontFamily: "Inria Sans",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          secondChild: const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildDottedLine() {
    return SizedBox(
      width: double.infinity,

      child: const DottedLine(
        dashLength: 5,
        dashGapLength: 5,
        lineThickness: 1,
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      height: 44,

      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.grey, size: 25),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                "Biaya akhir dapat berubah sesuai hasil survei lapangan dan pilihan material.",

                maxLines: 2,

                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
