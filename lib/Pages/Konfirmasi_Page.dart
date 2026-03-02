import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/Konfirmasi_Bayar/Bank_section.dart';
import 'package:flutter_application_1/widgets/Konfirmasi_Bayar/Ewallet_Section.dart';
import 'package:flutter_application_1/widgets/Konfirmasi_Bayar/Kartu_section.dart';
import 'package:provider/provider.dart';
import '../Provider/Cart_Provider.dart';
import '../models/Pembayaran_Model.dart';

class KonfirmasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    final payment = cart.selectedPayment!;
    final total = cart.totalPayment;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black.withAlpha(77),
        titleSpacing: 1,
        toolbarHeight: 60,
        title: Text(
          "KONFIRMASI PEMBAYARAN",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (payment.category == PembayaranKategori.bank)
              BankSection(payment: payment, total: total),

            if (payment.category == PembayaranKategori.ewallet)
              EwalletSection(payment: payment, total: total),

            if (payment.category == PembayaranKategori.kartu)
              KartuSection(payment: payment, total: total),
          ],
        ),
      ),
    );
  }
}
