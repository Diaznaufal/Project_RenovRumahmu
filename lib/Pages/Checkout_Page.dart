import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/Opsi_Pengiriman.dart';
import 'package:flutter_application_1/Pages/Detail_Pembayaran.dart';
import 'package:flutter_application_1/Pages/Konfirmasi_Page.dart';
import 'package:flutter_application_1/Utils/Dialog_Helper.dart';
import 'package:flutter_application_1/widgets/Alamat_Pengiriman.dart';
import 'package:flutter_application_1/widgets/Rincian_harga.dart';
import 'package:flutter_application_1/widgets/Ringkasan_Pesanan.dart';
import 'package:flutter_application_1/widgets/Shiping_Section.dart';
import 'package:provider/provider.dart';
import '../Provider/Cart_Provider.dart';

import '../Data/pembayaran_data.dart';
import '../models/Pembayaran_Model.dart';
import '../widgets/Pembayaran_Card.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int? selectedIndex;
  int ongkir = 0;

  String getPreviewText(PembayaranKategori kategori) {
    final list = MetodePembayaran.where(
      (e) => e.category == kategori,
    ).take(3).map((e) => e.id).toList();

    return "${list.join(", ")}, dll";
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CartProvider>().selectPayment(null);
      context.read<CartProvider>().selectShipping(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final selectedPayment = cart.selectedPayment;
    final items = cart.items.values.where((item) => item.isSelected).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black.withAlpha(77),
        titleSpacing: 1,
        toolbarHeight: 60,
        title: Text(
          "CHECKOUT",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          Text(
            "Alamat Pengiriman",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          AlamatPengiriman(),
          SizedBox(height: 20),

          Text(
            "Ringkasan Pesanan",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          ...items.map((item) {
            final key = '${item.product.name}_${item.selectedSize}';
            return RingkasanPesanan(item: item, itemKey: key);
          }).toList(),

          SizedBox(height: 10),
          Text(
            "Pengiriman",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          ShippingSection(
            shippingList: OpsiPengiriman,
            selectedIndex: selectedIndex,
            onSelected: (index, cost) {
              setState(() {
                selectedIndex = index;
                ongkir = cost;
              });

              Provider.of<CartProvider>(
                context,
                listen: false,
              ).selectShipping(cost);
            },
          ),

          SizedBox(height: 20),
          Text(
            "Pembayaran",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: [
                ...PembayaranKategorii.asMap().entries.map((entry) {
                  final index = entry.key;
                  final category = entry.value;

                  final isActive =
                      selectedPayment != null &&
                      selectedPayment.category == category.type;

                  return Column(
                    children: [
                      PembayaranCard(
                        category: category,
                        subtitle: isActive
                            ? selectedPayment.id
                            : getPreviewText(category.type),
                        isSelected: isActive,
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailPembayaran(category: category.type),
                            ),
                          );

                          if (result != null) {
                            context.read<CartProvider>().selectPayment(result);
                          }
                        },
                      ),
                      if (index != PembayaranKategorii.length - 1)
                        Divider(height: 1),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),

          SizedBox(height: 20),
          Text(
            "Rincian",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          RincianHarga(),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              final cart = context.read<CartProvider>();
              final selectedPayment = cart.selectedPayment;
              final shippingCost = cart.shippingCost;
              cart.startPaymentCountdown();

              if (shippingCost == 0) {
                showErrorDialog(
                  context,
                  "Silakan pilih metode pengiriman terlebih dahulu.",
                  title: "Pengiriman",
                );
                return;
              }

              if (selectedPayment == null) {
                showErrorDialog(
                  context,
                  "Silakan pilih metode pembayaran terlebih dahulu.",
                  title: "Metode Pembayaran",
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => KonfirmasiPage()),
              );
            },
            child: Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff0369C8),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(44),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "BAYAR SEKARANG",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
