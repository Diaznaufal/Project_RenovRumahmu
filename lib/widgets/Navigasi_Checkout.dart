import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Checkout_Page.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../Provider/Cart_Provider.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class NavigasiCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Container(
      height: 70,
      padding: EdgeInsets.only(left: 5, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          /// KIRI (Info & Select All)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "${cart.selectedItemCount} Produk dipilih",
                  style: TextStyle(fontSize: 11),
                ),
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.6,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      side: BorderSide(width: 0.8),
                      value:
                          cart.items.isNotEmpty &&
                          cart.selectedItemCount == cart.items.length,
                      onChanged: (value) {
                        cart.toggleSelectAll(value ?? false);
                      },
                    ),
                  ),
                  Text("Semua", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),

          Spacer(),

          /// KANAN (Total & Button)
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatRupiah.format(cart.totalSelectedAmount),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xff226889),
                    ),
                  ),
                  if (cart.totalDiscount > 0)
                    Row(
                      children: [
                        Text("Diskon: ", style: TextStyle(fontSize: 10)),
                        Text(
                          formatRupiah.format(cart.totalDiscount),
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                      ],
                    ),
                ],
              ),

              SizedBox(width: 12),

              /// Tombol Checkout
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff226889),
                    disabledBackgroundColor: Colors.grey.shade400,
                  ),
                  onPressed: cart.totalSelectedAmount == 0
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CheckoutPage()),
                          );
                        },
                  child: Text(
                    "Checkout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
