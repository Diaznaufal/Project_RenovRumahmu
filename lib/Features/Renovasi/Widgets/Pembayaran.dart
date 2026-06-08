import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Checkout/Providers/Order_Provider.dart';
import 'package:flutter_application_1/Features/Renovasi/Providers/Renovasi_Provider.dart';
import '../../RiwayatPesanan/Models/Riwayat_Model.dart';
import 'package:flutter_application_1/Features/Konfirmasi/Widgets/Bank_section.dart';
import 'package:flutter_application_1/Features/Konfirmasi/Widgets/Ewallet_Section.dart';
import 'package:flutter_application_1/Features/Konfirmasi/Widgets/Kartu_section.dart';
import 'package:provider/provider.dart';
import '../../Konfirmasi/Models/Pembayaran_Model.dart';

class Pembayaran extends StatelessWidget {
  final RiwayatModel order;

  const Pembayaran({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    final renov = context.read<RenovasiProvider>();
    final orderprov = context.read<OrderProvider>();
    final payment = orderprov.selectedPayment!;
    final total = orderprov.paymentType == null
        ? renov.estimasiHarga
        : orderprov.bayarSekarang;
    ;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (payment.category == PembayaranKategori.bank)
              BankSection(
                payment: payment,
                total: total,
                orderType: OrderType.renovasi,
                order: order,
              ),

            if (payment.category == PembayaranKategori.ewallet)
              EwalletSection(
                payment: payment,
                total: total,
                orderType: OrderType.renovasi,
                order: order,
              ),

            if (payment.category == PembayaranKategori.kartu)
              KartuSection(
                payment: payment,
                total: total,
                orderType: OrderType.renovasi,
                order: order,
              ),
          ],
        ),
      ),
    );
  }
}
