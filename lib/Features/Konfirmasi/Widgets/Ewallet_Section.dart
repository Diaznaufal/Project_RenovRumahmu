import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/StatusPesanan/Material/Pages/Status_pesanan.dart';
import '../Models/Pembayaran_Model.dart';
import 'package:flutter_application_1/Features/RiwayatPesanan/Models/Riwayat_Model.dart';
import 'package:flutter_application_1/Features/Konfirmasi/Widgets/Total_Pembayaran.dart';

class EwalletSection extends StatefulWidget {
  final PembayaranModel payment;
  final int total;
  final OrderType orderType;
  final RiwayatModel order;

  const EwalletSection({
    required this.payment,
    required this.total,
    required this.orderType,
    required this.order
  });

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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inria Sans",
                    ),
                  ),
                  Text(
                    "${widget.payment.id} Saldo",
                    style: TextStyle(
                      color: Color(0xff045097),
                      fontFamily: "Inria Sans",
                    ),
                  ),
                ],
              ),
              Image.asset(widget.payment.image, width: 70, height: 60),
            ],
          ),
        ),
        SizedBox(height: 15),
        TotalPembayaran(),
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => StatusPesanan(order: widget.order!,)),
                (route) => false,
              );
            },
            child: Text(
              "Buka Aplikasi ${widget.payment.id}",
              style: TextStyle(fontFamily: "Inria Sans"),
            ),
          ),
        ),
      ],
    );
  }
}
