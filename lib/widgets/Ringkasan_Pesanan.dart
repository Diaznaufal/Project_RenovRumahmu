import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Provider/Cart_Provider.dart';
import '../models/product_cart.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class RingkasanPesanan extends StatelessWidget {
  final CartItemModel item;
  final String itemKey;

  const RingkasanPesanan({Key? key, required this.item, required this.itemKey})
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.product.name,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff808080),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "${item.selectedSize}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ),

                          Wrap(
                            spacing: 6,
                            children: [
                              if (item.product.isBestSeller)
                                buildBadge("Best Seller", Colors.green),
                              if (item.product.isDiscount)
                                buildBadge("Discount", Colors.red),
                            ],
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formatRupiah.format(item.totalPrice),
                                style: TextStyle(
                                  color: Color(0xff226889),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                            ],
                          ),

                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: Color(0xff226889),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<CartProvider>().decreaseQty(
                                    item,
                                  );
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              children: [
                                Text(
                                  item.quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 2,
                                  color: Colors.grey,
                                  margin: EdgeInsets.only(top: 1),
                                ),
                              ],
                            ),

                            SizedBox(width: 8),
                            Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: Color(0xff226889),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<CartProvider>().increaseQty(
                                    item,
                                  );
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 14,
                                  color: Colors.white,
                                ),
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
