import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/Remote/Opsi_Pengiriman.dart';
import 'package:flutter_application_1/Features/Checkout/Pages/Detail_Pembayaran.dart';
import 'package:flutter_application_1/Features/Konfirmasi/Pages/Konfirmasi_Page.dart';
import 'package:flutter_application_1/Core/Helpers/Dialog_Error.dart';
import 'package:flutter_application_1/Features/Checkout/Widgets/Alamat_Pengiriman.dart';
import 'package:flutter_application_1/Features/Checkout/Widgets/Co_RIncian_Pembayaran.dart';
import 'package:flutter_application_1/Features/Checkout/Widgets/Ringkasan_Pesanan.dart';
import 'package:flutter_application_1/Features/Checkout/Widgets/Shiping_Section.dart';
import 'package:provider/provider.dart';
import '../../Keranjang/Provider/Cart_Provider.dart';
import '../Providers/Order_Provider.dart';
import '../../../Data/Remote/Pembayaran_Data.dart';
import '../../Konfirmasi/Models/Pembayaran_Model.dart';
import '../../Renovasi/Widgets/Elemens/Pembayaran_Card.dart';
import '../../RiwayatPesanan/Provider/Riwayat_Provider.dart';
import '../../RiwayatPesanan/Models/Riwayat_Model.dart';

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
      context.read<OrderProvider>().selectPayment(null);
      context.read<CartProvider>().selectShipping(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final order = context.watch<OrderProvider>();
    final selectedPayment = order.selectedPayment;
    final items = cart.items.values.where((item) => item.isSelected).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black.withAlpha(77),
        titleSpacing: 1,
        toolbarHeight: 60,
        title: Text(
          "CHECKOUT",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          Text(
            "Alamat Pengiriman",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: "Inria Sans",
            ),
          ),
          SizedBox(height: 10),
          AlamatPengiriman(),
          SizedBox(height: 20),

          Text(
            "Ringkasan Pesanan",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: "Inria Sans",
            ),
          ),
          SizedBox(height: 10),

          ...items.map((item) {
            final key = '${item.product.name}_${item.selectedSize}';
            return RingkasanPesanan(item: item, itemKey: key);
          }).toList(),

          SizedBox(height: 10),
          Text(
            "Pengiriman",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: "Inria Sans",
            ),
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
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: "Inria Sans",
            ),
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
                            context.read<OrderProvider>().selectPayment(result);
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
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: "Inria Sans",
            ),
          ),
          SizedBox(height: 10),
          RincianPembayaran(),
          SizedBox(height: 25),

          InkWell(
            onTap: () {
              final orderProvider = context.read<OrderProvider>();

              final cartProvider = context.read<CartProvider>();

              final riwayatProvider = context.read<RiwayatProvider>();

              final shippingCost = cartProvider.shippingCost;

              final selectedPayment = orderProvider.selectedPayment;
              

              /// VALIDASI SHIPPING
              if (shippingCost == 0) {
                showErrorDialog(
                  context,
                  "Silakan pilih metode pengiriman terlebih dahulu.",
                  title: "Pengiriman",
                );
                return;
              }

              /// VALIDASI PAYMENT
              if (selectedPayment == null) {
                showErrorDialog(
                  context,
                  "Silakan pilih metode pembayaran terlebih dahulu.",
                  title: "Metode Pembayaran",
                );
                return;
              }

              final selectedItems = cartProvider.items.values
                  .where((item) => item.isSelected)
                  .map((item) => item.copy())
                  .toList();

              if (selectedItems.isEmpty) return;

              /// TOTAL
              final totalHarga = cartProvider.totalSelectedAmount;

              final totalPembayaran = totalHarga + shippingCost;

              /// CHECKOUT
              orderProvider.checkout(
                items: cartProvider.items,
                total: totalPembayaran,
              );

              /// RIWAYAT
              final newOrder = RiwayatModel(
                id: orderProvider.invoice!,
                type: OrderType.material,
                title: "Pembelian ${selectedItems.length} Material",
                date: DateTime.now(),

                /// STATUS AWAL
                orderStatuss: OrderStatuss.dikirim,
                paymenMethod: selectedPayment,
                totalPrice: totalPembayaran,

                items: selectedItems,

                serviceLabel: "Material",
              );

              /// SIMPAN RIWAYAT
              riwayatProvider.tambahRiwayat(newOrder);

              /// HAPUS CART
              for (var entry
                  in cartProvider.items.entries
                      .where((e) => e.value.isSelected)
                      .toList()) {
                cartProvider.removeItem(entry.key);
              }

              /// START TIMER
              orderProvider.startPaymentCountdown();

              /// PINDAH PAGE
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => KonfirmasiPage(order: newOrder),
                ),
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
                    fontFamily: "Inria Sans",
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
