import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Home/Pages/Home_Page.dart';
import 'package:flutter_application_1/Features/Checkout/Providers/Order_Provider.dart';
import 'package:flutter_application_1/Features/RiwayatPesanan/Models/Riwayat_Model.dart';
import 'package:flutter_application_1/Features/Konfirmasi/Widgets/Bank_section.dart';
import 'package:flutter_application_1/Features/Konfirmasi/Widgets/Ewallet_Section.dart';
import 'package:flutter_application_1/Features/Konfirmasi/Widgets/Kartu_section.dart';
import 'package:provider/provider.dart';
import '../../Keranjang/Provider/Cart_Provider.dart';
import '../Models/Pembayaran_Model.dart';

class KonfirmasiPage extends StatelessWidget {
  final RiwayatModel order;

  const KonfirmasiPage({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    final orderprov = context.read<OrderProvider>();
    final payment = orderprov.selectedPayment!;
    final total = cart.totalPembayaran;

    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        if (didpop) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.black.withAlpha(77),
          titleSpacing: 1,
          toolbarHeight: 60,
          title: Text(
            "KONFIRMASI PEMBAYARAN",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "Inria Sans",
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (payment.category == PembayaranKategori.bank)
                BankSection(
                  payment: payment,
                  total: total,
                  orderType: OrderType.material,
                  order: order,
                ),

              if (payment.category == PembayaranKategori.ewallet)
                EwalletSection(
                  payment: payment,
                  total: total,
                  orderType: OrderType.material,
                  order: order,
                ),

              if (payment.category == PembayaranKategori.kartu)
                KartuSection(
                  payment: payment,
                  total: total,
                  orderType: OrderType.material,
                  order: order,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
