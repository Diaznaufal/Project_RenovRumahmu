import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Status_pesanan.dart';
import 'package:flutter_application_1/models/Pembayaran_Model.dart';
import 'package:flutter_application_1/widgets/Konfirmasi_Bayar/Total_Pembayaran.dart';

class KartuSection extends StatefulWidget {
  final PembayaranModel payment;
  final int total;

  const KartuSection({required this.payment, required this.total});

  @override
  State<KartuSection> createState() => _CardSectionState();
}

class _CardSectionState extends State<KartuSection> {
  final cardController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nomor Kartu",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        TextField(
          controller: cardController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "0000 0000 0000 0000",
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(fontSize: 14),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xff045097), width: 1.5),
            ),
          ),
        ),

        SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nomor Kartu",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: expiryController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "MM/YY",
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(fontSize: 14),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(0xff045097),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nomor Kartu",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "CVV",
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(fontSize: 14),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(0xff045097),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => StatusPesanan()),
                (route) => false,
              );
            },
            child: Text("Bayar Sekarang"),
          ),
        ),
      ],
    );
  }
}
