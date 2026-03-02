import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/Card_Keranjang.dart';
import 'package:flutter_application_1/widgets/Navigasi_Checkout.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Provider/Cart_Provider.dart';
import '../models/product_cart.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp ',
  decimalDigits: 0,
);

class KeranjangPage extends StatefulWidget {
  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  CartItemModel? editingItem;
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black.withAlpha(80),
        titleSpacing: 1,
        toolbarHeight: 60,
        title: Text(
          "KERANJANG",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: items.isEmpty
          ? Center(child: Text("Keranjang kosong"))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final key = '${item.product.name}_${item.selectedSize}';

                return CardKeranjang(item: item, itemKey: key);
              },
            ),
      bottomNavigationBar: NavigasiCheckout(),
    );
  }
}
