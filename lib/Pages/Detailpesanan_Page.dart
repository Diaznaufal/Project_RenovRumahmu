import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Riwayat_Model.dart';
import 'package:flutter_application_1/widgets/Alamat_user.dart';
import 'package:flutter_application_1/widgets/Bottom_Menu.dart';
import 'package:flutter_application_1/widgets/Rincian_Harga.dart';
import 'package:flutter_application_1/widgets/Rincian_Pesanan.dart';
import 'package:flutter_application_1/widgets/Status_Pesanan.dart';
import '../Provider/Cart_Provider.dart';
import 'package:provider/provider.dart';

class DetailpesananPage extends StatelessWidget {
  final RiwayatModel order;
  const DetailpesananPage({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    final payment = cart.selectedPayment!;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black.withAlpha(80),
        titleSpacing: 1,
        toolbarHeight: 60,
        title: Text(
          "DETAIL PESANAN",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Alamat Tujuan", style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Container(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: AlamatUser(),
                  ),
                ),
                SizedBox(height: 10),
                Text("Status Pesanan", style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                StatusOrder(order: order.status),
                SizedBox(height: 10),
                Text("Rincian Pesanan", style: TextStyle(fontSize: 16)),
                SizedBox(height: 7),
                if (order.items == null || order.items!.isEmpty)
                  Text("Tidak ada produk")
                else
                  ...order.items!.map((item) => RincianPesanan(item: item)),
                SizedBox(height: 10),
                RincianHarga(
                  items: order.items!,
                  payment: payment,
                  status: order.status,
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xff003466),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Cek Riwayat Pesanan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomMenu(currentIndex: 1),
    );
  }
}
