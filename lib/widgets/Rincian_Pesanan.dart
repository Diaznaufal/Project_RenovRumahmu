import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product_cart.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class RincianPesanan extends StatelessWidget {
  final CartItemModel item;
  final String itemKey;

  const RincianPesanan({Key? key, required this.item, required this.itemKey})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
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
          padding: const EdgeInsets.only(top: 6, right: 8, bottom: 8, left: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item.product.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            item.product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),

                          Text(
                            "Varian: ${item.selectedSize}",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          Spacer(),
                          Text(
                            "Qty: ${item.quantity.toString()}",
                            style: TextStyle(fontSize: 12),
                          ),

                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (item.product.oldPrice != null)
                              Text(
                                formatRupiah.format(item.product.oldPrice),
                                style: const TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey,
                                  decorationThickness: 2,
                                ),
                              ),
                            Text(
                              formatRupiah.format(item.totalPrice),
                              style: TextStyle(
                                color: Color(0xff226889),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBadge(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 7,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
